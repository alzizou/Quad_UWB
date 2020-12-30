#!/usr/bin/env python3
import rospy
import serial
import time
import numpy as np
import socket
import json
from std_msgs.msg import String
from termcolor import colored
from distance import distance
from ekf_dist import EKF_DIST
#from ekf_dist_jerk import EKF_DIST

serial_inst = serial.Serial("/dev/ttyS1")
serial_inst.baudrate = 115200

UWB_Server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
UWB_Server.setsockopt(socket.SOL_SOCKET,socket.SO_REUSEADDR,1)
UWB_Server.connect(('192.168.0.70',80)) #('192.168.1.25',80)
print(colored("connection to the UWB-Server is provided.","green"))

Results_File_DIST = open(r"/root/logs/Results_File_DIST.txt","w+")
Results_File_Freq_Dist = open(r"/root/logs/Results_File_Freq_DIST.txt","w+")

data_DIST = {}

Num_Anchors_dist = 8
c = ['A','B','C','D','E','F','G','H']
Anchors_Adrs = [65,66,67,68,69,70,71,72]

def clean_shutdown():
	Results_File_DIST.close()
	Results_File_Freq_Dist.close()
	UWB_Server.close()
	print(colored("The connection to the UWB-Server is terminated!","green"))

def distance_collection():
	c1 = [None]*Num_Anchors_dist
	DIST = [0]*Num_Anchors_dist
	DIST_Flt = [0]*Num_Anchors_dist
	DATA = np.zeros([Num_Anchors_dist,2])
	DATA_Store = np.zeros([Num_Anchors_dist,2])
	for i in range(0,Num_Anchors_dist):
		DATA_Store[i][0] = Anchors_Adrs[i]
		DATA_Store[i][1] = 1
	P_EKF_Dist = {0:np.eye(3), 1:np.eye(3), 2:np.eye(3), 3:np.eye(3), 4:np.eye(3), 5:np.eye(3), 6:np.eye(3), 7:np.eye(3)}
	x_hat_EKF_Dist = {0:np.zeros([3,1]), 1:np.zeros([3,1]), 2:np.zeros([3,1]), 3:np.zeros([3,1]), 4:np.zeros([3,1]), 5:np.zeros([3,1]), 6:np.zeros([3,1]), 7:np.zeros([3,1])}
#	P_EKF_Dist = {0:np.eye(4), 1:np.eye(4), 2:np.eye(4), 3:np.eye(4), 4:np.eye(4), 5:np.eye(4), 6:np.eye(4), 7:np.eye(4)} # Using KF based on constant jerk
#	x_hat_EKF_Dist = {0:np.zeros([4,1]), 1:np.zeros([4,1]), 2:np.zeros([4,1]), 3:np.zeros([4,1]), 4:np.zeros([4,1]), 5:np.zeros([4,1]), 6:np.zeros([4,1]), 7:np.zeros([4,1])} # Using KF based on constant jerk
	publish_data_DIST = String()

	rospy.init_node("distance_collection",anonymous=True)
	rate = rospy.Rate(120)
	rospy.on_shutdown(clean_shutdown)
	pub_DIST = rospy.Publisher("ALL_DIST", String, queue_size=10)
	serial_inst.close()

	while not rospy.is_shutdown():
		time_stmp_dist = float(rospy.get_time())
		command = None
		rate.sleep()
		command = UWB_Server.recv(4096)
		if((not command)==0):
			command_int = int(command.decode())
			if(command_int==1):
				serial_inst.open()
				#----------------------------------------------------------------------------------------------------------------------
				#(START) measuring the distances to the anchors
				DATA = np.zeros([Num_Anchors_dist,2])
				serial_inst.flush()
				for i in range(0,Num_Anchors_dist):
					while(c1[i]==None):
						serial_inst.write(c[i].encode())
						c1[i] = serial_inst.readline()
					if(c1[i]!=None):
						MEAS = distance(serial_inst)
						DATA[i][0] = MEAS[0]
						DATA[i][1] = MEAS[1]
						if(DATA[i][1] > 0):
							DATA_Store[i][0] = DATA[i][0]
							DATA_Store[i][1] = DATA[i][1]
						if(DATA[i][1] <= 0):
							DATA[i][0] = DATA_Store[i][0]
							DATA[i][1] = DATA_Store[i][1]
						DIST[int(DATA[i][0])-65] = DATA[i][1]
					c1[i] = None
				UWB_Server.send('2'.encode())
				#(END) measuring the distances to the anchors
				#--------------------------------------------------------------------------------------------------------------------
				#(START) Kalman Filter on distance measurements
				Period = float(rospy.get_time()) - time_stmp_dist
				Frequency = 1.0/Period
				Period_KF = Period
				if (time_stmp_dist<1.0):
					Period_KF = 0.0
				time_stmp_dist = float(rospy.get_time())
				#(END) measuring the frequency of distance collection
				#--------------------------------------------------------------------------------------------------------------------
				#(START) Kalman Filter on distance measurements
				for i in range(0,Num_Anchors_dist):
				    x_hat_EKF_Dist[i],P_EKF_Dist[i] = EKF_DIST(DIST[i],x_hat_EKF_Dist[i],P_EKF_Dist[i],Period_KF)
				    DIST_Flt[i] = int(x_hat_EKF_Dist[i][0][0])
				#(END) Kalman Filter on distance measurements
				#--------------------------------------------------------------------------------------------------------------------
				#(START) logging distance measurements
#				print(colored(("\r\nDistances: %d %d %d %d %d %d %d %d" % (DIST[0],DIST[1],DIST[2],DIST[3],DIST[4],DIST[5],DIST[6],DIST[7])),"green"))
				print(colored(("Distance collection frequency: %.2f" % Frequency),"green"))
				Results_File_Freq_Dist.write("%.2f\r\n" % Frequency)
				Results_File_DIST.write("%.6f %d %d %d %d %d %d %d %d\r\n" % (rospy.get_time(),DIST_Flt[0],DIST_Flt[1],DIST_Flt[2],DIST_Flt[3],DIST_Flt[4],DIST_Flt[5],DIST_Flt[6],DIST_Flt[7]))
				#(END) logging distance measurements
				#--------------------------------------------------------------------------------------------------------------------
				#(START) publishing collected distances to anchors
				data_DIST = {"DIST":DIST_Flt}
				publish_data_DIST.data = json.dumps(data_DIST)
				pub_DIST.publish(publish_data_DIST)
				#(END) publishing collected distances to anchors
				#--------------------------------------------------------------------------------------------------------------------
				serial_inst.close()



if __name__ == '__main__':
	try:
		distance_collection()
	except (rospy.ROSInterruptException, rospy.ServiceException, rospy.ROSException):
		pass
