#!/usr/bin/env python3

import numpy as np

def AMFC(xd_inp,x_inp,err_int_inp,A_hat_inp,g_hat_inp,P_inp,y_dif_inp,int_Delta_inp,Q_inp,Gamma1_inp,Gamma2_inp,rho1_inp,rho2_inp,dt_inp):

	R = 1.0
	B = 1.0

	err = xd_inp - x_inp
	err_int = err_int_inp + (err*dt_inp)

	sigma = err + err_int_inp
	u = B * (y_dif_inp - A_hat_inp*x_inp - g_hat_inp - err_int_inp + (1.0 + (2.0*(1.0/P_inp)*Q_inp) + A_hat_inp)*sigma) - (0.25*R*B*P_inp*sigma)
	g_hat_dot = -(Gamma1_inp * P_inp * sigma) - (rho1_inp * Gamma1_inp * g_hat_inp)
	A_hat_dot = -(Gamma2_inp * P_inp * sigma * (x_inp - sigma)) - (rho2_inp * Gamma2_inp * A_hat_inp)

	Delta = A_hat_inp*A_hat_inp + 2.0*Q_inp
	P0 = + (A_hat_inp - np.sqrt(Delta))
	W0 = 1.0/(1.0 - P0)
	int_Delta = int_Delta_inp + (np.sqrt(Delta)*dt_inp)
	W = +(1.0/(2.0*np.sqrt(Delta))) + (W0 - (1.0/(2.0*np.sqrt(Delta))))*(np.exp(-2.0*int_Delta))
	P_dot = P0 + (1.0/W)

	g_hat = g_hat_inp + (g_hat_dot*dt_inp)
	A_hat = A_hat_inp + (A_hat_dot*dt_inp)
	P = P_inp + (P_dot*dt_inp)

	return err, err_int, P, g_hat, A_hat, int_Delta, u


