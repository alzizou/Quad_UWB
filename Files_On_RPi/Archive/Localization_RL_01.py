import serial
import time
import numpy as np
import math
from pymavlink import mavutil

serial_inst = serial.Serial("/dev/serial0")
serial_inst.baudrate = 115200

PX4_connection = mavutil.mavlink_connection("/dev/ttyACM0")
PX4_connection.wait.heartbeat()
print("PX4 Hearthbeat(%u,%u)" % (PX4_connection.target_system,PX4_connection.target_system))

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

	return output

def SLM_diff(inp,inp_v,inp_v1):
	output = [0]*3
	k1 = 1
	k2 = 1
	err = inp - inp_v
	err_sgn = np.sign(err)
	err_abs = np.abs(err)
	v1_dot = -k2*err_sgn
	v1 = inp_v1 + v1_dot
	v_dot = v1 - k1 * np.power(err_abs,0.5) * err_sgn
	v = inp_v + v_dot
	output[0] = v_dot
        output[1] = v
        output[2] = v1
        return output


try:
	c1 = 'A'
	c11 = None
	while(c11 == None):
		serial_inst.write(c1.encode())
		time.sleep(0.001)
		c11 = serial_inst.readline()

	serial_inst.close()

	if(c11!=None):
		dist = 0
		diff_dist = 0
		diff_dist_v = 0
		diff_dist_v1 = 0
		DATA_diff = [0,0,0]
		Pos_hat = [0,0,0]
		Vel_hat = [0,0,0]
		Acc = [0,0,0]
		Results_File = open("Results_File.txt","w+")
		alpha_vel = 0.1
		e_vel = 0
		g_vel = 0
		alpha_pos = 0.1
		Dot_Vel_hat = [0,0,0]
		e_pos = 0
		g_pos = 0
		Dot_Pos_hat = [0,0,0]
		while(1):
			serial_inst.open()
			serial_inst.flush()

			DATA = [0,0]
			MEAS = distance_return()
			DATA[0] = MEAS[0]
			DATA[1] = MEAS[1]
			dist = DATA[1]

			DATA_diff = SLM_diff(dist,diff_dist_v,diff_dist_v1)
			diff_dist = DATA_diff[0]
			diff_dist_v = DATA_diff[1]
			diff_dist_v1 = DATA_diff[2]

			PX4_msg = PX4_connection.recv_match(type='HIGHRES_IMU',blocking=True)
			Acc[0] = PX4_msg.xacc * 1000
			Acc[1] = PX4_msg.yacc * 1000
			Acc[2] = PX4_msg.zacc * 1000

			e_vel = (diff_dist*diff_dist) - (np.multiply(np.transpose(Vel_hat),Vel_hat))
			g_vel = np.multiply(np.transpose(Acc),Vel_hat)
			Dot_Vel = (1 + alpha_vel*np.sign(e_vel*g_vel)) * Acc
			Vel_hat = np.add(Vel_hat,Dot_Vel)

			e_pos = (dist*dist) - (np.multiply(np.transpose(Pos_hat),Pos_hat))
			g_pos = np.multiply(np.transpose(Vel_hat),Pos_hat)
			Dot_Pos = (1 + alpha_pos*np.sign(e_pos*g_pos)) * Vel_hat
			Pos_hat = np.add(Pos_hat,Dot_Pos)

			print("Pos_hat_x = %d , Pos_hat_y = %d , Pos_hat_z = %d\r\n" % (Pos_hat[0],Pos_hat[1],Pos_hat[2]))
			print("Vel_hat_x = %d , Vel_hat_y = %d , Vel_hat_z = %d\r\n" % (Vel_hat[0],Vel_hat[1],Vel_hat[2]))
			Results_File.write("%d %d %d %d %d %d\r\n" % (Pos_hat[0],Pos_hat[1],Pos_hat[2],Vel_hat[0],Vel_hat[1],Vel_hat[2]))


except KeyboardInterrupt:
	Results_File.close()
	print("done.")

