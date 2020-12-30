import serial

def distance(serial_inst_inp):
	output = [0]*2
	n = 0
	data0 = serial_inst_inp.readline()
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

	return(output)
