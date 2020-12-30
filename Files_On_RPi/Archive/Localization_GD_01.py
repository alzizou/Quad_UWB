import serial
import time 
import numpy as np
import math
from numpy.linalg import multi_dot
from numpy import linalg 

serial_inst = serial.Serial("/dev/serial0")
serial_inst.baudrate = 115200


def distance_print():
	n = 0
	data0 = serial_inst.readline()
	for i in range(0,len(data0)):
		if data0[i]==32:
			n = i-1
			break
	
	data = 0
	for j in range(0,n):
		data = data + ( (data0[j] - 48)*(10**(n-j)) )
	 		
	data = data + (data0[n] - 48)
	print(data)

	return


def distance_return():
	n = 0
	data0 = serial_inst.readline()
	for i in range(0,len(data0)):
		if data0[i]==32:
			n = i-1
			break
	
	data = 0
	for j in range(0,n):
		data = data + ( (data0[j] - 48)*(10**(n-j)) )
	 		
	data = data + (data0[n] - 48)

	return(data)


def localization(dist01_inp,dist02_inp,dist03_inp,dist04_inp):
	Anchor01 = [0,0,711] #A
	Anchor02 = [5360,0,737] #B
	Anchor03 = [-305,5868,356] #C
	Anchor04 = [5944,5842,350] #D

	X_out = [0,0,0]

	A = np.array([[-2*Anchor01[0],-2*Anchor01[1],-2*Anchor01[2],1],
			[-2*Anchor02[0],-2*Anchor02[1],-2*Anchor02[2],1],
			[-2*Anchor03[0],-2*Anchor03[1],-2*Anchor03[2],1],
                        [-2*Anchor04[0],-2*Anchor04[1],-2*Anchor04[2],1]])

	Y = [( (dist01_inp**2)-(Anchor01[0]**2)-(Anchor01[1]**2)-(Anchor01[2]**2) ),
		( (dist02_inp**2)-(Anchor02[0]**2)-(Anchor02[1]**2)-(Anchor02[2]**2) ),
		( (dist03_inp**2)-(Anchor03[0]**2)-(Anchor03[1]**2)-(Anchor03[2]**2) ),
		( (dist04_inp**2)-(Anchor04[0]**2)-(Anchor04[1]**2)-(Anchor04[2]**2) )]

	Max_Dist = max([dist01_inp,dist02_inp,dist03_inp,dist04_inp]) + 500
	Sum_Dist = (Max_Dist - dist01_inp) + (Max_Dist - dist02_inp) + (Max_Dist - dist03_inp) + (Max_Dist - dist04_inp)
	w1 = (Max_Dist - dist01_inp)/Sum_Dist
	w2 = (Max_Dist - dist02_inp)/Sum_Dist
	w3 = (Max_Dist - dist03_inp)/Sum_Dist
	w4 = (Max_Dist - dist04_inp)/Sum_Dist
	W = np.diag([w1,w2,w3,w4])
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

		Y_hat = [( (dist01_hat**2)-(Anchor01[0]**2)-(Anchor01[1]**2)-(Anchor01[2]**2) ),
                      ( (dist02_hat**2)-(Anchor02[0]**2)-(Anchor02[1]**2)-(Anchor02[2]**2) ),
                      ( (dist03_hat**2)-(Anchor03[0]**2)-(Anchor03[1]**2)-(Anchor03[2]**2) ),
                      ( (dist04_hat**2)-(Anchor04[0]**2)-(Anchor04[1]**2)-(Anchor04[2]**2) )]

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

		if(num>10):
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

			Y_hat = [( (dist01_hat**2)-(Anchor01[0]**2)-(Anchor01[1]**2)-(Anchor01[2]**2) ),
                            ( (dist02_hat**2)-(Anchor02[0]**2)-(Anchor02[1]**2)-(Anchor02[2]**2) ),
                            ( (dist03_hat**2)-(Anchor03[0]**2)-(Anchor03[1]**2)-(Anchor03[2]**2) ),
                            ( (dist04_hat**2)-(Anchor04[0]**2)-(Anchor04[1]**2)-(Anchor04[2]**2) )]

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

			if(num>10):
				if(Dif_err>0):
					break
	
			if(num>(Num_It-50)):
				break


	X_out[0] = P[0][num]
	X_out[1] = P[1][num]
	X_out[2] = P[2][num]

	return(X_out)



def MeasuredArray(dist_inp,distArray_inp,NUM_inp):
	for i in range(0,(NUM_inp-2)):
		distArray_inp[i+1] = distArray_inp[i]

	distArray_inp[0] = dist_inp
	return(distArray_inp)



def AverageFilter(distArray_inp,NUM_inp):
	SUM = 0	
	for i in range(0,(NUM_inp-1)):
		SUM = SUM + distArray_inp[i]

	AVG = SUM/NUM_inp
	return(AVG)
	


try:

	serial_inst.isOpen()
	c1 = 'A'
	c2 = 'B'
	c3 = 'C'
	c4 = 'D'

	NUM_AVG = 10
	dist01_Array = [0]*NUM_AVG
	dist02_Array = [0]*NUM_AVG
	dist03_Array = [0]*NUM_AVG
	dist04_Array = [0]*NUM_AVG

	while(1):
		c11 = None
		c22 = None
		c33 = None
		c44 = None
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
		
		time.sleep(0.01)	
		if ( (c11 != None) & (c22 != None) ):
			if ( (c33 != None) & (c44 != None) ):
                                dist01 = distance_return()
                                time.sleep(0.001)
                                dist02 = distance_return()
                                time.sleep(0.001)
                                dist03 = distance_return()
                                time.sleep(0.001)
                                dist04 = distance_return()
                                time.sleep(0.001)
                                dist01_Array = MeasuredArray(dist01,dist01_Array,NUM_AVG)
                                dist02_Array = MeasuredArray(dist02,dist02_Array,NUM_AVG)
                                dist03_Array = MeasuredArray(dist03,dist03_Array,NUM_AVG)
                                dist04_Array = MeasuredArray(dist04,dist04_Array,NUM_AVG)
                                dist01_AVG = AverageFilter(dist01_Array,NUM_AVG)
                                dist02_AVG = AverageFilter(dist02_Array,NUM_AVG)
                                dist03_AVG = AverageFilter(dist03_Array,NUM_AVG)
                                dist04_AVG = AverageFilter(dist04_Array,NUM_AVG)
                                X = localization(dist01_AVG,dist02_AVG,dist03_AVG,dist04_AVG)
                                print("Position(mm):")
                                print(round(X[0]))
                                time.sleep(0.001)
                                print(round(X[1]))
                                time.sleep(0.001)
                                print(round(X[2]))
                                time.sleep(0.001)														


			

except KeyboardInterrupt:
	print("done.")



