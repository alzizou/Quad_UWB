import numpy as np
import math
from numpy.linalg import multi_dot
from numpy import linalg


def velocitization(Diff_DIST_inp,DIST_inp,Diff_delta_inp,Pos_UWB_inp,Initial_Vel_inp,Num_Anchors_inp,All_Anchors_inp):
	Num_Anchors = Num_Anchors_inp
	All_Dist = DIST_inp
	All_Diff_Dist = Diff_DIST_inp
	All_Diff_delta = Diff_delta_inp
	All_Anchors = All_Anchors_inp
	Vel_out = Initial_Vel_inp

	Avail_Num_Anchors = Num_Anchors - All_Dist.count(-29)
	Avail_All_Anchors = np.zeros([3,Avail_Num_Anchors])
	Avail_All_Dist = [0]*Avail_Num_Anchors
	Avail_All_Diff_Dist = [0]*Avail_Num_Anchors
	Avail_All_Diff_delta = [0]*Avail_Num_Anchors
	j = -1
	for i in range(0,Num_Anchors):
		if (All_Dist[i]>-1):
			j = j+1
			Avail_All_Dist[j] = All_Dist[i]
			Avail_All_Anchors[0:3,j] = All_Anchors[0:3,i]
			Avail_All_Diff_Dist[j] = All_Diff_Dist[i]
			Avail_All_Diff_delta[j] = All_Diff_delta[i]

	Num_Anchors = Avail_Num_Anchors
	All_Dist = Avail_All_Dist
	All_Diff_Dist = Avail_All_Diff_Dist
	All_Diff_delta = Avail_All_Diff_delta
	All_Anchors = Avail_All_Anchors
	Thresh = 1e+1
	Num_It = 1000
	brk_itr_num = 10
	alpha = 1e-08 * np.diag([1,1,1])

	A = np.zeros([Num_Anchors,3])
	B = [0]*(Num_Anchors)
	Max_Dist = np.max(All_Dist) + 1000
	Weights = np.zeros([Num_Anchors,Num_Anchors])
	for i in range(0,Num_Anchors):
		A[i,:] = np.transpose(Pos_UWB_inp - All_Anchors[:,i])
		B[i] = (All_Dist[i] * All_Diff_Dist[i]) + (0.5*All_Diff_delta[i])
		Weights[i,i] = (Max_Dist - All_Dist[i])/Max_Dist

	num = -1
	Abs_Dif_err = 1e+6
	V = np.zeros([3,Num_It])
	#V[:,0] = multi_dot([np.linalg.inv(np.dot(np.transpose(A),A)),np.transpose(A),B])
	V[:,0] = np.transpose(np.zeros([3,1]))
	#V[:,0] = np.transpose(Initial_Vel_inp)
	err_Arr = [0]*Num_It
	while(Abs_Dif_err>Thresh):
		num = num+1
		B_hat = np.dot(A,V[:,num])
		e = B - B_hat
		alpha0 = alpha # * 1/(1+(0.1*num))
		V_dot = multi_dot([alpha0,np.transpose(A),Weights,e])
		V[:,num+1] = V[:,num] + V_dot
		err = linalg.norm(e)
		err_Arr[num] = err
		if(num>1):
			Dif_err = err_Arr[num] - err_Arr[num-1]
			Abs_Dif_err = abs(Dif_err)
		if(num>brk_itr_num):
			if(Dif_err>0):
				break
		if(num>(Num_It-brk_itr_num)):
			break

	Vel_out[0] = V[0,num]
	Vel_out[1] = V[1,num]
	Vel_out[2] = V[2,num]

	return(Vel_out)

