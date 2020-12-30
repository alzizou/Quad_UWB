import socket
server_UWB = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
server_UWB.setsockopt(socket.SOL_SOCKET,socket.SO_REUSEADDR,1)

host_UWB = socket.gethostbyname('192.168.0.58')
server_UWB.bind((host_UWB,80))
server_UWB.listen(10)
print("Server created:"+host_UWB)

while True:
	conn, addr = server_UWB.accept()
	while True:
		data = conn.recv(4096)
		if not data: break
		received_data = data.decode()
		for_print = int(received_data)
		print(for_print)
		to_client = str(for_print+10)
		conn.send(to_client.encode())

	conn.close()

