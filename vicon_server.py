import numpy as np
import socket
import json

server = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
server.bind(('192.168.1.2',8100))
server.settimeout(0.01)

client = ('192.168.1.24',8100)
print("UDP connection with the client is provided.")

def ViconStream():
        while 1:
                try:
                        file = open("fly09.txt","r")
                        data = file.readlines()[-1]
                        a = data.index('Data')
                        b = data[a+7:].split()
                        c = [float(b[0]),float(b[1]),float(b[2]),float(b[3]),float(b[4]),float(b[5])]
                        print(c)
                        dataToSend = json.dumps({'vicon_pos':c})
                        server.sendto(dataToSend.encode(),client)
                except socket.timeout:
                        print("timeout")
                        file.close()

if __name__ == '__main__':
        try:
                ViconStream()
        except:                
                pass

            
