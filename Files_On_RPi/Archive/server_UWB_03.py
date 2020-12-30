import socket
import time
import select
server_UWB = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
server_UWB.setsockopt(socket.SOL_SOCKET,socket.SO_REUSEADDR,1)

host_UWB = socket.gethostbyname('192.168.0.70')
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

try:
	B = 0
	while True:
		num = -1
		while True:
			C1,C2,C3 = select.select([server_UWB],(),[server_UWB],5)
			for s in C1:
				if(s is not server_UWB):
					print("Timeout!")
					B = 1
					break
				else:
					conn, addr = server_UWB.accept()
					num = num+1
					All_Clients[num] = conn
					All_Address[num] = addr
					print(All_Address[num])
					if (num == num_clients-1):
						B = 1
						break
			if(B==1):
				break

		num1 = -1
		while True:
			for num_cl in [0,1]:
				try:
					All_Clients[num_cl].send('1'.encode())
					data[num_cl] = All_Clients[num_cl].recv(4096)
					if not data[num_cl]:
						received_data[num_cl] = data[num_cl].decode()
						for_print = int(received_data[num_cl])
						print(for_print)
				except:
					print("Looking for client - %u!" % num_cl)
					num1 = num1 + 1
					break

			if(num1>10):
				break

except KeyboardInterrupt:
	print("Server-UWB is terminated!")
