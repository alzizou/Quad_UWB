import serial
import time 
import numpy as np
import math
from numpy.linalg import multi_dot
from numpy import linalg 
from pymavlink import mavutil

serial_inst = serial.Serial("/dev/ttyS1")
serial_inst.baudrate = 115200

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

	All_Anchors[0:3,0] = [75,205,250] #A
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

	c1 = 'A'
	c2 = 'B'
	c3 = 'C'
	c4 = 'D'
	c5 = 'E'
	c6 = 'F'
	c7 = 'G'
	c8 = 'H'

	c11 = None
	c22 = None
	c33 = None
	c44 = None
	c55 = None
	c66 = None
	c77 = None
	c88 = None
	while(c11 == None):
		serial_inst.write(c1.encode())
		time.sleep(0.001)
		c11 = serial_inst.readline()

	while(c22 == None):
		serial_inst.write(c2.encode())
		time.sleep(0.001)
		c22 = serial_inst.readline()

	while(c33 == None):
		serial_inst.write(c3.encode())
		time.sleep(0.001)
		c33 = serial_inst.readline()

	while(c44 == None):
		serial_inst.write(c4.encode())
		time.sleep(0.001)
		c44 = serial_inst.readline()

	while(c55 == None):
		serial_inst.write(c5.encode())
		time.sleep(0.001)
		c55 = serial_inst.readline()

	while(c66 == None):
		serial_inst.write(c6.encode())
		time.sleep(0.001)
		c66 = serial_inst.readline()

	while(c77 == None):
		serial_inst.write(c7.encode())
		time.sleep(0.001)
		c77 = serial_inst.readline()

	while(c88 == None):
		serial_inst.write(c8.encode())
		time.sleep(0.001)
		c88 = serial_inst.readline()

	serial_inst.close()

	#time.sleep(0.001)
	if ( (c11 != None) & (c22 != None) ):
		if ( (c33 != None) & (c44 != None) ):
			if ( (c55 != None) & (c66 != None) ):
				if ( (c77 != None) & (c88 != None) ):
					Anchors_Adrs = [65,66,67,68,69,70,71,72]
					DIST = [0,0,0,0,0,0,0,0]
					X = [0,0,0]
					X_m = [0,0,0]
					Results_File = open("Results_File.txt","w+")
					Results_File_Dist = open("Results_File_Dist.txt","w+")
					Results_File_EKF = open("Results_File_EKF.txt","w+")
					Counter = -1
					while(1):
						serial_inst.open()
						DATA = np.zeros([8,2])
						serial_inst.flush()
						for i in range(0,7):
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

						if((DIST[0] > 1) & (DIST[1] > 1)):
							if((DIST[2] > 1) & (DIST[3] > 1)):
								if((DIST[4] > 1) & (DIST[5] > 1)):
									if((DIST[6] > 1) & (DIST[7] > 1)):
										print("\r\n%d %d %d %d %d %d %d %d" % (DIST[0],DIST[1],DIST[2],DIST[3],DIST[4],DIST[5],DIST[6],DIST[7]))
										Results_File_Dist.write("%d %d %d %d %d %d %d %d\r\n" % (DIST[0],DIST[1],DIST[2],DIST[3],DIST[4],DIST[5],DIST[6],DIST[7]))
										X = localization(DIST,X)
										Results_File.write("%d %d %d\r\n" % (X[0],X[1],X[2]))
										print("%d %d %d" % (X[0],X[1],X[2]))
										X_m[0] = 0.001*X[0]
										X_m[1] = 0.001*X[1]
										X_m[2] = 0.001*X[2]
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

