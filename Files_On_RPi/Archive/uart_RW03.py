import serial
import time 
import numpy as np

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


def localization(dist01_inp,dist02_inp,dist03_inp,dist04_inp,dist05_inp,Z_Bias_INP):
	Anchor01 = [0,0,711] #A
	Anchor02 = [5360,0,737] #B
	Anchor03 = [-305,5868,356] #C
	Anchor04 = [5944,5842,0] #D
	Anchor05 = [7417,3048,1118] #E

	A = np.array([[2*(Anchor02[0]-Anchor01[0]),2*(Anchor02[1]-Anchor01[1]),2*(Anchor02[2]-Anchor01[2])],
			[2*(Anchor03[0]-Anchor01[0]),2*(Anchor03[1]-Anchor01[1]),2*(Anchor03[2]-Anchor01[2])],
			[2*(Anchor04[0]-Anchor01[0]),2*(Anchor04[1]-Anchor01[1]),2*(Anchor04[2]-Anchor01[2])],
			[2*(Anchor05[0]-Anchor01[0]),2*(Anchor05[1]-Anchor01[1]),2*(Anchor05[2]-Anchor01[2])]])

	Y = [((Anchor02[0]**2)+(Anchor02[1]**2)+(Anchor02[2]**2)-(Anchor01[0]**2)-(Anchor01[1]**2)-(Anchor01[2]**2)-(dist02_inp**2)+(dist01_inp**2)),
		((Anchor03[0]**2)+(Anchor03[1]**2)+(Anchor03[2]**2)-(Anchor01[0]**2)-(Anchor01[1]**2)-(Anchor01[2]**2)-(dist03_inp**2)+(dist01_inp**2)),
		((Anchor04[0]**2)+(Anchor04[1]**2)+(Anchor04[2]**2)-(Anchor01[0]**2)-(Anchor01[1]**2)-(Anchor01[2]**2)-(dist04_inp**2)+(dist01_inp**2)),
		((Anchor05[0]**2)+(Anchor05[1]**2)+(Anchor05[2]**2)-(Anchor01[0]**2)-(Anchor01[1]**2)-(Anchor01[2]**2)-(dist05_inp**2)+(dist01_inp**2))]

	At = np.transpose(A)
	B = np.dot(At,A)
	B_inv = np.linalg.inv(B)
	C = np.dot(B_inv,At)
	X_out = np.dot(C,Y)
	X_out[2] = X_out[2] + Z_Bias_INP

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
	c5 = 'E'

	NUM_AVG = 40
	dist01_Array = [0]*NUM_AVG
	dist02_Array = [0]*NUM_AVG
	dist03_Array = [0]*NUM_AVG
	dist04_Array = [0]*NUM_AVG
	dist05_Array = [0]*NUM_AVG

	Z_Bias = 0

	while(1):
		c11 = None
		c22 = None
		c33 = None
		c44 = None
		c55 = None
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
		
		time.sleep(0.01)	
		if ( (c11 != None) & (c22 != None) ):
			if ( (c33 != None) & (c44 != None) ):
				if ( (c55 != None) ):
					dist01 = distance_return()
					time.sleep(0.001)
					dist02 = distance_return()
					time.sleep(0.001)
					dist03 = distance_return()
					time.sleep(0.001)
					dist04 = distance_return()
					time.sleep(0.001)
					dist05 = distance_return()
					time.sleep(0.001)
					dist01_Array = MeasuredArray(dist01,dist01_Array,NUM_AVG)
					dist02_Array = MeasuredArray(dist02,dist02_Array,NUM_AVG)
					dist03_Array = MeasuredArray(dist03,dist03_Array,NUM_AVG)
					dist04_Array = MeasuredArray(dist04,dist04_Array,NUM_AVG)
					dist05_Array = MeasuredArray(dist05,dist05_Array,NUM_AVG)
					dist01_AVG = AverageFilter(dist01_Array,NUM_AVG)
					dist02_AVG = AverageFilter(dist02_Array,NUM_AVG)
					dist03_AVG = AverageFilter(dist03_Array,NUM_AVG)
					dist04_AVG = AverageFilter(dist04_Array,NUM_AVG)
					dist05_AVG = AverageFilter(dist05_Array,NUM_AVG)
					X = localization(dist01_AVG,dist02_AVG,dist03_AVG,dist04_AVG,dist05_AVG,Z_Bias)
					print("Position(mm):")
					print(round(X[0]))
					time.sleep(0.01)
					print(round(X[1]))
					time.sleep(0.01)
					print(round(X[2]))
					time.sleep(0.01)														


			

except KeyboardInterrupt:
	print("done.")



