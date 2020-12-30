import serial
import time 
import numpy as np
import math
from numpy.linalg import multi_dot
from numpy import linalg 

serial_inst = serial.Serial("/dev/serial0")
serial_inst.baudrate = 115200

def distance_return():
	output = [0]*2
	n = 0
	data0 = serial_inst.readline() # b'H,7377 \r\n'
	data1 = data0.decode('utf-8')
	data1 = data1.replace(' /r/n', '')
	id, value = data1.split(',')
	return id.encode(), value

def localization(DIST_inp):
	dist01_inp = DIST_inp[0]
	dist02_inp = DIST_inp[1]
	dist03_inp = DIST_inp[2]
	dist04_inp = DIST_inp[3]
	dist05_inp = DIST_inp[4]
	dist06_inp = DIST_inp[5]
	dist07_inp = DIST_inp[6]
	dist08_inp = DIST_inp[7]

	Anchor01 = [0,0,711] #A
	Anchor02 = [5360,0,737] #B
	Anchor03 = [-305,5868,356] #C
	Anchor04 = [5944,5842,350] #D
	Anchor05 = [0,0,2300] #E
	Anchor06 = [5360,0,2300] #F
	Anchor07 = [-305,5868,2300] #G
	Anchor08 = [5944,5842,2300] #H

	X_out = [0,0,0]

	A = np.array([[-2*Anchor01[0],-2*Anchor01[1],-2*Anchor01[2],1],
			[-2*Anchor02[0],-2*Anchor02[1],-2*Anchor02[2],1],
			[-2*Anchor03[0],-2*Anchor03[1],-2*Anchor03[2],1],
                        [-2*Anchor04[0],-2*Anchor04[1],-2*Anchor04[2],1],
			[-2*Anchor05[0],-2*Anchor05[1],-2*Anchor05[2],1],
			[-2*Anchor06[0],-2*Anchor06[1],-2*Anchor06[2],1],
			[-2*Anchor07[0],-2*Anchor07[1],-2*Anchor07[2],1],
			[-2*Anchor08[0],-2*Anchor08[1],-2*Anchor08[2],1]])

	Y = [( (dist01_inp**2)-(Anchor01[0]**2)-(Anchor01[1]**2)-(Anchor01[2]**2) ),
		( (dist02_inp**2)-(Anchor02[0]**2)-(Anchor02[1]**2)-(Anchor02[2]**2) ),
		( (dist03_inp**2)-(Anchor03[0]**2)-(Anchor03[1]**2)-(Anchor03[2]**2) ),
		( (dist04_inp**2)-(Anchor04[0]**2)-(Anchor04[1]**2)-(Anchor04[2]**2) ),
		( (dist05_inp**2)-(Anchor05[0]**2)-(Anchor05[1]**2)-(Anchor05[2]**2) ),
		( (dist06_inp**2)-(Anchor06[0]**2)-(Anchor06[1]**2)-(Anchor06[2]**2) ),
		( (dist07_inp**2)-(Anchor07[0]**2)-(Anchor07[1]**2)-(Anchor07[2]**2) ),
		( (dist08_inp**2)-(Anchor08[0]**2)-(Anchor08[1]**2)-(Anchor08[2]**2) )]

	Max_Dist = max([dist01_inp,dist02_inp,dist03_inp,dist04_inp,dist05_inp,dist06_inp,dist07_inp,dist08_inp]) + 500
	Sum_Dist = (Max_Dist - dist01_inp) + (Max_Dist - dist02_inp) + (Max_Dist - dist03_inp) + (Max_Dist - dist04_inp) + (Max_Dist - dist05_inp) + (Max_Dist - dist06_inp) + (Max_Dist - dist07_inp) + (Max_Dist - dist08_inp)
	w1 = (Max_Dist - dist01_inp)/Sum_Dist
	w2 = (Max_Dist - dist02_inp)/Sum_Dist
	w3 = (Max_Dist - dist03_inp)/Sum_Dist
	w4 = (Max_Dist - dist04_inp)/Sum_Dist
	w5 = (Max_Dist - dist05_inp)/Sum_Dist
	w6 = (Max_Dist - dist06_inp)/Sum_Dist
	w7 = (Max_Dist - dist07_inp)/Sum_Dist
	w8 = (Max_Dist - dist08_inp)/Sum_Dist
	W = np.diag([w1,w2,w3,w4,w5,w6,w7,w8])
	#W = np.diag([1,1,1,1,1,1,1,1])
	Thresh = 1e+2
	num = -1
	alpha = 1e-9 * np.diag([1,1,1,1])
	Abs_Dif_err = 1e+6

	Num_It = 1000;
	P = np.zeros([3,Num_It])
	err_Arr = [0]*Num_It

	while(Abs_Dif_err>Thresh):
		num = num+1
		dist01_hat = math.sqrt( (P[0][num] - Anchor01[0])**2 + (P[1][num] - Anchor01[1])**2 + (P[2][num] - Anchor01[2])**2 )
		dist02_hat = math.sqrt( (P[0][num] - Anchor02[0])**2 + (P[1][num] - Anchor02[1])**2 + (P[2][num] - Anchor02[2])**2 )
		dist03_hat = math.sqrt( (P[0][num] - Anchor03[0])**2 + (P[1][num] - Anchor03[1])**2 + (P[2][num] - Anchor03[2])**2 )
		dist04_hat = math.sqrt( (P[0][num] - Anchor04[0])**2 + (P[1][num] - Anchor04[1])**2 + (P[2][num] - Anchor04[2])**2 )
		dist05_hat = math.sqrt( (P[0][num] - Anchor05[0])**2 + (P[1][num] - Anchor05[1])**2 + (P[2][num] - Anchor05[2])**2 )
		dist06_hat = math.sqrt( (P[0][num] - Anchor06[0])**2 + (P[1][num] - Anchor06[1])**2 + (P[2][num] - Anchor06[2])**2 )
		dist07_hat = math.sqrt( (P[0][num] - Anchor07[0])**2 + (P[1][num] - Anchor07[1])**2 + (P[2][num] - Anchor07[2])**2 )
		dist08_hat = math.sqrt( (P[0][num] - Anchor08[0])**2 + (P[1][num] - Anchor08[1])**2 + (P[2][num] - Anchor08[2])**2 )

		Y_hat = [( (dist01_hat**2)-(Anchor01[0]**2)-(Anchor01[1]**2)-(Anchor01[2]**2) ),
                      ( (dist02_hat**2)-(Anchor02[0]**2)-(Anchor02[1]**2)-(Anchor02[2]**2) ),
                      ( (dist03_hat**2)-(Anchor03[0]**2)-(Anchor03[1]**2)-(Anchor03[2]**2) ),
                      ( (dist04_hat**2)-(Anchor04[0]**2)-(Anchor04[1]**2)-(Anchor04[2]**2) ),
			( (dist05_hat**2)-(Anchor05[0]**2)-(Anchor05[1]**2)-(Anchor05[2]**2) ),
			( (dist06_hat**2)-(Anchor06[0]**2)-(Anchor06[1]**2)-(Anchor06[2]**2) ),
			( (dist07_hat**2)-(Anchor07[0]**2)-(Anchor07[1]**2)-(Anchor07[2]**2) ),
			( (dist08_hat**2)-(Anchor08[0]**2)-(Anchor08[1]**2)-(Anchor08[2]**2) )]

		e = np.subtract(Y,Y_hat)
		P_dot = multi_dot([alpha,np.transpose(A),W,e])
		P[0][num+1] = P[0][num] + P_dot[0]
		P[1][num+1] = P[1][num] + P_dot[1]
		P[2][num+1] = P[2][num] + P_dot[2]
		err = linalg.norm(e)
		err_Arr[num] = err
	
		if(num>1):
			Dif_err = err_Arr[num] - err_Arr[num-1]
			Abs_Dif_err = abs(Dif_err)

		if(num>30):
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
		err_Arr = [0]*Num_It
		while(Abs_Dif_err>Thresh):
			num = num+1
			dist01_hat = math.sqrt( (P[0][num] - Anchor01[0])**2 + (P[1][num] - Anchor01[1])**2 + (P[2][num] - Anchor01[2])**2 )
			dist02_hat = math.sqrt( (P[0][num] - Anchor02[0])**2 + (P[1][num] - Anchor02[1])**2 + (P[2][num] - Anchor02[2])**2 )
			dist03_hat = math.sqrt( (P[0][num] - Anchor03[0])**2 + (P[1][num] - Anchor03[1])**2 + (P[2][num] - Anchor03[2])**2 )
			dist04_hat = math.sqrt( (P[0][num] - Anchor04[0])**2 + (P[1][num] - Anchor04[1])**2 + (P[2][num] - Anchor04[2])**2 )
			dist05_hat = math.sqrt( (P[0][num] - Anchor05[0])**2 + (P[1][num] - Anchor05[1])**2 + (P[2][num] - Anchor05[2])**2 )
			dist06_hat = math.sqrt( (P[0][num] - Anchor06[0])**2 + (P[1][num] - Anchor06[1])**2 + (P[2][num] - Anchor06[2])**2 )
			dist07_hat = math.sqrt( (P[0][num] - Anchor07[0])**2 + (P[1][num] - Anchor07[1])**2 + (P[2][num] - Anchor07[2])**2 )
			dist08_hat = math.sqrt( (P[0][num] - Anchor08[0])**2 + (P[1][num] - Anchor08[1])**2 + (P[2][num] - Anchor08[2])**2 )

			Y_hat = [( (dist01_hat**2)-(Anchor01[0]**2)-(Anchor01[1]**2)-(Anchor01[2]**2) ),
                            ( (dist02_hat**2)-(Anchor02[0]**2)-(Anchor02[1]**2)-(Anchor02[2]**2) ),
                            ( (dist03_hat**2)-(Anchor03[0]**2)-(Anchor03[1]**2)-(Anchor03[2]**2) ),
                            ( (dist04_hat**2)-(Anchor04[0]**2)-(Anchor04[1]**2)-(Anchor04[2]**2) ),
				( (dist05_hat**2)-(Anchor05[0]**2)-(Anchor05[1]**2)-(Anchor05[2]**2) ),
				( (dist06_hat**2)-(Anchor06[0]**2)-(Anchor06[1]**2)-(Anchor06[2]**2) ),
				( (dist07_hat**2)-(Anchor07[0]**2)-(Anchor07[1]**2)-(Anchor07[2]**2) ),
				( (dist08_hat**2)-(Anchor08[0]**2)-(Anchor08[1]**2)-(Anchor08[2]**2) )]

			e = np.subtract(Y,Y_hat)
			P_dot = multi_dot([alpha,np.transpose(A),W,e])
			P[0][num+1] = P[0][num] + P_dot[0]
			P[1][num+1] = P[1][num] + P_dot[1]
			P[2][num+1] = P[2][num] + P_dot[2]
			err = linalg.norm(e)
			err_Arr[num] = err

			if(num>1):
				Dif_err = err_Arr[num] - err_Arr[num-1]
				Abs_Dif_err = abs(Dif_err)

			if(num>30):
				if(Dif_err>0):
					break
	
			if(num>(Num_It-50)):
				break


	X_out[0] = P[0][num]
	X_out[1] = P[1][num]
	X_out[2] = P[2][num]

	return(X_out)


try:

	serial_inst.isOpen()
	c1 = 'A'
	c2 = 'B'
	c3 = 'C'
	c4 = 'D'
	c5 = 'E'
	c6 = 'F'
	c7 = 'G'
	c8 = 'H'

	NUM_AVG = 3

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

	#serial_inst.reset_output_buffer()
	#serial_inst.reset_input_buffer()			
	#time.sleep(0.001)	
	if ( (c11 != None) & (c22 != None) ):
		if ( (c33 != None) & (c44 != None) ):
			if ( (c55 != None) & (c66 != None) ):
				if ( (c77 != None) & (c88 != None) ):
					Anchors_Adrs = [65,66,67,68,69,70,71,72]
					DIST = [0,0,0,0,0,0,0,0]
					while(1):
						DATA = np.zeros([7,2])
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

						X = localization(DIST)
						print("Position(mm):")
						print(round(X[0]))
						print(round(X[1]))
						print(round(X[2]))

except KeyboardInterrupt:
	print("done.")



