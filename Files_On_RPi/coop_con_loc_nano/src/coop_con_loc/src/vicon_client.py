#!/usr/bin/env python3
import rospy
import numpy as np
import socket
import json
from std_msgs.msg import String
from sliding_differentiator import slid_diff

client = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
client.bind(('192.168.1.24',8100))
client.settimeout(1)
server = ('192.168.1.2',8100)

Results_File_Vicon = open(r"/root/coop_con_loc_nano/src/coop_con_loc/src/Results_File_Vicon.txt","w+")

def clean_shutdown():
	Results_File_Vicon.close()
	print("The conenction to the Vicon is terminated!")

def vicon_client():
	rospy.init_node("vicon_client",anonymous=True)
	rate = rospy.Rate(60)
	rospy.on_shutdown(clean_shutdown)
	pub_DIST = rospy.Publisher("vicon_pos", String, queue_size = 10)
	Diff_pos_vicon = [0]*3
	Diff_variable1 = [0]*3
	Diff_variable2 = [0]*3
	while not rospy.is_shutdown():
		time_stmp = float(rospy.get_time())
		rate.sleep()
		try:
			#--------------------------------------------------------------------------------------------------------------------
			#(START) receiving the vicon data
			Resp, Addr = client.recvfrom(4096)
			data = json.loads(Resp.decode())
			pos_data = data.get('vicon_pos')
			print("vicon data received:")
			print("%d %d %d" % (pos_data[0],pos_data[1],pos_data[2]))
			#(END) receiving the vicon data
			#--------------------------------------------------------------------------------------------------------------------
			#(START) measuring the frequency of the localziation and velocity estimation process
			Period = float(rospy.get_time()) - time_stmp
			time_stmp = float(rospy.get_time())
			Frequency = 1.0/Period
			print("Frequency of vicon data: %f Hz" %Frequency)
			#(END) measuring the frequency of the localziation and velocity estimation process
			#---------------------------------------------------------------------------------------------------------------------
			#(START) computing the time-derivation of the vicon position estimation
			for i in range(0,3):
				if abs(pos_data[i])>0:
					Diff_pos_vicon[i],Diff_variable1[i],Diff_variable2[i] = slid_diff(pos_data[i],Diff_variable1[i],Diff_variable2[i],Period)
			#(END) computing the time-derivation of the vicon position estimation
			#---------------------------------------------------------------------------------------------------------------------
			Results_File_Vicon.write("%.9f %d %d %d %d %d %d\r\n" % (float(rospy.get_time()),pos_data[0],pos_data[1],pos_data[2],Diff_pos_vicon[0],Diff_pos_vicon[1],Diff_pos_vicon[2]))
		except socket.timeout():
			print("no data!")


if __name__ == '__main__':
	try:
		vicon_client()
	except (rospy.ROSInterruptException, rospy.ServiceException, rospy.ROSException):
		pass

