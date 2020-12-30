#!/usr/bin/env python3
import rospy
import json
import numpy as np
import socket
from std_msgs.msg import String
from termcolor import colored

Client_MySelf = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
Client_MySelf.bind(('192.168.0.160',8100))
Client_MySelf.settimeout(1)

Client_Center = ('192.168.0.91',8100)
print(colored("UDP connection with the center is provided.","blue"))

Results_File = open(r"/root/logs/Results_File.txt","w+")
Results_File_ABS_VEL = open(r"/root/logs/Results_File_ABS_VEL.txt","w+")
Results_File_Freq_Vel = open(r"/root/logs/Results_File_Freq_Vel.txt","w+")

data_DIST = {}
data_NED = {}

def clean_shutdown():
	Results_File.close()
	Results_File_ABS_VEL.close()
	Results_File_Freq_Vel.close()
	Client_MySelf.close()
	print(colored("The connection to the center is terminated!","blue"))

def callback_DIST(data):
	global data_DIST
	data_DIST = json.loads(data.data)

def drone_connection():
	rospy.init_node("drone_connection", anonymous=True)
	rate = rospy.Rate(1000)
	rospy.on_shutdown(clean_shutdown)
	pub_NED = rospy.Publisher("NED_POS_VEL", String, queue_size = 20)
	px_Est_NED = 0.0
	py_Est_NED = 0.0
	pz_Est_NED = 0.0
	vx_Est_NED = 0.0
	vy_Est_NED = 0.0
	vz_Est_NED = 0.0
	time_stmp = 0.0
	while not rospy.is_shutdown():
		publish_data_NED = String()
		rate.sleep()
		data_DIST_received = False
		try:
			#----------------------------------------------------------------------------------------------------------------------
			#(START) subscribing to the measured distances
			rospy.Subscriber("ALL_DIST", String, callback_DIST)
			if not data_DIST:
				print("No distances are received!")
			else:
				DIST = data_DIST.get("DIST")
				print(DIST)
				data_DIST_received = True
			#(END) subscribing to the measured distances
			#----------------------------------------------------------------------------------------------------------------------
			#(START) sending the distances to the center
			if data_DIST_received:
				DistToSend = json.dumps({"DIST":",".join(map(str,DIST))})
				Client_MySelf.sendto(DistToSend.encode(),Client_Center)
			#(END) sending the distances to the center
			#----------------------------------------------------------------------------------------------------------------------
			#(START) receiving the estimated position and velocity from the center
			Resp_Center, Addrs_Center = Client_MySelf.recvfrom(4096)
			data_Est_NED = json.loads(Resp_Center.decode())
			px_Est_NED = float(data_Est_NED.get("px"))
			py_Est_NED = float(data_Est_NED.get("py"))
			pz_Est_NED = float(data_Est_NED.get("pz"))
			vx_Est_NED = float(data_Est_NED.get("vx"))
			vy_Est_NED = float(data_Est_NED.get("vy"))
			vz_Est_NED = float(data_Est_NED.get("vz"))
			print("Received estimated NED data: px=%.3f , py=%.3f , pz=%.3f , vx=%.3f , vy=%.3f , vz=%.3f" % (px_Est_NED,py_Est_NED,pz_Est_NED,vx_Est_NED,vy_Est_NED,vz_Est_NED))
			Results_File.write("%d %d %d %d\r\n" % (rospy.get_time(),1000*px_Est_NED,1000*py_Est_NED,1000*pz_Est_NED))
			Results_File_ABS_VEL.write("%d %d %d %d\r\n" % (rospy.get_time(),1000*vx_Est_NED,1000*vy_Est_NED,1000*vz_Est_NED))
			#(END) receiving the estimated position and velocity from the center
			#--------------------------------------------------------------------------------------------------------------------------
			#(START) measuring the frequency of the localziation and velocity estimation process
			Period = float(rospy.get_time()) - time_stmp
			Frequency = 1.0/Period
			#print(colored(("Frequency of velocity estimation: %f Hz" %Frequency),"green"))
			Results_File_Freq_Vel.write("%.2f\r\n" % Frequency)
			Period_EKF = Period
			if (time_stmp<1.0):
				Period_EKF = 0.0
			time_stmp = float(rospy.get_time())
			#(END) measuring the frequency of the localziation and velocity estimation process
			#--------------------------------------------------------------------------------------------------------------------------
			#(START) publishing the estimated position and velocity
			data_NED = {"px":px_Est_NED , "py":py_Est_NED , "pz":pz_Est_NED , "vx":vx_Est_NED , "vy":vy_Est_NED , "vz":vz_Est_NED}
			publish_data_NED.data = json.dumps(data_NED)
			pub_NED.publish(publish_data_NED)
			#(END) publishing the estimated position and velocity
			#--------------------------------------------------------------------------------------------------------------------------

		except socket.timeout:
			print(colored("No connection to the center!","red"))


if __name__ == '__main__':
	try:
		drone_connection()
	except (rospy.ROSInterruptException, rospy.ServiceException, rospy.ROSException):
		pass
