#include "std_msgs/String.h"
#include <stdio.h>
#include <string>
//#include "ekf_dist.h"

//-------------------------------------------------------------
long double A_ekf[3][3] = {
    {0.0,1.0,0.0},
    {0.0,0.0,1.0},
    {0.0,0.0,0.0}
};
long double A_ekf_trn[3][3] = {
    {0.0,0.0,0.0},
    {1.0,0.0,0.0},
    {0.0,1.0,0.0}
};
long double B_ekf[3][1] = {0.0,0.0,1.0};
long double C_ekf[3][1] = {1.0,0.0,0.0};
//------------------------------------------------------------
long double eta = 0.5;
long double q = 1.0;
long double r = 0.1;
long double Q[3][3] = {
    {q,0.0,0.0},
    {0.0,q,0.0},
    {0.0,0.0,q}
};
long double R = r;
long double R_inv = 1.0/R;
//------------------------------------------------------------
long double P_dot_1[3][3] = {
    {0.0,0.0,0.0},
    {0.0,0.0,0.0},
    {0.0,0.0,0.0}
};
long double P_dot_2[3][3] = {
    {0.0,0.0,0.0},
    {0.0,0.0,0.0},
    {0.0,0.0,0.0}
};
long double P_dot_3[3][3] = {
    {0.0,0.0,0.0},
    {0.0,0.0,0.0},
    {0.0,0.0,0.0}
};
long double P_dot_4[3][1] = {0.0,0.0,0.0};
long double P_dot_5[1][3] = {0.0,0.0,0.0};
long double P_dot_6[3][3] = {
    {0.0,0.0,0.0},
    {0.0,0.0,0.0},
    {0.0,0.0,0.0}
};
long double P_dot_7[3][3] = {
    {0.0,0.0,0.0},
    {0.0,0.0,0.0},
    {0.0,0.0,0.0}
};
long double P_dot_8[3][3] = {
    {0.0,0.0,0.0},
    {0.0,0.0,0.0},
    {0.0,0.0,0.0}
};
long double P_dot_9[3][3] = {
    {0.0,0.0,0.0},
    {0.0,0.0,0.0},
    {0.0,0.0,0.0}
};
long double P_ekf_dot[3][3] = {
    {0.0,0.0,0.0},
    {0.0,0.0,0.0},
    {0.0,0.0,0.0}
};
long double P_add[3][3] = {
    {0.0,0.0,0.0},
    {0.0,0.0,0.0},
    {0.0,0.0,0.0}
};
long double P_ekf[3][3] = {
    {0.0,0.0,0.0},
    {0.0,0.0,0.0},
    {0.0,0.0,0.0}
};
//----------------------------------------------------------
long double x_hat_dot_1[3][1] = {0.0,0.0,0.0};
long double x_hat_dot_2[1][1] = {0.0};
long double x_hat_dot_3[1][1] = {0.0};
long double x_hat_dot_4[3][1] = {0.0,0.0,0.0};
long double x_hat_dot_5[3][1] = {0.0,0.0,0.0};
long double x_hat_dot_6[3][1] = {0.0,0.0,0.0};
long double x_hat_dot[3][1] = {0.0,0.0,0.0};
long double x_hat_add[3][1] = {0.0,0.0,0.0};
long double x_hat[3][1] = {0.0,0.0,0.0};
//----------------------------------------------------------

void mat_dot(long double *inp1,long double *inp2,long double *out,int n_inp,int m_inp,int p_inp){
    for (int i=0;i<n_inp;i++){
	for (int j=0;j<p_inp;j++){
	    out[i*p_inp + j] = 0;
	    for (int k=0;k<m_inp;k++){
		out[i*p_inp + j] = out[i*p_inp + j] + (inp1[i*m_inp + k] * inp2[k*p_inp + j]);
	    };
	};
    };
}

void mat_scl(long double *inp, long double scl, long double *out, int n_inp, int m_inp){
    for (int i=0;i<n_inp;i++){
	for (int j=0;j<m_inp;j++){
	    out[i*m_inp + j] = inp[i*m_inp + j] * scl;
	};
    };
}

void mat_add(long double *inp1, long double *inp2, long double *out, int n_inp, int m_inp){
    for (int i=0;i<n_inp;i++){
	for (int j=0;j<m_inp;j++){
	    out[i*m_inp + j] = inp1[i*m_inp + j] + inp2[i*m_inp + j];
	};
    };
}

void mat_trn(long double *inp, long double *out, int n_inp, int m_inp){
    for (int i=0;i<n_inp;i++){
	for (int j=0;j<m_inp;j++){
	    out[i*m_inp + j] = inp[j*n_inp + i];
	};
    };
}

void mat_cns(long double *inp, long double *out, int n_inp, int m_inp){
    for (int i=0;i<n_inp;i++){
	for (int j=0;j<m_inp;j++){
	    out[i*m_inp + j] = inp[i*m_inp + j];
	};
    };
}

void ekf_dist(long double dist_inp,long double *x_hat_inp,long double *P_inp,long double dt_inp, long double *x_hat_new, long double *P_new){
    long double u = 0.0;
    long double y = dist_inp;

    mat_cns(x_hat_inp,*x_hat,3,1);
    mat_cns(P_inp,*P_ekf,3,3);
    long double dt = 0.1; //0.1*dt_inp
    //------------------------------------------------------------
    mat_dot(*A_ekf,*P_ekf,*P_dot_1,3,3,3);
    mat_dot(*P_ekf,*A_ekf_trn,*P_dot_2,3,3,3);
    mat_dot(*Q,*Q,*P_dot_3,3,3,3);
    mat_dot(*P_ekf,*C_ekf,*P_dot_4,3,3,1);
    mat_dot(*C_ekf,*P_ekf,*P_dot_5,1,3,3);
    mat_dot(*P_dot_4,*P_dot_5,*P_dot_6,3,1,3);
    mat_scl(*P_dot_6,-R_inv,*P_dot_7,3,3);
    mat_add(*P_dot_1,*P_dot_2,*P_dot_8,3,3);
    mat_add(*P_dot_3,*P_dot_7,*P_dot_9,3,3);
    mat_add(*P_dot_8,*P_dot_9,*P_ekf_dot,3,3);
    mat_scl(*P_ekf_dot,dt,*P_add,3,3);
    mat_add(*P_ekf,*P_add,P_new,3,3);
    //------------------------------------------------------------
    mat_dot(*A_ekf,*x_hat,*x_hat_dot_1,3,3,1);
    mat_dot(*C_ekf,*x_hat,*x_hat_dot_2,1,3,1);
    x_hat_dot_3[0][0] = y - x_hat_dot_2[0][0];
    mat_scl(*C_ekf,x_hat_dot_3[0][0],*x_hat_dot_4,3,1);
    mat_dot(*P_ekf,*x_hat_dot_4,*x_hat_dot_5,3,3,1);
    mat_scl(*x_hat_dot_5,(eta*R_inv),*x_hat_dot_6,3,1);
    mat_add(*x_hat_dot_1,*x_hat_dot_6,*x_hat_dot,3,1);
    mat_scl(*x_hat_dot,dt,*x_hat_add,3,1);
    mat_add(*x_hat,*x_hat_add,x_hat_new,3,1);
    //-------------------------------------------------------------
}
