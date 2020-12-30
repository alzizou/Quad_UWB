#!/usr/bin/env python3
import rospy
import numpy as np
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


def controller_lqr():
	thrust_StP = 0.0
	quat_StP = [0.0]*4
	pos_NED_m = [0.0,0.0,0.0]
	vel_NED_mps = [0.0,0.0,0.0]
	time_stmp = 0.0

	Rp_x = 1.0
	Rp_y = 1.0
	Rp_z = 1.0
	Qp_x = 1.0
	Qp_y = 1.0
	Qp_z = 1.0
	Pp_x = 1.0
	Pp_y = 1.0
	Pp_z = 1.0

	Rv_x = 1.0
	Rv_y = 1.0
	Rv_z = 1.0
	Qv_x = 1.0
	Qv_y = 1.0
	Qv_z = 1.0
	Pv_x = 1.0
	Pv_y = 1.0
	Pv_z = 1.0

	max_att = np.pi/10.0
	thrust_cmd_max = 0.34
	data_NED_received = False
	time_stmp = 0.0
	rospy.init_node("controller",anonymous=True)
	rate = rospy.Rate(30)
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
		if data_NED_received:

			dt = Period
			#--------------------------------------------------------------------------------------------------------------------------
			#(START) Position controller (A_lqr = 0; B_lqr = 1;)
			ep_x = xd_StP - pos_NED_m[0]
			ep_y = yd_StP - pos_NED_m[1]
			ep_z = zd_StP - pos_NED_m[2]

			kp_x = Pp_x/Rp_x
			kp_y = Pp_y/Rp_y
			kp_z = Pp_z/Rp_z

			DPp_x = (Pp_x*Pp_x)/Rp_x - Qp_x
			DPp_y = (Pp_y*Pp_y)/Rp_y - Qp_y
			DPp_z = (Pp_z*Pp_z)/Rp_z - Qp_z

			vd_x = kp_x * ep_x
			vd_y = kp_y * ep_y
			vd_z = kp_z * ep_z

			Pp_x = Pp_x + (DPp_x * dt)
			Pp_y = Pp_y + (DPp_y * dt)
			Pp_z = Pp_z + (DPp_z * dt)

			vx_StP = np.clip(vd_x,-max_v,max_v)
			vy_StP = np.clip(vd_y,-max_v,max_v)
			vz_StP = np.clip(vd_z,-max_v,max_v)
			Results_File_Cont_Pos.write("%.6f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f\r\n" % (rospy.get_time(),ep_x,ep_y,ep_z,vd_x,vd_y,vd_z,vx_StP,vy_StP,vz_StP))

			#(END) Position controller
			#--------------------------------------------------------------------------------------------------------------------------
			#(START) Velocity controller (A_lqr = 0; B_lqr = 1;)
			ev_x = vx_StP - vel_NED_mps[0]
			ev_y = vy_StP - vel_NED_mps[1]
			ev_z = vz_StP - vel_NED_mps[2]

			kv_x = Pv_x/Rv_x
			kv_y = Pv_y/Rv_y
			kv_z = Pv_z/Rv_z

			DPv_x = (Pv_x*Pv_x)/Rv_x - Qv_x
			DPv_y = (Pv_y*Pv_y)/Rv_y - Qv_y
			DPv_z = (Pv_z*Pv_z)/Rv_z - Qv_z

			pitch_cmd = - kv_x * ev_x
			roll_cmd = + kv_y * ev_y
			thrust_cmd = - kv_z * ev_z
			yaw_cmd = 0.0

			Pv_x = Pv_x + (DPv_x * dt)
			Pv_y = Pv_y + (DPv_y * dt)
			Pv_z = Pv_z + (DPv_z * dt)

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
	        controller_lqr()
	except (rospy.ROSInterruptException, rospy.ServiceException, rospy.ROSException):
		pass
