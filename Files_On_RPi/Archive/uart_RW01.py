import serial
import time 

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



try:

	serial_inst.isOpen()
	c1 = 'A'
	c2 = 'B'
	c3 = 'C'
	c4 = 'D'

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
				print("Anchor-A:")
				distance_print()
				time.sleep(0.01)
				print("Anchor-B:")
				distance_print()
				time.sleep(0.01)
				print("Anchor-C:")
				distance_print()
				time.sleep(0.01)
				print("Anchor-D:")
				distance_print()
				time.sleep(0.01)


		
		

except KeyboardInterrupt:
	print("done.")



