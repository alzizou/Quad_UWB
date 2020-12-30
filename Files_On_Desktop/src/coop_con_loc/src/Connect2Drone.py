#!/usr/bin/env python3
import rospy
import json
import numpy as np
import socket
from std_msgs.msg import String
from termcolor import colored

Client_MySelf = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
Client_MySelf.bind(('192.168.0.91',8100))
Client_MySelf.settimeout(1)

Client_Drone1 = ('192.168.0.160',8100)
print(colored("UDP connection with the drone is provided.","blue"))

Results_File_DIST_Center = open(r"/home/ali/My_Localization_Folder/testing-dwm1001-dev-modules/Files_On_Desktop/src/coop_con_loc/src/Results_File_DIST_Center.txt","w+")

data_DIST = {}
data_NED = {}

def clean_shutdown():
	Results_File_DIST_Center.close()
	Client_MySelf.close()
	print(colored("The connection to the drone is terminated!","blue"))

def callback_NED(data):
	global data_NED
	data_NED = json.loads(data.data)

def drone_connection():
	pos_NED_m = [0.0,0.0,0.0]
	vel_NED_mps = [0.0,0.0,0.0]
	rospy.init_node("drone_connection", anonymous=True)
	rate = rospy.Rate(1000)
	rospy.on_shutdown(clean_shutdown)
	pub_DIST = rospy.Publisher("ALL_DIST", String, queue_size = 20)
	while not rospy.is_shutdown():
		publish_data_DIST = String()
		rate.sleep()
		data_NED_received = False
		try:
			#----------------------------------------------------------------------------------------------------------------------
			#(START) receiving the data from the drone
			Resp_drone1, Addrs_drone1 = Client_MySelf.recvfrom(4096)
			dist_drone1 = json.loads(Resp_drone1.decode())
			drone1_DIST_str = (dist_drone1.get("DIST"))
			drone1_DIST = list(map(int,drone1_DIST_str.split(",")))
			print("Received distances from the drone: dist01=%d , dist02=%d , dist03=%d , dist04=%d , dist05=%d , dist06=%d , dist07=%d , dist08=%d" % (drone1_DIST[0],drone1_DIST[1],drone1_DIST[2],drone1_DIST[3],drone1_DIST[4],drone1_DIST[5],drone1_DIST[6],drone1_DIST[7]))
			Results_File_DIST_Center.write("%d %d %d %d %d %d %d %d %d\r\n" % (rospy.get_time(),drone1_DIST[0],drone1_DIST[1],drone1_DIST[2],drone1_DIST[3],drone1_DIST[4],drone1_DIST[5],drone1_DIST[6],drone1_DIST[7]))
			#(END) receiving the local velocity of te neighbor drone
			#----------------------------------------------------------------------------------------------------------------------
			#(START) publishing the received distances from the drone
			data_DIST = {"DIST":drone1_DIST}
			publish_data_DIST.data = json.dumps(data_DIST)
			pub_DIST.publish(publish_data_DIST)
			#(END) publishing the received distances from the drone
			#----------------------------------------------------------------------------------------------------------------------
			#(START) subscribing to the estimated local position and velocity data
			rospy.Subscriber("NED_POS_VEL", String, callback_NED)
			if not data_NED:
				print(colored("No estimated position and velocity.","red"))
			else:
				data_NED_received = True
				pos_NED_m[0] = data_NED.get("px")
				pos_NED_m[1] = data_NED.get("py")
				pos_NED_m[2] = data_NED.get("pz")
				vel_NED_mps[0] = data_NED.get("vx")
				vel_NED_mps[1] = data_NED.get("vy")
				vel_NED_mps[2] = data_NED.get("vz")
			#(END) subscribing to the estimated local position and velocity data
			#--------------------------------------------------------------------------------------------------------------------------
			#(START) sending the estimated position and velocity to the drone
			if data_NED_received:
				NEDToSend = json.dumps({'px':pos_NED_m[0], 'py':pos_NED_m[1], 'pz':pos_NED_m[2], 'vx':vel_NED_mps[0], 'vy':vel_NED_mps[1], 'vz':vel_NED_mps[2]})
				Client_MySelf.sendto(NEDToSend.encode(),Client_Drone1)
			#(END) sending the estimated position and velocity to the drone
			#--------------------------------------------------------------------------------------------------------------------------

		except socket.timeout:
			print(colored("No connection to the drone!","red"))


if __name__ == '__main__':
	try:
		drone_connection()
	except (rospy.ROSInterruptException, rospy.ServiceException, rospy.ROSException):
		pass
