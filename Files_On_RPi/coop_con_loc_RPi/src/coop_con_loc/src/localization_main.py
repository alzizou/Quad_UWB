#!/usr/bin/env python3
import rospy
import time
import numpy as np
import json
from std_msgs.msg import String
from termcolor import colored
from localization import localization
#from localization_ML import localization
#from ekf import EKF
from ekf_dist import EKF_DIST
#from ekf_dist_jerk import EKF_DIST

Results_File_py = open(r"/root/logs/Results_File_py.txt","w+")
#Results_File_EST = open(r"/root/coop_con_loc_RPi/src/coop_con_loc/src/Results_File_EST.txt","w+")
#Results_File_Freq_Pos = open(r"/root/coop_con_loc_RPi/src/coop_con_loc/src/Results_File_Freq_Pos.txt","w+")
#Results_File_NED_LOC = open(r"/root/coop_con_loc_RPi/src/coop_con_loc/src/Results_File_NED_LOC.txt","w+")

data_Pos_UWB = {}
data_Vel_NED = {}
data_NED = {}
data_ACC = {}
data_DIST = {}

#------------------------------------------------------------------------
#Anchors Information
Num_Anchors = 8
All_Anchors = np.zeros([3,Num_Anchors])
All_Anchors[0:3,0] = [-500,0,250] #A
All_Anchors[0:3,1] = [4880,0,250] #B
All_Anchors[0:3,2] = [0,5920,280] #C
All_Anchors[0:3,3] = [5590,5790,400] #D
All_Anchors[0:3,4] = [0,0,2290] #E
All_Anchors[0:3,5] = [4880,0,2240] #F
All_Anchors[0:3,6] = [0,5920,2390] #G
All_Anchors[0:3,7] = [5260,5790,2290] #H
#-----------------------------------------------------------------------

def clean_shutdown():
	Results_File_py.close()
#	Results_File_EST.close()
#	Results_File_Freq_Pos.close()
#	Results_File_NED_LOC.close()
	print(colored("localization stopped!","green"))

def callback_ACC(data):
	global data_ACC
	data_ACC = json.loads(data.data)

def callback_DIST(data):
	global data_DIST
	data_DIST = json.loads(data.data)

def callback_Vel_NED(data):
	global data_Vel_NED
	data_Vel_NED = json.loads(data.data)

def localization_main():

	DIST = [0]*Num_Anchors
	X = np.zeros([3,1])
	pos_z_Flt = 0.0
	X_m = np.zeros([3,1])
	X_new = np.zeros([3,1])
#	pos_NED_m = np.zeros([3,1])
#	vel_NED_m = np.zeros([3,1])
	Acc_m = np.zeros([3,1])
	time_stmp = 0.0
	x_hat_KF_z = np.zeros([3,1])
	P_KF_z = np.eye(3)
#	x_hat_KF_z = np.zeros([4,1]) # Using KF based on constant jerk
#	P_KF_z = np.eye(4) # Using KF based on constant jerk
	x_hat_EKF = np.zeros([6,1])
	P_EKF = np.eye(6)
	publish_data_NED = String()
	publish_data_Pos_UWB = String()
	psi_coordinate_conversion = 35.0 * np.pi / 180.0 #angle between North and X axis of the UWB system

	Diff_Accept_XY = 2000
	Diff_Accept_Z = 2000

	rospy.init_node("localization_py",anonymous=True)
	rate = rospy.Rate(30)
	rospy.on_shutdown(clean_shutdown)
	pub_Pos_UWB = rospy.Publisher("Pos_UWB", String, queue_size = 20)
	pub_NED = rospy.Publisher("NED_POS_VEL", String, queue_size = 20)
	while not rospy.is_shutdown():
		rate.sleep()
		#--------------------------------------------------------------------------------------------------------------------
		#(START) subscribing to all collected distances
		rospy.Subscriber("ALL_DIST", String, callback_DIST)
		if not data_DIST:
			print("No distances are received!")
		else:
			DIST = data_DIST.get("DIST")
		#(END) subscribing to all collected distances
		#--------------------------------------------------------------------------------------------------------------------
		#(START) measuring the frequency of the localziation estimation process
		Period = float(rospy.get_time()) - time_stmp
		Frequency = 1.0/Period
		print(colored(("Frequency of position estimation: %f Hz" %Frequency),"green"))
#		Results_File_Freq_Pos.write("%.2f\r\n" % Frequency)
		Period_EKF = Period
		if (time_stmp<1.0):
			Period_EKF = 0.0
		time_stmp = float(rospy.get_time())
		#(END) measuring the frequency of the localziation estimation process
		#---------------------------------------------------------------------------------------------------------------------
		#(START) doing localization
		X_new = localization(DIST,X,Num_Anchors,All_Anchors)
		if ((X[0]==0) and (X[1]==0) and (X[2]==0)):
			X = X_new
		if ((abs(X[0]-X_new[0])<Diff_Accept_XY) and (abs(X[1]-X_new[1])<Diff_Accept_XY) and (abs(X[2]-X_new[2])<Diff_Accept_Z)):
			X = X_new
		#(END) doing localization
		#---------------------------------------------------------------------------------------------------------------------
		#(START) Kalman filter on z-axis estimation
		Period_KF = Period_EKF
		x_hat_KF_z,P_KF_z = EKF_DIST(X[2],x_hat_KF_z,P_KF_z,Period_KF)
		pos_z_Flt = x_hat_KF_z[0]
		#(END) Kalman filter on z-axis estimation
		#--------------------------------------------------------------------------------------------------------------------
		#(START) logging localization data
		Results_File_py.write("%d %d %d %d\r\n" % (rospy.get_time(),X[0],X[1],X[2])) #pos_z_Flt
		#print(colored(("Estimated Position(mm): %d %d %d" % (X[0],X[1],pos_z_Flt)),"green"))
		X_m[0] = 0.001*X[0]
		X_m[1] = 0.001*X[1]
		X_m[2] = 0.001*pos_z_Flt #X[2]
		#(END) logging localization data
		#--------------------------------------------------------------------------------------------------------------------
		#(START) publishing estimated local position in UWB frame
#		data_Pos_UWB = {"x_UWB_mm": X[0][0], "y_UWB_mm": X[1][0], "z_UWB_mm": pos_z_Flt[0]} #X[2][0]
#		publish_data_Pos_UWB.data = json.dumps(data_Pos_UWB)
#		pub_Pos_UWB.publish(publish_data_Pos_UWB)
		#(END) publishing estimated local position in UWB frame
		#--------------------------------------------------------------------------------------------------------------------
		#(START) converting the estimated UWB position to the local NED frame
#		x_m_NED = (X_m[0][0]*np.cos(psi_coordinate_conversion)) + (X_m[1][0]*np.sin(psi_coordinate_conversion))
#		y_m_NED = (X_m[0][0]*np.sin(psi_coordinate_conversion)) - (X_m[1][0]*np.cos(psi_coordinate_conversion))
#		z_m_NED = -X_m[2][0]
		#(END) converting the estimated UWB position to the local NED frame
		#--------------------------------------------------------------------------------------------------------------------
		#(START) subscribing to the estimated velocity in local NED frame
#		vx_NED_m = 0.0
#		vy_NED_m = 0.0
#		vz_NED_m = 0.0
#		rospy.Subscriber("Vel_NED", String, callback_Vel_NED)
#		if not data_Vel_NED:
#			print("No estimated NED local velocity is received!")
#		else:
#			vx_NED_m = data_Vel_NED.get("vx_NED_m")
#			vy_NED_m = data_Vel_NED.get("vy_NED_m")
#			vz_NED_m = data_Vel_NED.get("vz_NED_m")
		#(END) subscribing to the estimated velocity in local NED frame
		#--------------------------------------------------------------------------------------------------------------------		
		#(START) subscribing to PX4 acceleration measurement
#		rospy.Subscriber("PX4_ACC", String, callback_ACC)
#		if not data_ACC:
#			print("No acceleration data is received!")
#		else:
#			Acc_m[0] = data_ACC.get("ax")
#			Acc_m[1] = data_ACC.get("ay")
#			Acc_m[2] = data_ACC.get("az")
		#(END) subscribing to PX4 acceleration measurement
		#--------------------------------------------------------------------------------------------------------------------
		#(START) extended Kalman filter (EKF)
#		x_hat_EKF,P_EKF = EKF(X_m,Acc_m,x_hat_EKF,P_EKF,Period_EKF)
#		print(colored(("My EKF estimations: %.3f , %.3f , %.3f , %.3f , %.3f , %.3f" % (x_hat_EKF[0],x_hat_EKF[1],x_hat_EKF[2],x_hat_EKF[3],x_hat_EKF[4],x_hat_EKF[5])),"green"))
#		Results_File_EST.write("%.3f %.3f %.3f %.3f %.3f %.3f\r\n" % (x_hat_EKF[0],x_hat_EKF[1],x_hat_EKF[2],x_hat_EKF[3],x_hat_EKF[4],x_hat_EKF[5]))
		#(END) extended Kalman filter (EKF)
		#--------------------------------------------------------------------------------------------------------------------
		#(START) publishing estimated local position and velocity in local NED frame
		#data_NED = {"px":x_hat_EKF[0][0] , "py":x_hat_EKF[1][0] , "pz":x_hat_EKF[2][0] , "vx":x_hat_EKF[3][0] , "vy":x_hat_EKF[4][0] , "vz":x_hat_EKF[5][0]}		
#		Results_File_NED_LOC.write("%d %.3f %.3f %.3f %.3f %.3f %.3f\r\n" % (rospy.get_time(),x_m_NED,y_m_NED,z_m_NED,vx_NED_m,vy_NED_m,vz_NED_m))
#		data_NED = {"px":x_m_NED , "py":y_m_NED , "pz":z_m_NED , "vx":vx_NED_m , "vy":vy_NED_m , "vz":vz_NED_m}
#		publish_data_NED.data = json.dumps(data_NED)
#		pub_NED.publish(publish_data_NED)
		#(END) publishing estimated local position and velocity in local NED frame
		#--------------------------------------------------------------------------------------------------------------------


if __name__ == '__main__':
	try:
		localization_main()
	except (rospy.ROSInterruptException, rospy.ServiceException, rospy.ROSException):
		pass

