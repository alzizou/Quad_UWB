import serial
import time
import numpy as np
import math
from numpy.linalg import multi_dot
from numpy import linalg 
from pymavlink import mavutil
import socket

serial_inst = serial.Serial("/dev/ttyS1")
serial_inst.baudrate = 115200

client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
client.setsockopt(socket.SOL_SOCKET,socket.SO_REUSEADDR,1)
client.connect(('192.168.0.70',80))
print("connection to server is done")

PX4_connection = mavutil.mavlink_connection("/dev/ttyACM0")
PX4_connection.wait_heartbeat()
print("PX4 Heartbeat(%u,%u)" % (PX4_connection.target_system, PX4_connection.target_system))

def distance_return():
	output = [0]*2
	n = 0
	data0 = serial_inst.readline()
	Addrs = data0[0]
	for i in range(2,len(data0)):
		if data0[i]==32:
			n = i-1
			break

	data = 0
	for j in range(2,n):
		data = data + ( (data0[j] - 48)*(10**(n-j)) )

	data = data + (data0[n] - 48)

	output[0] = Addrs
	output[1] = data

	return(output)


def localization(DIST_inp,Initial_inp):
	Num_Anchors = 8
	All_Dist = DIST_inp
	All_Anchors = np.zeros([3,Num_Anchors])

	All_Anchors[0:3,0] = [-500,205,250] #A
	All_Anchors[0:3,1] = [4750,230,250] #B
	All_Anchors[0:3,2] = [0,5920,280] #C
	All_Anchors[0:3,3] = [5590,5790,405] #D
	All_Anchors[0:3,4] = [0,50,2285] #E
	All_Anchors[0:3,5] = [4880,0,2235] #F
	All_Anchors[0:3,6] = [0,5920,2390] #G
	All_Anchors[0:3,7] = [5255,5790,2285] #H

	X_out = Initial_inp
	All_Est_Pos = np.zeros([3,2]) #Num_Anchors])
	Ref_Tot_Num = -1
	for Ref_Anchor_Num in [0,4]: #range(0,Num_Anchors-1):
		A = np.zeros([Num_Anchors-1,3])
		B = np.zeros([Num_Anchors-1,1])
		num_i = -1
		for i in range(0,Num_Anchors-1):
			if(i!=Ref_Anchor_Num):
				num_i = num_i + 1
				A[num_i,:] = 2*np.transpose((All_Anchors[:,i]-All_Anchors[:,Ref_Anchor_Num]))
				B[num_i] = ( (All_Dist[Ref_Anchor_Num]**2) - multi_dot([np.transpose(All_Anchors[:,Ref_Anchor_Num]),All_Anchors[:,Ref_Anchor_Num]]) ) - ( (All_Dist[i]**2) - multi_dot([np.transpose(All_Anchors[:,i]),All_Anchors[:,i]]) )

		Max_Dist = np.max(All_Dist) + 1000
		Weights = np.zeros([Num_Anchors-1,Num_Anchors-1])
		num_i = -1
		for i in range(0,Num_Anchors-1):
			if(i!=Ref_Anchor_Num):
				num_i = num_i + 1
				Weights[num_i,num_i] = (Max_Dist - All_Dist[i])/Max_Dist

		Thresh = 1e+0
		num = -1
		alpha = 1e-9 * np.diag([1,1,5])
		Abs_Dif_err = 1e+6
		Num_It = 5000
		P = np.zeros([3,Num_It])
		P[:,0] = Initial_inp
		err_Arr = [0]*Num_It
		All_Distances_Hat2 = np.zeros([Num_Anchors,1])
		B_hat = np.zeros([Num_Anchors-1,1])
		while(Abs_Dif_err>Thresh):
			num = num+1
			num_i = -1
			for i in range(0,Num_Anchors-1):
				All_Distances_Hat2[i] = multi_dot([np.transpose((P[:,num]-All_Anchors[:,i])),(P[:,num]-All_Anchors[:,i])])

			for i in range(0,Num_Anchors-1):
				if(i!=Ref_Anchor_Num):
					num_i = num_i + 1
					B_hat[num_i] = ( All_Distances_Hat2[Ref_Anchor_Num] - multi_dot([np.transpose(All_Anchors[:,Ref_Anchor_Num]),All_Anchors[:,Ref_Anchor_Num]]) ) - ( All_Distances_Hat2[i] - multi_dot([np.transpose(All_Anchors[:,i]),All_Anchors[:,i]]) )

			e = np.subtract(B,B_hat)
			alpha0 = alpha # * 1/(1+(0.1*num))
			P_dot = multi_dot([alpha0,np.transpose(A),Weights,e])
			P[0][num+1] = P[0][num] + P_dot[0]
			P[1][num+1] = P[1][num] + P_dot[1]
			P[2][num+1] = P[2][num] + P_dot[2]
			err = linalg.norm(e)
			err_Arr[num] = err
			if(num>1):
				Dif_err = err_Arr[num] - err_Arr[num-1]
				Abs_Dif_err = abs(Dif_err)

			if(num>50):
				if(Dif_err>0):
					break

			if(num>(Num_It-50)):
				break

		if(P[2][num]<0):
			alpha[2][2] = -1 * alpha[2][2]
			num = -1
			Abs_Dif_err = 1e+6
			Num_It = 1000
			P = np.zeros([3,Num_It])
			P[:,0] = Initial_inp
			err_Arr = [0]*Num_It
			All_Distances_Hat2 = np.zeros([Num_Anchors,1])
			B_hat = np.zeros([Num_Anchors-1,1])
			while(Abs_Dif_err>Thresh):
				num = num+1
				num_i = -1
				for i in range(0,Num_Anchors-1):
					All_Distances_Hat2[i] = multi_dot([np.transpose((P[:,num]-All_Anchors[:,i])),(P[:,num]-All_Anchors[:,i])])

				for i in range(0,Num_Anchors-1):
					if(i!=Ref_Anchor_Num):
						num_i = num_i + 1
						B_hat[num_i] = ( All_Distances_Hat2[Ref_Anchor_Num] - multi_dot([np.transpose(All_Anchors[:,Ref_Anchor_Num]),All_Anchors[:,Ref_Anchor_Num]]) ) - ( All_Distances_Hat2[i] - multi_dot([np.transpose(All_Anchors[:,i]),All_Anchors[:,i]]) )

				e = np.subtract(B,B_hat)
				alpha0 = alpha # * 1/(1+(0.1*num))
				P_dot = multi_dot([alpha0,np.transpose(A),Weights,e])
				P[0][num+1] = P[0][num] + P_dot[0]
				P[1][num+1] = P[1][num] + P_dot[1]
				P[2][num+1] = P[2][num] + P_dot[2]
				err = linalg.norm(e)
				err_Arr[num] = err
				if(num>1):
					Dif_err = err_Arr[num] - err_Arr[num-1]
					Abs_Dif_err = abs(Dif_err)

				if(num>50):
					if(Dif_err>0):
						break

				if(num>(Num_It-50)):
					break
		Ref_Tot_Num = Ref_Tot_Num + 1
		All_Est_Pos[:,Ref_Tot_Num] = P[:,num]
		P = np.zeros([3,Num_It])

	X_out[0] = np.mean(All_Est_Pos[0,:])
	X_out[1] = np.mean(All_Est_Pos[1,:])
	X_out[2] = np.mean(All_Est_Pos[2,:])
	return(X_out)


try:

	c = [0]*8
	c1 = [0]*8

	c[0] = 'A'
	c[1] = 'B'
	c[2] = 'C'
	c[3] = 'D'
	c[4] = 'E'
	c[5] = 'F'
	c[6] = 'G'
	c[7] = 'H'

	c1[0] = None
	c1[1] = None
	c1[2] = None
	c1[3] = None
	c1[4] = None
	c1[5] = None
	c1[6] = None
	c1[7] = None

	serial_inst.close()

	Anchors_Adrs = [65,66,67,68,69,70,71,72]
	X = [0,0,0]
	X_m = [0,0,0]
	Results_File = open("Results_File.txt","w+")
	Results_File_Dist = open("Results_File_Dist.txt","w+")
	Results_File_EKF = open("Results_File_EKF.txt","w+")
	while(1):
		DIST = [0,0,0,0,0,0,0,0]
		command = None
		command = client.recv(4096)
		if((not command)==0):
			command_str = command.decode()
			command_int = int(command_str)
			if(command_int==1):
				serial_inst.open()
				DATA = np.zeros([8,2])
				serial_inst.flush()
				for i in range(0,8):
					while(c1[i]==None):
						serial_inst.write(c[i].encode())
						#time.sleep(0.001)
						c1[i] = serial_inst.readline()

					if(c1[i]!=None):
						MEAS = distance_return()
						DATA[i][0] = MEAS[0]
						DATA[i][1] = MEAS[1]
						if(DATA[i][0] == Anchors_Adrs[0]):
							DIST[0] = DATA[i][1]
						elif(DATA[i][0] == Anchors_Adrs[1]):
							DIST[1] = DATA[i][1]
						elif(DATA[i][0] == Anchors_Adrs[2]):
							DIST[2] = DATA[i][1]
						elif(DATA[i][0] == Anchors_Adrs[3]):
							DIST[3] = DATA[i][1]
						elif(DATA[i][0] == Anchors_Adrs[4]):
							DIST[4] = DATA[i][1]
						elif(DATA[i][0] == Anchors_Adrs[5]):
							DIST[5] = DATA[i][1]
						elif(DATA[i][0] == Anchors_Adrs[6]):
							DIST[6] = DATA[i][1]
						elif(DATA[i][0] == Anchors_Adrs[7]):
							DIST[7] = DATA[i][1]
					c1[i] = None

				client.send('1'.encode())
				print("\r\n%d %d %d %d %d %d %d %d" % (DIST[0],DIST[1],DIST[2],DIST[3],DIST[4],DIST[5],DIST[6],DIST[7]))
				if((DIST[0] > 1) & (DIST[1] > 1)):
					if((DIST[2] > 1) & (DIST[3] > 1)):
						if((DIST[4] > 1) & (DIST[5] > 1)):
							if((DIST[6] > 1) & (DIST[7] > 1)):
								Results_File_Dist.write("%d %d %d %d %d %d %d %d\r\n" % (DIST[0],DIST[1],DIST[2],DIST[3],DIST[4],DIST[5],DIST[6],DIST[7]))
								X = localization(DIST,X)
								Results_File.write("%d %d %d\r\n" % (X[0],X[1],X[2]))
								print("%d %d %d" % (X[0],X[1],X[2]))
								X_m[0] = 0.001*X[0]
								X_m[1] = 0.001*X[1]
								X_m[2] = -0.001*X[2]
								PX4_connection.mav.vision_position_estimate_send(0,X_m[0],X_m[1],X_m[2],0,0,0)
								PX4_msg = PX4_connection.recv_match(type='LOCAL_POSITION_NED',blocking=True)
								if not PX4_msg:
									print("PX4 message is not received.")
								if PX4_msg.get_type() == "BAD_DATA":
									print("Nothing to print!")
								else:
									print("%s" % PX4_msg)
									Results_File_EKF.write("%.6f %.6f %.6f %.6f %.6f %.6f\r\n" % (PX4_msg.x,PX4_msg.y,PX4_msg.z,PX4_msg.vx,PX4_msg.vy,PX4_msg.vz))

				serial_inst.close()

except KeyboardInterrupt:
	Results_File.close()
	Results_File_Dist.close()
	Results_File_EKF.close()
	print("done.")

