import socket
import time
server_UWB = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
server_UWB.setsockopt(socket.SOL_SOCKET,socket.SO_REUSEADDR,1)

host_UWB = socket.gethostbyname('192.168.0.58')
server_UWB.bind((host_UWB,80))
server_UWB.listen(10)
print("Server created:"+host_UWB)

client1 = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
client2 = socket.socket(socket.AF_INET,socket.SOCK_STREAM)

All_Clients = [client1,client2]
All_Address = [' ',' ']

num_clients = 2
data = [0]*num_clients
received_data = [0]*num_clients

num = -1
while True:
	conn, addr = server_UWB.accept()
	num = num+1
	All_Clients[num] = conn
	All_Address[num] = addr
	print(All_Address[num])
	if (num == num_clients-1):
		break

while True:
	for num_cl in [0,1]:
		All_Clients[num_cl].send('1'.encode())
		data[num_cl] = All_Clients[num_cl].recv(4096)
		if not data[num_cl]: break
		received_data[num_cl] = data[num_cl].decode()
		for_print = int(received_data[num_cl])
		print(for_print)
		#to_client = str(for_print+0)
		#All_Clients[num_cl].send(to_client.encode())
		#time.sleep(2)
