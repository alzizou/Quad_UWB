import numpy as np
import math
from numpy.linalg import multi_dot
from numpy import linalg

def EKF(Pos_inp,Acc_inp,x_hat_inp,P_inp,dt_inp):

	A = np.zeros([2,2])
	A[0][1] = 1.0

	B = np.zeros([2,1])
	B[1][0] = 1.0

	C = np.zeros([1,2])
	C[0][0] = 1.0

	q = 10.0
	r = 10.0
	Q = multi_dot([q,np.eye(2)])
	R = r #multi_dot([r,np.eye(3)])
	R_inv = 1.0/R #np.linalg.inv(R)

	u = Acc_inp[0]
	y = Pos_inp[0]
	x_hat = x_hat_inp
	P = P_inp
	dt = 0.001*dt_inp

	P_dot_1 = multi_dot([A,P])
	P_dot_2 = multi_dot([P,np.transpose(A)])
	P_dot_3 = multi_dot([Q,np.transpose(Q)])
	P_dot_4 = -multi_dot([P,np.transpose(C),C,P]) #R_inv
	P_dot = np.add(P_dot_1,P_dot_2)
	P_dot = np.add(P_dot,P_dot_3)
	P_dot = np.add(P_dot,P_dot_4)

	x_hat_dot_1 = multi_dot([A,x_hat])
	x_hat_dot_2 = B #multi_dot([B,u])
	x_hat_dot_2[1][0] = u
	x_hat_dot_3 = -multi_dot([C,x_hat])
	x_hat_dot_4 = np.add(y,x_hat_dot_3)
	x_hat_dot_5 = multi_dot([P,np.transpose(C),x_hat_dot_4]) #R_inv
	x_hat_dot = np.add(x_hat_dot_1,x_hat_dot_2)
	x_hat_dot = np.add(x_hat_dot,x_hat_dot_5)

	P = P + (multi_dot([dt,P_dot]))
	x_hat = x_hat + (multi_dot([dt,x_hat_dot]))

	return x_hat,P


