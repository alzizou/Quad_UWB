import numpy as np
import math
from numpy.linalg import multi_dot
from numpy import linalg


def localization(DIST_inp,Initial_inp,Num_Anchors_inp,All_Anchors_inp):
	Num_Anchors = Num_Anchors_inp
	All_Dist = DIST_inp
	All_Anchors = All_Anchors_inp
	X_out = np.transpose(Initial_inp)

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
	All_Anchors = Avail_All_Anchors
	Num_Ref_Anchors = Num_Anchors
	Range_Ref_Anchors = range(0,2) #Num_Anchors)
	All_Est_Pos = np.zeros([3,2]) #Num_Ref_Anchors])
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

		pos_est = multi_dot([np.linalg.inv(np.dot(np.transpose(A),A)),np.transpose(A),B])

		Ref_Tot_Num = Ref_Tot_Num + 1
		All_Est_Pos[:,Ref_Tot_Num] = pos_est

	X_out[0] = np.mean(All_Est_Pos[0,:])
	X_out[1] = np.mean(All_Est_Pos[1,:])
	X_out[2] = np.mean(All_Est_Pos[2,:])

	return(X_out)

