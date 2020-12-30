import socket
import time
import select
server_UWB = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
server_UWB.setsockopt(socket.SOL_SOCKET,socket.SO_REUSEADDR,1)
server_UWB.settimeout(0.1)

host_UWB = socket.gethostbyname('192.168.0.70')
server_UWB.bind((host_UWB,80))
server_UWB.listen(10)
print("Server created:"+host_UWB)

data = []
received_data = []
All_Clients = []
All_Address = []
All_Clients_connected = []
All_Address_connected = []

try:
	num = -1
	while True:
		if (num>-1):
			for num_cl in range(0,num+1):
				All_Clients_connected[num_cl].send('1'.encode())
				try:
					data.append(All_Clients_connected[num_cl].recv(4096))
					if data[num_cl]:
						received_data.append(data[num_cl].decode())
				except socket.error:
					break
				except socket.timeout:
					break

		while 1:
			try:
				conn, addr = server_UWB.accept()
				All_Clients.append(conn)
				All_Address.append(addr)
			except socket.timeout:
				break
			except socket.error:
				break

		C1,C2,C3 = select.select(All_Clients,All_Clients,All_Clients,0.1)
		print(C1)
		print(C2)
		print(C3)
		C4 = list(set(C2) - set(C1))
		Num_available = len(C2) - len(C1)
		print("number of connected clients: %u" % Num_available)
		All_Clients_connected = [0]*Num_available
		All_Address_connected = [' ']*Num_available
		num = -1
		if (Num_available>0):
			for s in range(1,Num_available+1):
				num = num+1
				All_Clients_connected[num] = C4[num]
				All_Address_connected[num] = C4[num].getpeername()
				print(All_Address_connected[num])
				print("hi")


except KeyboardInterrupt:
	print("UWB-Server is terminated!")
