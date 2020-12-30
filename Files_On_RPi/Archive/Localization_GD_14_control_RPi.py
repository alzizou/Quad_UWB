import serial
import time 
import numpy as np
from pymavlink import mavutil
import socket
import json
from distance_return import distance_return
from Localization import localization
from EKF import EKF

serial_inst = serial.Serial("/dev/serial0")
serial_inst.baudrate = 115200

UWB_Server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
UWB_Server.setsockopt(socket.SOL_SOCKET,socket.SO_REUSEADDR,1)
UWB_Server.connect(('192.168.0.70',80))
print("connection to server is done")

Client_MySelf = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
Client_MySelf.bind(('192.168.160',8100))
Client_MySelf.settimeout(0.1)

Client_Neighbor1 = ('192.168.0.39',8100)

PX4_connection = mavutil.mavlink_connection("/dev/ttyACM0")
PX4_connection.wait_heartbeat()
print("PX4 Heartbeat(%u,%u,%u,%s,%u)" % (PX4_connection.mav_type, PX4_connection.target_system, PX4_connection.target_component, PX4_connection.flightmode, PX4_connection.base_mode))

try:

	serial_inst.close()
	Num_Anchors = 8
	c = ['A','B','C','D','E','F','G','H']
	Anchors_Adrs = [65,66,67,68,69,70,71,72]
	All_Anchors = np.zeros([3,Num_Anchors])
	All_Anchors[0:3,0] = [-500,205,250] #A
	All_Anchors[0:3,1] = [4750,230,250] #B
	All_Anchors[0:3,2] = [0,5920,280] #C
	All_Anchors[0:3,3] = [5590,5790,405] #D
	All_Anchors[0:3,4] = [0,50,2285] #E
	All_Anchors[0:3,5] = [4880,0,2235] #F
	All_Anchors[0:3,6] = [0,5920,2390] #G
	All_Anchors[0:3,7] = [5255,5790,2285] #H
	c1 = [None]*Num_Anchors
	DIST = [0]*Num_Anchors
	X = [0,0,0]
	X_m = np.zeros([3,1])
	Acc_m = np.zeros([3,1])
	Results_File = open("Results_File.txt","w+")
	Results_File_Dist = open("Results_File_Dist.txt","w+")
	Results_File_EKF = open("Results_File_EKF.txt","w+")
	Results_File_ACC = open("Results_File_ACC.txt","w+")
	time_stmp = 0
	P_EKF = np.eye(6)
	x_hat_EKF = np.zeros([6,1])
	while(1):
		command = None
		command = UWB_Server.recv(4096)
		if((not command)==0):
			command_str = command.decode()
			command_int = int(command_str)
			if(command_int==1):
				serial_inst.open()
				DATA = np.zeros([Num_Anchors,2])
				serial_inst.flush()
				for i in range(0,Num_Anchors):
					while(c1[i]==None):
						serial_inst.write(c[i].encode())
						c1[i] = serial_inst.readline()
					if(c1[i]!=None):
						MEAS = distance_return(serial_inst)
						DATA[i][0] = MEAS[0]
						DATA[i][1] = MEAS[1]
						for j in range(0,Num_Anchors):
							if(DATA[i][0] == Anchors_Adrs[j]):
								DIST[j] = DATA[i][1]
					c1[i] = None
				UWB_Server.send('2'.encode())
				print("\r\nDistances: %d %d %d %d %d %d %d %d" % (DIST[0],DIST[1],DIST[2],DIST[3],DIST[4],DIST[5],DIST[6],DIST[7]))
				Results_File_Dist.write("%d %d %d %d %d %d %d %d\r\n" % (DIST[0],DIST[1],DIST[2],DIST[3],DIST[4],DIST[5],DIST[6],DIST[7]))
				X = localization(DIST,X,Num_Anchors,All_Anchors)
				Results_File.write("%d %d %d\r\n" % (X[0],X[1],X[2]))
				print("Estimated Position: %d %d %d" % (X[0],X[1],X[2]))
				X_m[0] = 0.001*X[0]
				X_m[1] = 0.001*X[1]
				X_m[2] = -0.001*X[2]
				PX4_connection.mav.vision_position_estimate_send(0,X_m[0],X_m[1],X_m[2],0,0,0)
				PX4_msg = PX4_connection.recv_match(type='LOCAL_POSITION_NED',blocking=True)
				PX4_ACC_msg = PX4_connection.recv_match(type='HIGHRES_IMU',blocking=True)
				Acc_m[0] = PX4_ACC_msg.xacc
				Acc_m[1] = PX4_ACC_msg.yacc
				Acc_m[2] = PX4_ACC_msg.zacc
				if not PX4_msg:
					print("PX4 message is not received.")
				if PX4_msg.get_type() == "BAD_DATA":
					print("Nothing to print!")
				else:
					print("%s" % PX4_msg)
					Period = float(PX4_msg.time_boot_ms - time_stmp)
					Frequency = 1000.0/Period
					print("Frequency of position data: %f Hz" %Frequency)
					Results_File_EKF.write("%.6f %.6f %.6f %.6f %.6f %.6f\r\n" % (PX4_msg.x,PX4_msg.y,PX4_msg.z,PX4_msg.vx,PX4_msg.vy,PX4_msg.vz))
					Period_EKF = Period
					if (time_stmp<1):
						Period_EKF = 0.0					
					time_stmp = PX4_msg.time_boot_ms
					#x_hat_EKF,P_EKF = EKF(X_m,Acc_m,x_hat_EKF,P_EKF,Period_EKF)
					#print("My EKF estimations: %.6f , %.6f , %.6f , %.6f , %.6f , %.6f" % (x_hat_EKF[0],x_hat_EKF[1],x_hat_EKF[2],x_hat_EKF[3],x_hat_EKF[4],x_hat_EKF[5]))
					try:
						VelToSend = json.dumps({"vx":PX4_msg.vx, "vy":PX4_msg.vy, "vz":PX4_msg.vz})
						Client_MySelf.sendto(VelToSend.encode(),Client_Neighbor1)
						Resp_Neighbor1, Addrs_Neighbor1 = Client_MySelf.recvfrom(4096)
						Vel_Neighbor1 = json.loads(Resp_Neighbor1.decode())
						Vel_Neighbor1_x = Vel_Neighbor1.get("vx")
						Vel_Neighbor1_y = Vel_Neighbor1.get("vy")
						Vel_Neighbor1_z = Vel_Neighbor1.get("vz")
						print("Received Data from Neighbor: vx=%.6f , vy=%.6f , vz=%.6f" % (float(Vel_Neighbor1_x),float(Vel_Neighbor1_y),float(Vel_Neighbor1_z)))
					except socket.timeout:
						print("No neighbor found!")

					#print("%s" % PX4_ACC_msg)
					Results_File_ACC.write("%.6f %.6f %.6f\r\n" % (PX4_ACC_msg.xacc,PX4_ACC_msg.yacc,PX4_ACC_msg.zacc))
					for i in range(0,10):
						Result_Set = PX4_connection.mav.set_attitude_target_send(0,PX4_connection.target_system,PX4_connection.target_component,0,[1,0,0,0],0,0,0,0.3)
						#Result_Set = PX4_connection.mav.set_position_target_local_ned_send(0,PX4_connection.target_system,PX4_connection.target_component,1,0b101111111000,2,2,-1,0,0,0,0,0,0,0,0)

					current_state_msg = PX4_connection.recv_match(type='HEARTBEAT',blocking=True)
					print("Current_state:%s - %u - %u" % (current_state_msg.base_mode,current_state_msg.custom_mode,current_state_msg.system_status))
					#current_setpoint_msg = PX4_connection.recv_match(type='POSITION_TARGET_LOCAL_NED',blocking=True)
					#print("current_setpoint:X=%u - Y=%u - Z=%u - Vx=%u - Vy=%u - Vz=%u - Yaw=%u - YawRate=%u" % (current_setpoint_msg.x,current_setpoint_msg.y,current_setpoint_msg.z,current_setpoint_msg.vx,current_Setpoint_msg.vy,current_setpoint_msg.vz,current_setpoint_msg.yaw,current_setpoint_msg.yaw_rate))
					num_arm = 0
					while(current_state_msg.system_status is not 4):
						Result_ARM = PX4_connection.mav.command_long_send(PX4_connection.target_system,PX4_connection.target_component,mavutil.mavlink.MAV_CMD_COMPONENT_ARM_DISARM,0,1,0,0,0,0,0,0)
						current_state_msg = PX4_connection.recv_match(type='HEARTBEAT',blocking=True)
						num_arm = num_arm + 1
						if(num_arm>2):
							break
					if(current_state_msg.system_status is 4):
						num_mode =0
						while(PX4_connection.flightmode is not 'OFFBOARD'):
							Result_Mod_Chng = PX4_connection.mav.command_long_send(PX4_connection.target_system,PX4_connection.target_component,mavutil.mavlink.MAV_CMD_DO_SET_MODE,0,29,6,0,0,0,0,0)
							num_mode = num_mode + 1
							if(num_mode>2):
								break
					print("PX4 Base Mode: %s - %s" % (PX4_connection.flightmode, PX4_connection.base_mode))
					PX4_msg2 = PX4_connection.recv_match(type='SERVO_OUTPUT_RAW',blocking=True)
					print("%s" % PX4_msg2)
					#print("Res_set:%s , Res_arm:%s , Res_mod:%s" % (Result_Set,Result_ARM,Result_Mod_Chng))



				serial_inst.close()

except KeyboardInterrupt:
	Results_File.close()
	Results_File_Dist.close()
	Results_File_EKF.close()
	Results_File_ACC.close()

	current_state_msg = PX4_connection.recv_match(type='HEARTBEAT',blocking=True)
	num_disarm = 0
	while(current_state_msg.system_status is not 3):
		PX4_connection.mav.command_long_send(PX4_connection.target_system,PX4_connection.target_component,mavutil.mavlink.MAV_CMD_COMPONENT_ARM_DISARM,0,0,0,0,0,0,0,0)
		current_state_msg = PX4_connection.recv_match(type='HEARTBEAT',blocking=True)
		num_disarm = num_disarm + 1

	UWB_Server.close()
	Client_MySelf.close()
	print("The connection to UWB-server is terminated. done!")

