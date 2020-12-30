#!/usr/bin/env python3
import rospy
import numpy as np
import time
import json
from std_msgs.msg import String
from termcolor import colored
from quaternion import quaternion
from AMFC import AMFC
from sliding_differentiator import slid_diff

Results_File_Cont_Pos_AMFC = open(r"/root/logs/Results_File_Cont_Pos_AMFC.txt","w+")
Results_File_Cont_Vel_AMFC = open(r"/root/logs/Results_File_Cont_Vel_AMFC.txt","w+")
Results_File_NED_CON_AMFC = open(r"/root/logs/Results_File_NED_CON_AMFC.txt","w+")

data_NED = {}
data_Att_StP = {}

#Setpoints
x_StP = rospy.get_param("/controller/xd_StP")
y_StP = rospy.get_param("/controller/yd_StP")
z_StP = rospy.get_param("/controller/zd_StP")

pitch_bias_ = rospy.get_param("/controller/pitch_bias")
roll_bias_ = rospy.get_param("/controller/roll_bias")

Q_p_ = rospy.get_param("/controller/Q_p")
Gamma1_p_ = rospy.get_param("/controller/Gamma1_p")
Gamma2_p_ = rospy.get_param("/controller/Gamma2_p")
rho1_p_ = rospy.get_param("/controller/rho1_p")
rho2_p_ = rospy.get_param("/controller/rho2_p")

Q_v_ = rospy.get_param("/controller/Q_v")
Gamma1_v_ = rospy.get_param("/controller/Gamma1_v")
Gamma2_v_ = rospy.get_param("/controller/Gamma2_v")
rho1_v_ = rospy.get_param("/controller/rho1_v")
rho2_v_ = rospy.get_param("/controller/rho2_v")

def clean_shutdown():
	Results_File_Cont_Pos_AMFC.close()
	Results_File_Cont_Vel_AMFC.close()
	Results_File_NED_CON_AMFC.close()
	print(colored("AMFC controller is stopped!","green"))


def callback_NED(data):
	global data_NED
	data_NED = json.loads(data.data)


def controller_AMFC():
	thrust_StP = 0.0
	quat_StP = [0.0]*4
	pos_NED_m = [0.0,0.0,0.0]
	vel_NED_mps = [0.0,0.0,0.0]
	time_stmp = 0.0

	#---------------------------------------------------------------------------------------------------
	#(START) Gains for the AMFC position and velocity controllers
	Q_p = Q_p_
	Gamma1_p = Gamma1_p_
	Gamma2_p = Gamma2_p_
	rho1_p = rho1_p_
	rho2_p = rho2_p_

	Q_v = Q_v_
	Gamma1_v = Gamma1_v_
	Gamma2_v = Gamma2_v_
	rho1_v = rho1_v_
	rho2_v = rho2_v_
	#(END)
	#-------------------------------------------------------------------------------------------------
	#(START) Initializing variables for AMFC position and velocity controllers
	variable1_dif_px = 0.0
	variable2_dif_px = 0.0
	err_px = 0.0
	err_int_px = 0.0
	A_hat_px = 0.0
	g_hat_px = 0.0
	P_px = 1.0
	y_dif_px = 0.0
	int_Delta_px = 0.0

	variable1_dif_py = 0.0
	variable2_dif_py = 0.0
	err_py = 0.0
	err_int_py = 0.0
	A_hat_py = 0.0
	g_hat_py = 0.0
	P_py = 1.0
	y_dif_py = 0.0
	int_Delta_py = 0.0

	variable1_dif_pz = 0.0
	variable2_dif_pz = 0.0
	err_pz = 0.0
	err_int_pz = 0.0
	A_hat_pz = 0.0
	g_hat_pz = 0.0
	P_pz = 1.0
	y_dif_pz = 0.0
	int_Delta_pz = 0.0

	variable1_dif_vx = 0.0
	variable2_dif_vx = 0.0
	err_vx = 0.0
	err_int_vx = 0.0
	A_hat_vx = 0.0
	g_hat_vx = 0.0
	P_vx = 1.0
	y_dif_vx = 0.0
	int_Delta_vx = 0.0

	variable1_dif_vy = 0.0
	variable2_dif_vy = 0.0
	err_vy = 0.0
	err_int_vy = 0.0
	A_hat_vy = 0.0
	g_hat_vy = 0.0
	P_vy = 1.0
	y_dif_vy = 0.0
	int_Delta_vy = 0.0

	variable1_dif_vz = 0.0
	variable2_dif_vz = 0.0
	err_vz = 0.0
	err_int_vz = 0.0
	A_hat_vz = 0.0
	g_hat_vz = 0.0
	P_vz = 1.0
	y_dif_vz = 0.0
	int_Delta_vz = 0.0
	#(END) Initializing variables for AMFC position and velocity controllers
	#---------------------------------------------------------------------------------------------------

	max_vel = 0.5
	max_att = np.pi/10.0
	thrust_cmd_max = 0.44
	data_NED_received = False
	time_stmp = 0.0
	rospy.init_node("controller",anonymous=True)
	rate = rospy.Rate(30)
	rospy.on_shutdown(clean_shutdown)
	pub_Attitude_SetPoints = rospy.Publisher("Att_StP", String, queue_size=20)
	publish_data_Att_StP = String()
	rospy.sleep(20.0)
	while not rospy.is_shutdown():
		rate.sleep()
		#--------------------------------------------------------------------------------------------------------------------------
		#(START) NED position set-points
		xd_StP = x_StP
		yd_StP = y_StP
		zd_StP = z_StP
		#(END) NED position set-points
		#--------------------------------------------------------------------------------------------------------------------------
		#(START) measuring the frequency of the controller
		Period = float(rospy.get_time()) - time_stmp
		Frequency = 1.0/Period
		#print(colored(("Frequency of controller: %.2f Hz" %Frequency),"green"))
		time_stmp = float(rospy.get_time())
		#(END) measuring the frequency of the controller
		#---------------------------------------------------------------------------------------------------------------------
		#(START) subscribing to estimated position and velocity data
		rospy.Subscriber("NED_POS_VEL", String, callback_NED)
		data_NED_received = False
		if not data_NED:
			print(colored("AMFC Controller: No estimated position and velocity.","red"))
		else:
			data_NED_received = True
			pos_NED_m[0] = data_NED.get("px")
			pos_NED_m[1] = data_NED.get("py")
			pos_NED_m[2] = data_NED.get("pz")
			vel_NED_mps[0] = data_NED.get("vx")
			vel_NED_mps[1] = data_NED.get("vy")
			vel_NED_mps[2] = data_NED.get("vz")
			Results_File_NED_CON_AMFC.write("%d %.3f %.3f %.3f %.3f %.3f %.3f\r\n" % (rospy.get_time(),pos_NED_m[0],pos_NED_m[1],pos_NED_m[2],vel_NED_mps[0],vel_NED_mps[1],vel_NED_mps[2]))
			#print(colored(("estimated position(m) and velocity(mps): px=%.3f , py=%.3f , pz=%.3f , vx=%.3f , vy=%.3f , vz=%.3f" % (pos_NED_m[0],pos_NED_m[1],pos_NED_m[2],vel_NED_mps[0],vel_NED_mps[1],vel_NED_mps[2])),"green"))
		#(END) subscribing to estimated position and velocity data
		#--------------------------------------------------------------------------------------------------------------------------
		if data_NED_received:
			dt = Period
			#-------------------------------------------------------------------------------------------------------------------
			#(START) AMFC position controller
			y_dif_px,variable1_dif_px,variable2_dif_px = slid_diff(xd_StP,variable1_dif_px,variable2_dif_px,dt)
			y_dif_py,variable1_dif_py,variable2_dif_py = slid_diff(xd_StP,variable1_dif_py,variable2_dif_py,dt)
			y_dif_pz,variable1_dif_pz,variable2_dif_pz = slid_diff(xd_StP,variable1_dif_pz,variable2_dif_pz,dt)

			err_px, err_int_px, P_px, g_hat_px, A_hat_px, int_Delta_px, u_px = AMFC(xd_StP,pos_NED_m[0],err_int_px,A_hat_px,g_hat_px,P_px,y_dif_px,int_Delta_px,Q_p,Gamma1_p,Gamma2_p,rho1_p,rho2_p,dt)
			err_py, err_int_py, P_py, g_hat_py, A_hat_py, int_Delta_py, u_py = AMFC(yd_StP,pos_NED_m[1],err_int_py,A_hat_py,g_hat_py,P_py,y_dif_py,int_Delta_py,Q_p,Gamma1_p,Gamma2_p,rho1_p,rho2_p,dt)
			err_pz, err_int_pz, P_pz, g_hat_pz, A_hat_pz, int_Delta_pz, u_pz = AMFC(zd_StP,pos_NED_m[2],err_int_pz,A_hat_pz,g_hat_pz,P_pz,y_dif_pz,int_Delta_pz,Q_p,Gamma1_p,Gamma2_p,rho1_p,rho2_p,dt)

			vx_StP = np.clip(u_px,-max_vel,+max_vel)
			vy_StP = np.clip(u_py,-max_vel,+max_vel)
			vz_StP = np.clip(u_pz,-max_vel,+max_vel)

			Results_File_Cont_Pos_AMFC.write("%d %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f\r\n" % (rospy.get_time(),err_px,err_py,err_pz,u_px,u_py,u_pz,vx_StP,vy_StP,vz_StP))
			#(END) AMFC position controller
			#-------------------------------------------------------------------------------------------------------------------
			#(START) AMFC velocity controller
			y_dif_vx,variable1_dif_vx,variable2_dif_vx = slid_diff(xd_StP,variable1_dif_vx,variable2_dif_vx,dt)
			y_dif_vy,variable1_dif_vy,variable2_dif_vy = slid_diff(xd_StP,variable1_dif_vy,variable2_dif_vy,dt)
			y_dif_vz,variable1_dif_vz,variable2_dif_vz = slid_diff(xd_StP,variable1_dif_vz,variable2_dif_vz,dt)

			err_vx, err_int_vx, P_vx, g_hat_vx, A_hat_vx, int_Delta_vx, u_vx = AMFC(vx_StP,vel_NED_mps[0],err_int_vx,A_hat_vx,g_hat_vx,P_vx,y_dif_vx,int_Delta_vx,Q_v,Gamma1_v,Gamma2_v,rho1_v,rho2_v,dt)
			err_vy, err_int_vy, P_vy, g_hat_vy, A_hat_vy, int_Delta_vy, u_vy = AMFC(vy_StP,vel_NED_mps[1],err_int_vy,A_hat_vy,g_hat_vy,P_vy,y_dif_vy,int_Delta_vy,Q_v,Gamma1_v,Gamma2_v,rho1_v,rho2_v,dt)
			err_vz, err_int_vz, P_vz, g_hat_vz, A_hat_vz, int_Delta_vz, u_vz = AMFC(vz_StP,vel_NED_mps[2],err_int_vz,A_hat_vz,g_hat_vz,P_vz,y_dif_vz,int_Delta_vz,Q_v,Gamma1_v,Gamma2_v,rho1_v,rho2_v,dt)

			yaw_cmd = 0.0
			pitch_cmd = - u_vx
			roll_cmd = + u_vy
			thrust_cmd = - u_vz
			#(END) AMFC velocity controller
			#-------------------------------------------------------------------------------------------------------------------
			#(START) computing the attitude set-points
			pitch_StP = np.clip(pitch_cmd,-max_att,max_att) + pitch_bias_
			roll_StP = np.clip(roll_cmd,-max_att,max_att) + roll_bias_
			yaw_StP = yaw_cmd
			thrust_StP = np.clip(thrust_cmd,0.0,thrust_cmd_max) + (1.00 - thrust_cmd_max)
			quat_StP = quaternion(roll_StP,pitch_StP,yaw_StP)
			Results_File_Cont_Vel_AMFC.write("%d %.3f %.3f %.3f %.3f %.3f %.3f %.3f\r\n" % (rospy.get_time(),err_vx,err_vy,err_vz,pitch_cmd,roll_cmd,thrust_cmd,thrust_StP))
			#(END) computing the attitude set-points
			#--------------------------------------------------------------------------------------------------------------------------
			#(START) publishing the attitude setpoints
			data_Att_StP = {'thrust_stp':thrust_StP,'quat_stp_w':quat_StP[0],'quat_stp_x':quat_StP[1],'quat_stp_y':quat_StP[2],'quat_stp_z':quat_StP[3]}
			publish_data_Att_StP.data = json.dumps(data_Att_StP)
			pub_Attitude_SetPoints.publish(publish_data_Att_StP)
			#(END) publishing the attitude setpoints
			#--------------------------------------------------------------------------------------------------------------------

if __name__ == '__main__':
	try:
		controller_AMFC()
	except (rospy.ROSInterruptException, rospy.ServiceException, rospy.ROSException):
		pass

