#!/usr/bin/env python3
import rospy
import json
import numpy as np
import socket
from std_msgs.msg import String
from termcolor import colored

Client_MySelf = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
Client_MySelf.bind(('192.168.0.160',8100))
Client_MySelf.settimeout(0.1)

Client_Neighbor1 = ('192.168.0.58',8100)
print(colored("UDP connection with the neighbor is provided.","blue"))

Results_File_RelVel = open(r"/home/ubuntu/coop_con_loc_RPi/src/coop_con_loc/src/Results_File_RelVel.txt","w+")

data_NED = {}
data_RelVel = {}

def clean_shutdown():
	Results_File_RelVel.close()
	Client_MySelf.close()
	print(colored("The connection to the neighbor is terminated!","blue"))
	print(colored("The Relative velocity estimation is stopped!","blue"))

def callback(data):
	global data_NED
	data_NED = json.loads(data.data)

def relative_velocity_follower():
	rospy.init_node("relative_velocity_follower", anonymous=True)
	rate = rospy.Rate(30)
	rospy.on_shutdown(clean_shutdown)
	pub_RelVel = rospy.Publisher("RelVel", String, queue_size=20)
	while not rospy.is_shutdown():
		publish_data_RelVel = String()
		rate.sleep()
		rospy.Subscriber("NED_POS_VEL", String, callback)
		if not data_NED:
			print(colored("No local velocity is measured!","red"))
		else:
			try:
				#----------------------------------------------------------------------------------------------------------------------
				#(START) transmitting the local velocity to the neighbor drone
				#print("Received Data_NED: %s" % data_NED)
				local_vel_x = float(data_NED.get('vx'))
				local_vel_y = float(data_NED.get('vy'))
				local_vel_z = float(data_NED.get('vz'))
				VelToSend = json.dumps({'vx':local_vel_x, 'vy':local_vel_y, 'vz':local_vel_z})
				Client_MySelf.sendto(VelToSend.encode(),Client_Neighbor1)
				#(END) transmitting the local velocity to the neighbor drone
				#----------------------------------------------------------------------------------------------------------------------
				#(START) receiving the local velocity of the neighbor drone
				Resp_Neighbor1, Addrs_Neighbor1 = Client_MySelf.recvfrom(4096)
				vel_Neighbor1 = json.loads(Resp_Neighbor1.decode())
				vel_Neighbor1_x = float(vel_Neighbor1.get("vx"))
				vel_Neighbor1_y = float(vel_Neighbor1.get("vy"))
				vel_Neighbor1_z = float(vel_Neighbor1.get("vz"))
				print("Received Data from Leader: vx=%.3f , vy=%.3f , vz=%.3f" % (vel_Neighbor1_x,vel_Neighbor1_y,vel_Neighbor1_z))
				#(END) receiving the local velocity of te neighbor drone
				#----------------------------------------------------------------------------------------------------------------------
				#(START) computing the relative local veLocity
				RelVel_x_mps = local_vel_x - vel_Neighbor1_x
				RelVel_y_mps = local_vel_y - vel_Neighbor1_y
				RelVel_z_mps = local_vel_z - vel_Neighbor1_z
				Results_File_RelVel.write("%.3f %.3f %.3f\r\n" % (RelVel_x_mps,RelVel_y_mps,RelVel_z_mps))
				print("Relative local velocity to the Leader: vx=%.3f , vy=%.3f , vz=%.3f" % (RelVel_x_mps,RelVel_y_mps,RelVel_z_mps))
				#(END) computing the relative local velocity
				#----------------------------------------------------------------------------------------------------------------------
				#(START) publishing the relative velocity to the neighbor
				data_RelVel = {"vx_rel":RelVel_x_mps , "vy_rel":RelVel_y_mps , "vz_rel":RelVel_z_mps}
				publish_data_RelVel.data = json.dumps(data_RelVel)
				pub_RelVel.publish(publish_data_RelVel)
				#(END) publishing the relative velocity to the neighbor
				#----------------------------------------------------------------------------------------------------------------------
			except socket.timeout:
				print(colored("No neighbor found!","red"))


if __name__ == '__main__':
	try:
		relative_velocity_follower()
	except (rospy.ROSInterruptException, rospy.ServiceException, rospy.ROSException):
		pass
