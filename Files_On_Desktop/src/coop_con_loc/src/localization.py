import numpy as np
import math
from numpy.linalg import multi_dot
from numpy import linalg


def localization(DIST_inp,Initial_inp,Num_Anchors_inp,All_Anchors_inp):
	Num_Anchors = Num_Anchors_inp
	All_Dist = DIST_inp
	All_Anchors = All_Anchors_inp
	X_out = Initial_inp

	Avail_Num_Anchors = Num_Anchors - All_Dist.count(-29)
	Avail_All_Anchors = np.zeros([3,Avail_Num_Anchors])
	Avail_All_Dist = [0]*Avail_Num_Anchors
	j = -1
	for i in range(0,Num_Anchors):
		if (All_Dist[i]>1):
			j = j+1
			Avail_All_Dist[j] = All_Dist[i]
			Avail_All_Anchors[0:3,j] = All_Anchors[0:3,i]

	Num_Anchors = Avail_Num_Anchors
	All_Dist = Avail_All_Dist
	Sorted_Dist_Index = np.argsort(All_Dist)
	All_Anchors = Avail_All_Anchors
	Num_Req_Ref = 1; #number of required reference anchors
	Thresh = 1e+1
	Num_It = 1000
	brk_itr_num = 10
	alpha = 1e-09 * np.diag([3,3,1])
	Num_Ref_Anchors = Num_Anchors
	Range_Ref_Anchors = Sorted_Dist_Index[0:Num_Req_Ref]
	All_Est_Pos = np.zeros([3,Num_Req_Ref])
	Ref_Tot_Num = -1
	for Ref_Anchor_Num in Range_Ref_Anchors:
		A = np.zeros([Num_Anchors-1,3])
		B = [0]*(Num_Anchors-1)
		num_i = -1
		for i in range(0,Num_Anchors):
			if(i!=Ref_Anchor_Num):
				num_i = num_i + 1
				A[num_i,:] = 2*np.transpose((All_Anchors[:,i]-All_Anchors[:,Ref_Anchor_Num]))
				B[num_i] = ( (All_Dist[Ref_Anchor_Num]**2) - multi_dot([np.transpose(All_Anchors[:,Ref_Anchor_Num]),All_Anchors[:,Ref_Anchor_Num]]) ) - ( (All_Dist[i]**2) - multi_dot([np.transpose(All_Anchors[:,i]),All_Anchors[:,i]]) )
		Max_Dist = np.max(All_Dist) + 1000.0
		Weights = np.zeros([Num_Anchors-1,Num_Anchors-1])
		num_i = -1
		for i in range(0,Num_Anchors):
			if(i!=Ref_Anchor_Num):
				num_i = num_i + 1
				Weights[num_i,num_i] = (Max_Dist - All_Dist[i])/Max_Dist
		num = -1
		Abs_Dif_err = 1e+6
		P = np.zeros([3,Num_It])
		#P[:,0] = multi_dot([np.linalg.inv(np.dot(np.transpose(A),A)),np.transpose(A),B])
		P[:,0] = np.transpose(np.zeros([3,1]))
		#P[:,0] = np.transpose(Initial_inp)
		err_Arr = [0]*Num_It
		while(Abs_Dif_err>Thresh):
			num = num+1
			B_hat = np.dot(A,P[:,num])
			e = B - B_hat
			alpha0 = alpha # * 1/(1+(0.1*num))
			P_dot = multi_dot([alpha0,np.transpose(A),Weights,e])
			P[:,num+1] = P[:,num] + P_dot
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

		if(P[2][num]<0):
			alpha[2][2] = -1 * alpha[2][2]
			num = -1
			Abs_Dif_err = 1e+6
			P = np.zeros([3,Num_It])
			#P[:,0] = multi_dot([np.linalg.inv(np.dot(np.transpose(A),A)),np.transpose(A),B])
			P[:,0] = np.transpose(np.zeros([3,1]))
			#P[:,0] = np.transpose(Initial_inp)
			err_Arr = [0]*Num_It
			while(Abs_Dif_err>Thresh):
				num = num+1
				B_hat = np.dot(A,P[:,num])
				e = B - B_hat
				alpha0 = alpha # * 1/(1+(0.1*num))
				P_dot = multi_dot([alpha0,np.transpose(A),Weights,e])
				P[:,num+1] = P[:,num] + P_dot
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

		Ref_Tot_Num = Ref_Tot_Num + 1
		All_Est_Pos[:,Ref_Tot_Num] = P[:,num]
		P = np.zeros([3,Num_It])

	X_out[0] = np.mean(All_Est_Pos[0,:])
	X_out[1] = np.mean(All_Est_Pos[1,:])
	X_out[2] = np.mean(All_Est_Pos[2,:])

	return(X_out)

