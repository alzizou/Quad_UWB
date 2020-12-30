import numpy as np
import math
from numpy.linalg import multi_dot
from numpy import linalg

A = np.zeros([6,6])
A[0][3] = 1.0
A[1][4] = 1.0
A[2][5] = 1.0

B = np.zeros([6,3])
B[3][0] = 1.0
B[4][1] = 1.0
B[5][2] = 1.0

C = np.zeros([3,6])
C[0][0] = 1.0
C[1][1] = 1.0
C[2][2] = 1.0

q = 1.0
r = 1.0
Q = np.eye(6)*q
R = np.eye(3)*r
R_inv = np.linalg.inv(R)

def EKF(Pos_inp,Acc_inp,x_hat_inp,P_inp,dt_inp):

	u = np.zeros([3,1])
	y = np.zeros([3,1])

	u[0][0] = Acc_inp[0]
	u[1][0] = Acc_inp[1]
	u[2][0] = Acc_inp[2]

	y[0][0] = Pos_inp[0]
	y[1][0] = Pos_inp[1]
	y[2][0] = Pos_inp[2]

	x_hat = x_hat_inp
	P = P_inp
	dt = 1.0*dt_inp

	P_dot_1 = np.dot(A,P)
	P_dot_2 = np.dot(P,np.transpose(A))
	P_dot_3 = np.dot(Q,np.transpose(Q))
	P_dot_4 = multi_dot([P,np.transpose(C),R_inv,C,P]) * -1.0
	P_dot = np.add(P_dot_1,P_dot_2)
	P_dot = np.add(P_dot,P_dot_3)
	P_dot = np.add(P_dot,P_dot_4)

	x_hat_dot_1 = np.dot(A,x_hat)
	x_hat_dot_2 = np.dot(B,u)
	x_hat_dot_3 = np.dot(C,x_hat) * -1.0
	x_hat_dot_4 = np.add(y,x_hat_dot_3)
	x_hat_dot_5 = multi_dot([P,np.transpose(C),R_inv,x_hat_dot_4])
	x_hat_dot_6 = np.add(x_hat_dot_1,x_hat_dot_2)
	x_hat_dot = np.add(x_hat_dot_6,x_hat_dot_5)

	P = P + (P_dot*dt)
	x_hat = x_hat + (x_hat_dot*dt)

	return x_hat,P


