#!/usr/bin/env python3
import numpy as np
import math

def rotation_matrix(roll_inp,pitch_inp,yaw_inp):

	R_out = np.zeros([3,3])

	phi = roll_inp * np.pi / 180.0 #in radians
	theta = pitch_inp * np.pi / 180.0 #in radians
	psi = yaw_inp * np.pi / 180.0 #in radians

	C_phi = np.cos(phi)
	S_phi = np.sin(phi)

	C_theta = np.cos(theta)
	S_theta = np.sin(theta)

	C_psi = np.cos(psi)
	S_psi = np.sin(psi)

	R_out[0][0] = C_psi * C_theta
	R_out[0][1] = (C_psi * S_theta * S_phi) - (S_psi * C_phi)
	R_out[0][2] = (C_psi * S_theta * C_phi) + (S_psi * S_phi)

	R_out[1][0] = S_psi * C_theta
	R_out[1][1] = (S_psi * S_theta * S_phi) + (C_psi * C_phi)
	R_out[1][2] = (S_psi * S_theta * C_phi) - (C_psi * S_phi)

	R_out[2][0] = -S_theta
	R_out[2][1] = C_theta * S_phi
	R_out[2][2] = C_theta * C_phi

	return R_out
