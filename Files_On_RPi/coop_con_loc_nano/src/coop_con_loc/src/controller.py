#!/usr/bin/env python3
import rospy
import numpy as np
import math
import time
import json
from std_msgs.msg import String
from termcolor import colored
from quaternion import quaternion
from sliding_differentiator import slid_diff

Results_File_Cont_Pos = open(r"/root/logs/Results_File_Cont_Pos.txt","w+")
Results_File_Cont_Vel = open(r"/root/logs/Results_File_Cont_Vel.txt","w+")
Results_File_NED_CON = open(r"/root/logs/Results_File_NED_CON.txt","w+")

data_NED = {}
data_Att_StP = {}
data_Orient = {}

# ducky: Getting values from launch file. Example:
# $ roslaunch coop_con_loc ducky.launch kp_x:=0.5 kp_x:=0.5 kp_x:=0.5
#Proportionsl Gain
kpx_ = rospy.get_param("/controller/kp_x")
kpy_ = rospy.get_param("/controller/kp_y")
kpz_ = rospy.get_param("/controller/kp_z")

kvx_ = rospy.get_param("/controller/kv_x")
kvy_ = rospy.get_param("/controller/kv_y")
kvz_ = rospy.get_param("/controller/kv_z")

#Integral Gain
kix_ = rospy.get_param("/controller/ki_x")
kiy_ = rospy.get_param("/controller/ki_y")
kiz_ = rospy.get_param("/controller/ki_z")

kvi_x_ = rospy.get_param("/controller/kvi_x")
kvi_y_ = rospy.get_param("/controller/kvi_y")
kvi_z_ = rospy.get_param("/controller/kvi_z")

#Derivative Gain
kdx_ = rospy.get_param("/controller/kd_x")
kdy_ = rospy.get_param("/controller/kd_y")
kdz_ = rospy.get_param("/controller/kd_z")

kvd_x_ = rospy.get_param("/controller/kvd_x")
kvd_y_ = rospy.get_param("/controller/kvd_y")
kvd_z_ = rospy.get_param("/controller/kvd_z")

#Setpoints
x_StP = rospy.get_param("/controller/xd_StP")
y_StP = rospy.get_param("/controller/yd_StP")
z_StP = rospy.get_param("/controller/zd_StP")

maxv_ = rospy.get_param("/controller/max_v")
pitch_bias_ = rospy.get_param("/controller/pitch_bias")
roll_bias_ = rospy.get_param("/controller/roll_bias")

#Threshold.
integral_threshold_x_ = rospy.get_param("/controller/integral_threshold_x")
integral_threshold_y_ = rospy.get_param("/controller/integral_threshold_y")
integral_threshold_z_ = rospy.get_param("/controller/integral_threshold_z")

integral_threshold_vx_ = rospy.get_param("/controller/integral_threshold_vx")
integral_threshold_vy_ = rospy.get_param("/controller/integral_threshold_vy")
integral_threshold_vz_ = rospy.get_param("/controller/integral_threshold_vz")

# (END)

def clean_shutdown():
	Results_File_Cont_Pos.close()
	Results_File_Cont_Vel.close()
	Results_File_NED_CON.close()
	print(colored("controller is stopped!","green"))


def callback_NED(data):
	global data_NED
	data_NED = json.loads(data.data)


def callback_Orient(data):
	global data_Orient
	data_Orient = json.loads(data.data)


def controller():
	thrust_StP = 0.0
	quat_StP = [0.0]*4
	pos_NED_m = [0.0,0.0,0.0]
	vel_NED_mps = [0.0,0.0,0.0]
	time_stmp = 0.0

	kp_x = kpx_
	kp_y = kpy_
	kp_z = kpz_
	kv_x = kvx_
	kv_y = kvy_
	kv_z = kvz_
	ki_x = kix_
	ki_y = kiy_
	ki_z = kiz_
	kdx = kdx_
	kdy = kdy_
	kdz = kdz_
	kvd_x = kvd_x_
	kvd_y = kvd_y_
	kvd_z = kvd_z_
	kvi_x = kvi_x_
	kvi_y = kvi_y_
	kvi_z = kvi_z_
	max_v = maxv_

	ei_x = 0.0
	ei_y = 0.0
	ei_z = 0.0
	evi_x = 0.0
	evi_y = 0.0
	evi_z = 0.0

	error_previous_x = 0.0
	error_previous_y = 0.0
	error_previous_z = 0.0

	error_previous_vx = 0.0
	error_previous_vy = 0.0
	error_previous_vz = 0.0

	edx_var1 = 0.0
	edx_var2 = 0.0
	edy_var1 = 0.0
	edy_var2 = 0.0
	edz_var1 = 0.0
	edz_var2 = 0.0

	evdx_var1 = 0.0
	evdx_var2 = 0.0
	evdy_var1 = 0.0
	evdy_var2 = 0.0
	evdz_var1 = 0.0
	evdz_var2 = 0.0

	max_att = np.pi/20.0
	thrust_cmd_max = 0.34
	data_NED_received = False
	time_stmp = 0.0
	rospy.init_node("controller",anonymous=True)
	rate = rospy.Rate(120)
	rospy.on_shutdown(clean_shutdown)
	pub_Attitude_SetPoints = rospy.Publisher("Att_StP", String, queue_size=1)
	publish_data_Att_StP = String()
	rospy.sleep(20.0)
	time_stmp_origin = float(rospy.get_time())
	while not rospy.is_shutdown():		
		rate.sleep()		
		#--------------------------------------------------------------------------------------------------------------------------
		#(START) measuring the frequency of the controller
		Period = float(rospy.get_time()) - time_stmp
		Frequency = 1.0/Period
#		print(colored(("Frequency of controller: %.2f Hz" %Frequency),"red"))
		time_stmp = float(rospy.get_time())
		#(END) measuring the frequency of the controller
		#--------------------------------------------------------------------------------------------------------------------------
		#(START) NED position set-points
		time_traject = time_stmp - time_stmp_origin
		xd_StP = x_StP
		yd_StP = y_StP
		zd_StP = z_StP
#		xd_StP = pos_NED_m[0]
#		yd_StP = pos_NED_m[1]
#		zd_StP = z_StP
#		if ((time_traject > 30.0) and (time_traject < 40.0)):
#			xd_StP = pos_NED_m[0] + (0.1 * (time_traject - 30.0))
#			yd_StP = pos_NED_m[1]
#		if ((time_traject > 40.0) and (time_traject < 50.0)):
#			xd_StP = pos_NED_m[0]
#			yd_StP = pos_NED_m[1] + (0.1 * (time_traject - 40.0))
		#(END) NED position set-points
		#---------------------------------------------------------------------------------------------------------------------
		#(START) subscribing to estimated position and velocity data
		data_NED_received = False
		rospy.Subscriber("NED_POS_VEL", String, callback_NED, queue_size=1)
		if not data_NED:
			print(colored("Controller: No estimated position and velocity.","red"))
		else:
			data_NED_received = True
			pos_NED_m[0] = data_NED.get("px")
			pos_NED_m[1] = data_NED.get("py")
			pos_NED_m[2] = data_NED.get("pz")
			vel_NED_mps[0] = data_NED.get("vx")
			vel_NED_mps[1] = data_NED.get("vy")
			vel_NED_mps[2] = data_NED.get("vz")
			Results_File_NED_CON.write("%.6f %.3f %.3f %.3f %.3f %.3f %.3f\r\n" % (rospy.get_time(),pos_NED_m[0],pos_NED_m[1],pos_NED_m[2],vel_NED_mps[0],vel_NED_mps[1],vel_NED_mps[2]))
		#(END) subscribing to estimated position and velocity data
		#--------------------------------------------------------------------------------------------------------------------------
		#(START) subscribing to the orientation message from PX4
		drone_yaw_rad = 0.0
		rospy.Subscriber("PX4_Orient", String, callback_Orient, queue_size=1)
		if not data_Orient:
			print(colored("Controller: No orientation data received.","red"))
		else:
			quat_x = data_Orient.get("quat_x")
			quat_y = data_Orient.get("quat_y")
			quat_z = data_Orient.get("quat_z")
			quat_w = data_Orient.get("quat_w")
			siny_cosp = (2.0 * (quat_w * quat_z + quat_x * quat_y))
			cosy_cosp = (1.0 - 2.0 * (quat_y * quat_y + quat_z * quat_z))
			drone_yaw_rad = math.atan2(siny_cosp, cosy_cosp)
		#(END) subscribing to the orientation message from PX4
		#--------------------------------------------------------------------------------------------------------------------------
		if data_NED_received:

			dt = Period
			#--------------------------------------------------------------------------------------------------------------------------
			#(START) Position controller
			ep_x = xd_StP - pos_NED_m[0]
			ep_y = yd_StP - pos_NED_m[1]
			ep_z = zd_StP - pos_NED_m[2]

			ei_x = ei_x + ep_x * dt
			ei_y = ei_y + ep_y * dt
			ei_z = ei_z + ep_z * dt

			if ei_x > integral_threshold_x_:
				ei_x = 0.0

			if ei_y > integral_threshold_y_:
				ei_y = 0.0

			if ei_z > integral_threshold_z_:
				ei_z = 0.0

			ed_x,edx_var1,edx_var2 = slid_diff(ep_x,edx_var1,edx_var2,Period)
			ed_y,edy_var1,edy_var2 = slid_diff(ep_y,edy_var1,edy_var2,Period)
			ed_z,edz_var1,edz_var2 = slid_diff(ep_z,edz_var1,edz_var2,Period)

			error_previous_x = ep_x
			error_previous_y = ep_y
			error_previous_z = ep_z

			vd_x = kp_x * ep_x + ki_x * ei_x + kdx * ed_x
			vd_y = kp_y * ep_y + ki_y * ei_y + kdy * ed_y
			vd_z = kp_z * ep_z + ki_z * ei_z + kdz * ed_z

			vx_StP = np.clip(vd_x,-max_v,max_v)
			vy_StP = np.clip(vd_y,-max_v,max_v)
			vz_StP = np.clip(vd_z,-max_v,max_v)
			Results_File_Cont_Pos.write("%.6f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f\r\n" % (rospy.get_time(),ep_x,ep_y,ep_z,vd_x,vd_y,vd_z,vx_StP,vy_StP,vz_StP))

			#(END) Position controller
			#--------------------------------------------------------------------------------------------------------------------------			
			#(START) Velocity controller
			ev_x = vx_StP - vel_NED_mps[0]
			ev_y = vy_StP - vel_NED_mps[1]
			ev_z = vz_StP - vel_NED_mps[2]

			#(START) convert the velocity set-point from NED frame to the body frame
			ev_x_BODY = (ev_x*np.cos(drone_yaw_rad)) + (ev_y*np.sin(drone_yaw_rad))
			ev_y_BODY = -(ev_x*np.sin(drone_yaw_rad)) + (ev_y*np.cos(drone_yaw_rad))
			ev_z_BODY = ev_z
			#(END) convert the velocity set-point from NED frame to the body frame

			evi_x = evi_x + ev_x * dt
			evi_y = evi_y + ev_y * dt
			evi_z = evi_z + ev_z * dt

			if np.abs(evi_x) > integral_threshold_vx_:
				evi_x = 0.0

			if np.abs(evi_y) > integral_threshold_vy_:
				evi_y = 0.0

			if np.abs(evi_z) > integral_threshold_vz_:
				evi_z = 0.0

			evd_x,evdx_var1,evdx_var2 = slid_diff(ev_x,evdx_var1,evdx_var2,Period)
			evd_y,evdy_var1,evdy_var2 = slid_diff(ev_y,evdy_var1,evdy_var2,Period)
			evd_z,evdz_var1,evdz_var2 = slid_diff(ev_z,evdz_var1,evdz_var2,Period)

			error_previous_vx = ev_x
			error_previous_vy = ev_y
			error_previous_vz = ev_z

			pitch_cmd = - (kv_x * ev_x + kvd_x * evd_x) # + kvi_x * evi_x)
			roll_cmd = + (kv_y * ev_y + kvd_y * evd_y) # + kvi_y * evi_y)
			yaw_cmd = 0.0
			thrust_cmd = - (kv_z * ev_z + kvd_z * evd_z) # + kvi_z * evi_z)

			pitch_StP = np.clip(pitch_cmd,-max_att,max_att) + pitch_bias_
			roll_StP = np.clip(roll_cmd,-max_att,max_att) + roll_bias_
			yaw_StP = yaw_cmd
			thrust_StP = np.clip(thrust_cmd,0.0,thrust_cmd_max) + (1.00 - thrust_cmd_max)

			quat_StP = quaternion(roll_StP,pitch_StP,yaw_StP)
			Results_File_Cont_Vel.write("%.6f %.3f %.3f %.3f %.3f %.3f %.3f %.3f\r\n" % (rospy.get_time(),ev_x,ev_y,ev_z,pitch_cmd,roll_cmd,thrust_cmd,thrust_StP))
			#print("thrusts: %.3f , %.3f" % (thrust_cmd,thrust_StP))
			#(END) Velocity controller
			#--------------------------------------------------------------------------------------------------------------------------
			#(START) publishing the attitude setpoints
			data_Att_StP = {'thrust_stp':thrust_StP,'quat_stp_w':quat_StP[0],'quat_stp_x':quat_StP[1],'quat_stp_y':quat_StP[2],'quat_stp_z':quat_StP[3]}
			publish_data_Att_StP.data = json.dumps(data_Att_StP)
			pub_Attitude_SetPoints.publish(publish_data_Att_StP)
			#(END) publishing the attitude setpoints
			#--------------------------------------------------------------------------------------------------------------------

if __name__ == '__main__':
	try:
		controller()
	except (rospy.ROSInterruptException, rospy.ServiceException, rospy.ROSException):
		pass
