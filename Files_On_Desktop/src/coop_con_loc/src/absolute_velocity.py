#!/usr/bin/env python3
import rospy
import numpy as np
import time
import json
from std_msgs.msg import String
from termcolor import colored
from velocitization import velocitization
from sliding_differentiator import slid_diff

Results_File_Diff_DIST = open(r"/home/ali/My_Localization_Folder/testing-dwm1001-dev-modules/Files_On_Desktop/src/coop_con_loc/src/Results_File_Diff_DIST.txt","w+")
Results_File_delta = open(r"/home/ali/My_Localization_Folder/testing-dwm1001-dev-modules/Files_On_Desktop/src/coop_con_loc/src/Results_File_delta.txt","w+")
Results_File_Diff_delta = open(r"/home/ali/My_Localization_Folder/testing-dwm1001-dev-modules/Files_On_Desktop/src/coop_con_loc/src/Results_File_Diff_delta.txt","w+")
Results_File_ABS_VEL = open(r"/home/ali/My_Localization_Folder/testing-dwm1001-dev-modules/Files_On_Desktop/src/coop_con_loc/src/Results_File_ABS_VEL.txt","w+")
Results_File_Freq_Vel = open(r"/home/ali/My_Localization_Folder/testing-dwm1001-dev-modules/Files_On_Desktop/src/coop_con_loc/src/Results_File_Freq_Vel.txt","w+")

data_Pos_UWB = {}
data_DIST = {}
data_Vel_NED = {}

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
	Results_File_Diff_DIST.close()
	Results_File_Diff_delta.close()
	Results_File_delta.close()
	Results_File_ABS_VEL.close()
	Results_File_Freq_Vel.close()
	print(colored("Absolute velocity estimation is stopped!","green"))

def callback_Pos_UWB(data):
	global data_Pos_UWB
	data_Pos_UWB = json.loads(data.data)

def callback_DIST(data):
	global data_DIST
	data_DIST = json.loads(data.data)

def absolute_velocity():
	DIST = [0]*Num_Anchors
	Diff_DIST = [0]*Num_Anchors
	Diff_variable1 = [0]*Num_Anchors
	Diff_variable2 = [0]*Num_Anchors
	delta_Euclidean = [0]*Num_Anchors
	Diff_delta = [0]*Num_Anchors
	Diff_delta_variable1 = [0]*Num_Anchors
	Diff_delta_variable2 = [0]*Num_Anchors
	Pos_UWB_X = [0]*3 #np.zeros([3,1])
	Abs_Vel = [0]*3
	Abs_Vel_m = [0]*3
	Diff_Accept_XY = 2000
	Diff_Accept_Z = 2000
	time_stmp = 0.0
	psi_coordinate_conversion = 35.0 * np.pi / 180.0 #angle between North and X axis of the UWB system
	publish_data_Vel_NED = String()

	rospy.init_node("absolute_velocity",anonymous=True)
	rate = rospy.Rate(1000)
	rospy.on_shutdown(clean_shutdown)
	pub_Vel_NED = rospy.Publisher("Vel_NED", String, queue_size = 20)

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
		#(START) subscribing to the estimated position in UWB frame
		rospy.Subscriber("Pos_UWB", String, callback_Pos_UWB)
		if not data_Pos_UWB:
			print("No estimated UWB position is received!")
		else:
			Pos_UWB_X = data_Pos_UWB.get("Pos_UWB_mm")
		#(END) subscribing to the estimated position in UWB frame
		#--------------------------------------------------------------------------------------------------------------------
		#(START) Computing the errors on Euclidean distances
		for i in range(0,Num_Anchors):
		    delta_Euclidean[i] = ((Pos_UWB_X[0] - All_Anchors[0][i])**2) + ((Pos_UWB_X[1] - All_Anchors[1][i])**2) + ((Pos_UWB_X[2] - All_Anchors[2][i])**2) - (DIST[i]**2)
		Results_File_delta.write("%d %d %d %d %d %d %d %d\r\n" % (delta_Euclidean[0],delta_Euclidean[1],delta_Euclidean[2],delta_Euclidean[3],delta_Euclidean[4],delta_Euclidean[5],delta_Euclidean[6],delta_Euclidean[7]))
		#(END) Computing the errors on Euclidean distances
		#--------------------------------------------------------------------------------------------------------------------
		#(START) measuring the frequency of the localziation and velocity estimation process
		Period = float(rospy.get_time()) - time_stmp
		Frequency = 1.0/Period
		print(colored(("Frequency of velocity estimation: %f Hz" %Frequency),"green"))
		Results_File_Freq_Vel.write("%.2f\r\n" % Frequency)
		Period_EKF = Period
		if (time_stmp<1.0):
			Period_EKF = 0.0
		time_stmp = float(rospy.get_time())
		#(END) measuring the frequency of the localziation and velocity estimation process
		#---------------------------------------------------------------------------------------------------------------------
		#(START) computing the time-derivation of the measured distances
		for i in range(0,Num_Anchors):
			if DIST[i]>0:
				Diff_DIST[i],Diff_variable1[i],Diff_variable2[i] = slid_diff(DIST[i],Diff_variable1[i],Diff_variable2[i],Period_EKF)
				Diff_delta[i],Diff_delta_variable1[i],Diff_delta_variable2[i] = slid_diff(delta_Euclidean[i],Diff_delta_variable1[i],Diff_delta_variable2[i],Period_EKF)
		Results_File_Diff_DIST.write("%d %d %d %d %d %d %d %d\r\n" % (Diff_DIST[0],Diff_DIST[1],Diff_DIST[2],Diff_DIST[3],Diff_DIST[4],Diff_DIST[5],Diff_DIST[6],Diff_DIST[7]))
		Results_File_Diff_delta.write("%d %d %d %d %d %d %d %d\r\n" % (Diff_delta[0],Diff_delta[1],Diff_delta[2],Diff_delta[3],Diff_delta[4],Diff_delta[5],Diff_delta[6],Diff_delta[7]))
		#(END) computing the time-derivation of the measured distances
		#---------------------------------------------------------------------------------------------------------------------
		#(START) doing absolute velocity estimation
		Abs_Vel_new = velocitization(Diff_DIST,DIST,Diff_delta,Pos_UWB_X,Abs_Vel,Num_Anchors,All_Anchors)
		if ((Abs_Vel[0]==0) and (Abs_Vel[1]==0) and (Abs_Vel[2]==0)):
			Abs_Vel = Abs_Vel_new
		if ((abs(Abs_Vel[0]-Abs_Vel_new[0])<Diff_Accept_XY) and (abs(Abs_Vel[1]-Abs_Vel_new[1])<Diff_Accept_XY) and (abs(Abs_Vel[2]-Abs_Vel_new[2])<Diff_Accept_Z)):
			Abs_Vel = Abs_Vel_new
		Results_File_ABS_VEL.write("%d %d %d %d\r\n" % (rospy.get_time(),Abs_Vel[0],Abs_Vel[1],Abs_Vel[2]))
		print(colored(("Estimated velocity (mm/sec): %d %d %d" % (Abs_Vel[0],Abs_Vel[1],Abs_Vel[2])),"green"))
		Abs_Vel_m[0] = 0.001*Abs_Vel[0]
		Abs_Vel_m[1] = 0.001*Abs_Vel[1]
		Abs_Vel_m[2] = 0.001*Abs_Vel[2]
		#(END) doing absolute velocity estimation
		#--------------------------------------------------------------------------------------------------------------------
		#(START) converting the estimated UWB velocity to the local NED frame
		vx_NED_m = (Abs_Vel_m[0]*np.cos(psi_coordinate_conversion)) + (Abs_Vel_m[1]*np.sin(psi_coordinate_conversion))
		vy_NED_m = (Abs_Vel_m[0]*np.sin(psi_coordinate_conversion)) - (Abs_Vel_m[1]*np.cos(psi_coordinate_conversion))
		vz_NED_m = -Abs_Vel_m[2]
		#(END) converting the estimated UWB velocity to the local NED frame
		#--------------------------------------------------------------------------------------------------------------------
		#(START) publishing estimated absolute velocity in local NED frame
		data_Vel_NED = {"vx_NED_m":vx_NED_m, "vy_NED_m":vy_NED_m, "vz_NED_m":vz_NED_m}
		publish_data_Vel_NED.data = json.dumps(data_Vel_NED)
		pub_Vel_NED.publish(publish_data_Vel_NED)
		#(END) publishing estimated absolute velocity in local NED frame
		#---------------------------------------------------------------------------------------------------------------------


if __name__ == '__main__':
	try:
		absolute_velocity()
	except (rospy.ROSInterruptException, rospy.ServiceException, rospy.ROSException):
		pass
