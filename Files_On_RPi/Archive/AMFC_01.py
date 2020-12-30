import serial
import time
import numpy as np
import math
from numpy.linalg import multi_dot
from numpy import linalg
from pymavlink import mavutil
import socket


def AMFC_main(inp_x,inp_zeta,inp_sigma,inp_g,inp_A,inp_P,inp_DifDes):
	n = 6
	u1 = [0]*n
	u2 = [0]*n
	u = [0]*n
	B = [1]*n
	Q = [1]*n
	for i in range(0,n-1):
		u1[i] = (1/B[i]) * ( inp_DifDes[i] - (inp_A[i] * inp_x[i]) - inp_g[i] - inp_zeta[i] + ((1 + (2*Q[i]/inp_P[i])*inp_sigma[i])
		u2[i] = -1/4*R[i]*B[i]*inp_P[i]*inp_sigma[i]
		u[i] = u1[i] + u2[i]

	return u


def AMFC_Adpt_nlin(inp_sigma,inp_P,inp_g):
	n = 6
	g_dot = [0]*n
	otp_g = inp_g
	Gamma = 1e+2*[1e-6,1e-6,1e-6,1e0,1e0,1e0]
	rho = 1e-0
	for i in range(0,n-1):
		g_dot[i] = -Gamma[i]*inp_P[i]*inp_sigma[i] - rho*Gamma[i]*inp_g[i]
		otp_g[i] = otp_g[i] + g_dot[i]

	return otp_g


def AMFC_Adpt_lin(inp_sigma,inp_x,inp_P,inp_A):
	n = 6
	A_dot = [0]*n
	otp_A = inp_A
	Gamma = 1e+0*[1e-6,1e-6,1e-6,1e0,1e0,1e0]
	rho = 1e-0
	for i in range(0,n-1):
		A_dot[i] = -Gamma[i]*inp_P[i]*(inp_x[i] - inp_sigma[i]) - rho*Gamma[i]*inp_A[i]
		otp_A[i] = otp_A[i] + A_dot[i]

	return otp_A


def AMFC_P_upd(inp_p,inp_A):
	n = 6
	P_dot = [0]*n
	otp_P = inp_P
	Q = [1]*n
	B = [1]*n
	R = [1]*n
	for i in range(0,n-1):
		P_dot[i] = 2*inp_A[i]*inp_P[i] - inp_P[i]*B[i]*R[i]*B[i]*inp_P[i] + 2*Q[i]
		otp_P[i] = otp_P[i] + P_dot[i]

	return otp_P


def AMFC_DifDes(inp_des,inp_DifDes_Param1,inp_DifDes_Param2):
	n = 6
	k1 = 1
	k2 = 1 #0.1
	otp_DifDes = [0]*n
	Param1_dot = [0]*n
	Param2_dot = [0]*n
	otp_DifDes_Param1 = inp_DifDes_Param1 #w_i
	otp_DifDes_Param2 = inp_DifDes_Param2 #tau_i
	for i in range(0,n-1):
		otp_DifDes[i] = -k1*np.power(np.absolute(inp_DifDes_Param1[i]-inp_des[i]),0.5)*np.sign(inp_DifDes_Param1[i]-inp_des[i]) + inp_DifDes_Param2[i]
		Param2_dot[i] = -k2*np.sign(inp_DifDes_Param1[i]-inp_des[i])
		otp_DifDes_Param2[i] = otp_DifDes_Param2[i] + Param2_dot[i]
		Param1_dot[i] = otp_DifDes[i]
		otp_DifDes_Param1[i] = otp_DifDes_Param1[i] + Param1_dot[i]

	return otp_DifDes,otp_DifDes_Param1,otp_DifDes_Param2


def AMFC_Err(inp_Des,u,inp_x,inp_zeta)
	n = 6
	Err = [0]*n
	INT_Des = [inp_Des[0],inp_Des[1],inp_Des[2],u[0],u[1],u[2]]
	otp_sigma = [0]*n
	otp_zeta = inp_zeta
	for i in range(0,n-1):
		Err[i] = INT_Des[i] - inp_x[i]
		otp_zeta[i] = otp_zeta[i] + Err[i]
		otp_sigma[i] = Err[i] + otp_zeta[i]

	return otp_zeta,otp_sigma


def AMFC_X(inp_pos,inp_rate):
	n = 6
	otp_x = [inp_pos[0],inp_pos[1],inp_pos[2],inp_rate[0],inp_rate[1],inp_rate[2]]
	return otp_x


def AMFC_msg_trn(inp_msg_trn):
	otp_pos = [inp_msg_trn.x,inp_msg_trn.y,inp_msg_trn.z]
	otp_rate = [inp_msg_trn.vx,inp_msg_trn.vy,inp_msg_trn.vz]
	return otp_pos,otp_rate


def AMFC_msg_rot(inp_msg_rot):
	otp_pos = [inp_msg_rot.roll,inp_msg_rot.pitch,inp_msg_rot,yaw]
	otp_rate = [inp_msg_rot.roll_rate,inp_msg_rot.pitch_rate,inp_msg_rot.yaw_rate]
	return otp_pos,otp_rate


def AMFC_Des_trn():
	Des = [1,1,1] #x,y,z desired setpoints
	return Des


def AMFC_Des_rot(u_trn):
	Des = [0]*3
	Des_T = np.power( ( np.power(u_trn[3],2) + np.power(u_trn[4],2) + np.power(u_trn[5],2) ) , 0.5 )
	Des[0] = np.arcsin( ( (np.sin(Des[2])*u_trn[3]) - (np.cos(Des[2])*u_trn[4]) ) / Des_T )
	Des[1] = np.arctan2( ( (np.cos(Des[2])*u_trn[3]) + (np.sin(Des[2])*u_trn[4]) ) , u_trn[5] )
	return Des_T,Des



try:
	n = 6
	x_trn = [0]*n
	x_rot = [0]*n
	A_trn = [0]*n
	A_rot = [0]*n
	g_trn = [0]*n
	g_rot = [0]*n
	P_trn = [0]*n
	P_rot = [0]*n
	e_trn = [0]*n
	e_rot = [0]*n
	zeta_trn = [0]*n
	zeta_rot = [0]*n
	sigma_trn = [0]*n
	sigma_rot = [0]*n
	u_trn = [0]*n
	u_rot = [0]*n
	pos_trn = [0]*n
	pos_rot = [0]*n
	rate_trn = [0]*n
	rate_rot = [0]*n

	nd = 3
	Des_trn = [0]*nd
	Des_rot = [0]*nd
	Des_thrust = 0
	DifDes_trn = [0]*nd
	DifDes_rot = [0]*nd
	DifDes_Param1_trn = [0]*nd
	DifDes_Param1_rot = [0]*nd
	DifDes_Param2_trn = [0]*nd
	DifDes_Param2_rot = [0]*nd

	while(1):

		# Received messages from PX4
		PX4_msg_trn = ...
		PX4_msg_rot = ...

		# Translational AMFC Controller
		Des_trn = AMFC_Des_trn()
		DifDes_trn,DifDes_Param1_trn,DifDes_Param2_trn = AMFC_DifDes(Des_trn,DifDes_Param1_trn,DifDes_Param2_trn)
		pos_trn,rate_trn = AMFC_msg_trn(PX4_msg_trn)
		x_trn = AMFC_X(pos_trn,rate_trn)
		zeta_trn,sigma_trn = AMFC_Err(Des_trn,u_trn,x_trn,zeta_trn)
		u_trn = AMFC_main(x_trn,zeta_trn,sigma_trn,g_trn,A_trn,P_trn,DifDes_trn)
		g_trn = AMFC_Adpt_nlin(sigma_trn,P_trn,g_trn)
		A_trn = AMFC_Adpt_lin(sigma_trn,x_trn,P_trn,A_trn)
		P_trn = AMFC_P_upd(P_trn,A_trn)

		# Rotatioanl AMFC Controller
		Des_thrust,Des_rot = AMFC_Des_rot(u_trn)
		DifDes_rot,DifDes_Param1_rot,DifDes_Param2_rot = AMFC_DifDes(Des_rot,DifDes_Param1_rot,DifDes_Param2_rot)
		pos_rot,rate_rot = AMFC_msg_rot(PX4_msg_rot)
		x_rot = AMFC_X(pos_rot,rate_rot)
		zeta_rot,sigma_rot = AMFC_Err(Des_rot,u_rot,x_rot,zeta_rot)
		u_rot = AMFC_main(x_rot,zeta_rot,sigma_rot,g_rot,A_rot,P_rot,DifDes_rot)
		g_rot = AMFC_Adpt_nlin(sigma_rot,P_trn,g_rot)
		A_rot = AMFC_Adpt_lin(sigma_rot,x_rot,P_rot,A_rot)
		P_rot = AMFC_P_upd(P_rot,A_rot)

		# Commanded messages to the PX4
		Des_trq = [u_rot[3],u_rot[4],u_rot[5]]
		...
