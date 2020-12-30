import serial
import struct
import time

serial_inst = serial.Serial("/dev/ttyAMA0")
serial_inst.baudrate = 115200

try:

	while(1):

		#serial_inst.write(b'50');
		#time.sleep(0.01);
	
		data0 = serial_inst.read(1)
		data0_int = struct.unpack('>B',data0)
		data1 = serial_inst.read(1)
		data1_int = struct.unpack('>B',data1)
		data2 = serial_inst.read(1)
		data2_int = struct.unpack('>B',data2)
		data3 = serial_inst.read(1)
		data3_int = struct.unpack('>B',data3)
		data_final = (int(data0_int[0]) * 256 + int(data1_int[0]))* 65536 + int(data2_int[0]) * 256 + int(data3_int[0]) 
		# print("%d" % data0_int)
		# print("%d" % data1_int)
		# print("%d" % data2_int)
		# print("%d" % data3_int)
		print("%d" % data_final)

		
		


except KeyboardInterrupt:
	print("done.")


