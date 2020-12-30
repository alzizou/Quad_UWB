#include "std_msgs/String.h"
#include <stdio.h>
#include <string>
#include <math.h>

long double vel_alpha[3][3] = {
    {1.0e-08,0.0,0.0},
    {0.0,1.0e-08,0.0},
    {0.0,0.0,1.0e-08}
};
const int vel_Num_Anchors = 8;

// Anchors at HumanITAS office
long double vel_All_Anchors[vel_Num_Anchors][3] = {
    {-500.0,0.0,250.0},
    {4880.0,0.0,250.0},
    {0.0,5920.0,280.0},
    {5590.0,5790.0,400.0},
    {0.0,0.0,2290.0},
    {4880.0,0.0,2240.0},
    {0.0,5920.0,2390.0},
    {5260.0,5790.0,2290.0}
};

//Anchors at AML-McGill
//long double vel_All_Anchors[vel_Num_Anchors][3] = {
//    {1050.0,1000.0,1000.0},
//    {-1300.0,3100.0,1000.0},
//    {-5700.0,-2850.0,1000.0},
//    {-5700.0,2800.0,1000.0},
//    {1050.0,1000.0,2500.0},
//    {-1300.0,3100.0,2500.0},
//    {-5700.0,-2850.0,2500.0},
//    {-5700.0,2800.0,2500.0}
//};

int vel_Num_Req_Ref = 1; //number of required reference anchors
long double vel_Thresh = 1.0e+0;
int vel_Num_It = 1000;
int vel_brk_itr_num = 10;

void vel_mat_dot1(long double *inp1,long double *inp2,long double *out,int n_inp,int m_inp,int p_inp){
    for (int i=0;i<n_inp;i++){
	for (int j=0;j<p_inp;j++){
	    out[i*p_inp + j] = 0;
	    for (int k=0;k<m_inp;k++){
		out[i*p_inp + j] = out[i*p_inp + j] + (inp1[i*m_inp + k] * inp2[k*p_inp + j]);
	    };
	};
    };
}

void vel_mat_scl1(long double *inp, long double scl, long double *out, int n_inp, int m_inp){
    for (int i=0;i<n_inp;i++){
	for (int j=0;j<m_inp;j++){
	    out[i*m_inp + j] = inp[i*m_inp + j] * scl;
	};
    };
}

void vel_mat_add1(long double *inp1, long double *inp2, long double *out, int n_inp, int m_inp){
    for (int i=0;i<n_inp;i++){
	for (int j=0;j<m_inp;j++){
	    out[i*m_inp + j] = inp1[i*m_inp + j] + inp2[i*m_inp + j];
	};
    };
}

void vel_mat_trn1(long double *inp, long double *out, int n_inp, int m_inp){
    for (int i=0;i<n_inp;i++){
	for (int j=0;j<m_inp;j++){
	    out[i*m_inp + j] = inp[j*n_inp + i];
	};
    };
}

void vel_mat_cns1(long double *inp, long double *out, int n_inp, int m_inp){
    for (int i=0;i<n_inp;i++){
	for (int j=0;j<m_inp;j++){
	    out[i*m_inp + j] = inp[i*m_inp + j];
	};
    };
}

long double vel_mat_nrm1(long double *inp, int n_inp){
    long double out = 0.0;
    for (int i=0;i<n_inp;i++){
	out = out + (inp[i]*inp[i]);
    };
    out = pow(out,0.5);
    return out;
}

void vel_mat_srt_ind1(long double *inp, int *out, int n_inp){
    long double *var = inp;
    for (int i=0;i<n_inp;i++){
	for (int j=i+1;j<n_inp;j++){
	    if (var[i]>var[j]){
		int a = out[i];
		out[i] = out[j];
		out[j] = a;
		long double b = var[i];
		var[i] = var[j];
		var[j] = b;
	    };
	};
    };
}

long double vel_abs_ali1(long double inp){
    long double out = inp;
    if (inp < 0.0){
	out = -1.0 * out;
    }
    return out;
}

void velocitization(long double *Diff_DIST_inp, long double *DIST_inp, long double *Diff_delta_inp, long double *Pos_UWB_inp, long double *vel_out){
    std::cout.precision(12);
    long double vel_All_Dist[vel_Num_Anchors][1];
    vel_mat_cns1(DIST_inp,*vel_All_Dist,vel_Num_Anchors,1);    

    int vel_num_init = 0;
    for (int i=0;i<vel_Num_Anchors;i++){
	if (vel_All_Dist[i][0]<1.0){
	    vel_num_init = vel_num_init + 1;
	};
    };
    const int vel_Avail_Num_Anchors = vel_Num_Anchors - vel_num_init;
    long double vel_Avail_All_Anchors[vel_Avail_Num_Anchors][3];
    long double vel_Avail_All_Dist[vel_Avail_Num_Anchors][1];
    long double vel_Avail_Diff_DIST[vel_Avail_Num_Anchors][1];
    long double vel_Avail_Diff_delta[vel_Avail_Num_Anchors][1];

    int vel_num1 = -1;
    for (int i=0;i<vel_Num_Anchors;i++){
	if (vel_All_Dist[i][0]>1.0){
	    vel_num1 = vel_num1 + 1;
	    vel_Avail_All_Dist[vel_num1][0] = vel_All_Dist[i][0];
	    vel_Avail_Diff_DIST[vel_num1][0] = Diff_DIST_inp[i];
	    vel_Avail_Diff_delta[vel_num1][0] = Diff_delta_inp[i];
	    vel_Avail_All_Anchors[vel_num1][0] = vel_All_Anchors[i][0];
	    vel_Avail_All_Anchors[vel_num1][1] = vel_All_Anchors[i][1];
	    vel_Avail_All_Anchors[vel_num1][2] = vel_All_Anchors[i][2];
	};
    };

    long double vel_Weights[vel_Avail_Num_Anchors][vel_Avail_Num_Anchors];
    long double vel_B[vel_Avail_Num_Anchors][1];
    long double vel_e[(vel_Avail_Num_Anchors)][1];
    long double vel_B_hat[vel_Avail_Num_Anchors][1];
    long double vel_B_hat_init[vel_Avail_Num_Anchors][1];
    long double V_dot_init1[3][vel_Avail_Num_Anchors];
    long double V_dot_init2[3][vel_Avail_Num_Anchors];

    for (int i=0;i<vel_Avail_Num_Anchors;i++){
	for (int j=0;j<3;j++){
	    V_dot_init1[j][i] = 0.0;
	    V_dot_init2[j][i] = 0.0;
	};
	for (int k=0;k<vel_Avail_Num_Anchors;k++){
	    vel_Weights[i][k] = 0.0;
	};
    };

    int vel_num_i = -1;
    long double vel_Max_Dist = 0.0;
    long double vel_A_cpp[8][3];
    long double vel_A_cpp_trn[3][8];
    long double vel_B_init1 = 0.0;
    long double vel_B_init2 = 0.0;
    for (int i=0;i<vel_Avail_Num_Anchors;i++){
	vel_num_i = vel_num_i + 1;
	vel_A_cpp[vel_num_i][0] = Pos_UWB_inp[0] - vel_Avail_All_Anchors[i][0];
	vel_A_cpp[vel_num_i][1] = Pos_UWB_inp[1] - vel_Avail_All_Anchors[i][1];
	vel_A_cpp[vel_num_i][2] = Pos_UWB_inp[2] - vel_Avail_All_Anchors[i][2];
	vel_A_cpp_trn[0][vel_num_i] = vel_A_cpp[vel_num_i][0];
	vel_A_cpp_trn[1][vel_num_i] = vel_A_cpp[vel_num_i][1];
	vel_A_cpp_trn[2][vel_num_i] = vel_A_cpp[vel_num_i][2];
	vel_B_init1 = vel_Avail_All_Dist[vel_num_i][0] * vel_Avail_Diff_DIST[vel_num_i][0];
	vel_B_init2 = 0.5 * vel_Avail_Diff_delta[vel_num_i][0];
	vel_B[vel_num_i][0] = vel_B_init1 + vel_B_init2;
	if (vel_Avail_All_Dist[i][0]>vel_Max_Dist){
	    vel_Max_Dist = vel_Avail_All_Dist[i][0];
	};	
    };
    vel_Max_Dist = vel_Max_Dist + 1000.0;
    int vel_num_j = -1;
    for (int i=0;i<vel_Avail_Num_Anchors;i++){
	vel_num_j = vel_num_j + 1;
	vel_Weights[vel_num_j][vel_num_j] = (vel_Max_Dist - vel_Avail_All_Dist[i][0])/vel_Max_Dist;
    };
    int vel_num = -1;
    long double V_dot[3][1] = {0.0,0.0,0.0};
    long double V[3][1] = {0.0,0.0,0.0};
    long double V_old[3][1] = {0.0,0.0,0.0};
    long double vel_err = 0.0;
    long double vel_err_Arr = 0.0;
    long double vel_err_Arr_old = 0.0;
    long double vel_Dif_err = 0.0;
    long double vel_Abs_Dif_err = 1.0e+6;
    while (vel_Abs_Dif_err>vel_Thresh){
	vel_num = vel_num+1;
	vel_mat_dot1(*vel_A_cpp,*V_old,*vel_B_hat_init,vel_Avail_Num_Anchors,3,1);
	vel_mat_scl1(*vel_B_hat_init,-1.0,*vel_B_hat,vel_Avail_Num_Anchors,1);
	vel_mat_add1(*vel_B,*vel_B_hat,*vel_e,vel_Avail_Num_Anchors,1);
	vel_mat_dot1(*vel_alpha,*vel_A_cpp_trn,*V_dot_init1,3,3,vel_Avail_Num_Anchors);
	vel_mat_dot1(*V_dot_init1,*vel_Weights,*V_dot_init2,3,vel_Avail_Num_Anchors,vel_Avail_Num_Anchors);
	vel_mat_dot1(*V_dot_init2,*vel_e,*V_dot,3,vel_Avail_Num_Anchors,1);
	V[0][0] = V_old[0][0] + V_dot[0][0];
	V[1][0] = V_old[1][0] + V_dot[1][0];
	V[2][0] = V_old[2][0] + V_dot[2][0];
	vel_err = vel_mat_nrm1(*vel_e,vel_Avail_Num_Anchors);
	vel_err_Arr = vel_err;
	if (vel_num>1){
	    vel_Dif_err = vel_err_Arr - vel_err_Arr_old;
	    vel_Abs_Dif_err = vel_abs_ali1(vel_Dif_err);
	};
	if (vel_num>vel_brk_itr_num){
	    if (vel_Dif_err>0.0){
		V[0][0] = V_old[0][0];
		V[1][0] = V_old[1][0];
		V[2][0] = V_old[2][0];
		break;
	    };
	    if (vel_num>(vel_Num_It-vel_brk_itr_num)){
		break;
	    };
	};
	V_old[0][0] = V[0][0];
	V_old[1][0] = V[1][0];
	V_old[2][0] = V[2][0];
	vel_err_Arr_old = vel_err_Arr;
    };
    vel_out[0] = V[0][0];
    vel_out[1] = V[1][0];
    vel_out[2] = V[2][0];
}
