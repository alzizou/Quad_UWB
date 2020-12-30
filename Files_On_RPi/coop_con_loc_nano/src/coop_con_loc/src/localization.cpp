#include "std_msgs/String.h"
#include <stdio.h>
#include <string>
#include <math.h>
//#include <localization.h>

long double alpha[3][3] = {
    {3.0e-09,0.0,0.0},
    {0.0,3.0e-09,0.0},
    {0.0,0.0,1.0e-09}
};
const int Num_Anchors = 8;

// Anchors at HumanITAS office
long double All_Anchors[Num_Anchors][3] = {
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
//long double All_Anchors[Num_Anchors][3] = {
//    {1050.0,1000.0,1000.0},
//    {-1300.0,3100.0,1000.0},
//    {-5700.0,-2850.0,1000.0},
//    {-5700.0,2800.0,1000.0},
//    {1050.0,1000.0,2500.0},
//    {-1300.0,3100.0,2500.0},
//    {-5700.0,-2850.0,2500.0},
//    {-5700.0,2800.0,2500.0}
//};

int Num_Req_Ref = 1; //number of required reference anchors
long double Thresh = 1.0e+0;
int Num_It = 1000;
int brk_itr_num = 10;

//const int Avail_Num_Anchors = 8;


void mat_dot1(long double *inp1,long double *inp2,long double *out,int n_inp,int m_inp,int p_inp){
    for (int i=0;i<n_inp;i++){
	for (int j=0;j<p_inp;j++){
	    out[i*p_inp + j] = 0;
	    for (int k=0;k<m_inp;k++){
		out[i*p_inp + j] = out[i*p_inp + j] + (inp1[i*m_inp + k] * inp2[k*p_inp + j]);
	    };
	};
    };
}

void mat_scl1(long double *inp, long double scl, long double *out, int n_inp, int m_inp){
    for (int i=0;i<n_inp;i++){
	for (int j=0;j<m_inp;j++){
	    out[i*m_inp + j] = inp[i*m_inp + j] * scl;
	};
    };
}

void mat_add1(long double *inp1, long double *inp2, long double *out, int n_inp, int m_inp){
    for (int i=0;i<n_inp;i++){
	for (int j=0;j<m_inp;j++){
	    out[i*m_inp + j] = inp1[i*m_inp + j] + inp2[i*m_inp + j];
	};
    };
}

void mat_trn1(long double *inp, long double *out, int n_inp, int m_inp){
    for (int i=0;i<n_inp;i++){
	for (int j=0;j<m_inp;j++){
	    out[i*m_inp + j] = inp[j*n_inp + i];
	};
    };
}

void mat_cns1(long double *inp, long double *out, int n_inp, int m_inp){
    for (int i=0;i<n_inp;i++){
	for (int j=0;j<m_inp;j++){
	    out[i*m_inp + j] = inp[i*m_inp + j];
	};
    };
}

long double mat_nrm1(long double *inp, int n_inp){
    long double out = 0.0;
    for (int i=0;i<n_inp;i++){	
	out = out + (inp[i]*inp[i]);	
    };
    out = pow(out,0.5);
    return out;
}

void mat_srt_ind1(long double *inp, int *out, int n_inp){
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

long double abs_ali1(long double inp){
    long double out = inp;
    if (inp < 0.0){
	out = -1.0 * out;
    }
    return out;
}

void localization(long double *DIST_inp, long double *X_out){
    std::cout.precision(17);
    long double All_Dist[Num_Anchors][1];
    mat_cns1(DIST_inp, *All_Dist,Num_Anchors,1);    
    int num = 0;
    for (int i=0;i<Num_Anchors;i++){
	if (All_Dist[i][0]<1.0){
	    num = num + 1;
	};
    };
    const int Avail_Num_Anchors = Num_Anchors - num;
    long double Avail_All_Anchors[Avail_Num_Anchors][3];
    long double Avail_All_Dist[Avail_Num_Anchors][1];
    long double Avail_All_Dist_Ind[Avail_Num_Anchors][1];

    int num1 = -1;
    for (int i=0;i<Num_Anchors;i++){
	if (All_Dist[i][0]>1.0){
	    num1 = num1 + 1;
	    Avail_All_Dist[num1][0] = All_Dist[i][0];
	    Avail_All_Dist_Ind[num1][0] = All_Dist[i][0];
	    Avail_All_Anchors[num1][0] = All_Anchors[i][0];
	    Avail_All_Anchors[num1][1] = All_Anchors[i][1];
	    Avail_All_Anchors[num1][2] = All_Anchors[i][2];	     
	};	 
    };

    int Range_Ref_Anchors[Avail_Num_Anchors-1];
    for (int i=0;i<Avail_Num_Anchors;i++){
	Range_Ref_Anchors[i] = i;
    };
    mat_srt_ind1(*Avail_All_Dist_Ind, Range_Ref_Anchors, (Avail_Num_Anchors-1));

    long double Weights[Avail_Num_Anchors-1][Avail_Num_Anchors-1];
    long double B[Avail_Num_Anchors-1][1];
    long double e[(Avail_Num_Anchors-1)][1];
    long double B_hat[Avail_Num_Anchors-1][1];
    long double B_hat_init[Avail_Num_Anchors-1][1];
    long double P_dot_init1[3][Avail_Num_Anchors-1];
    long double P_dot_init2[3][Avail_Num_Anchors-1];

    for (int i=0;i<Avail_Num_Anchors;i++){
	for (int j=0;j<3;j++){
	    P_dot_init1[j][i] = 0.0;
	    P_dot_init2[j][i] = 0.0;
	};
	for (int k=0;k<Avail_Num_Anchors;k++){
	    Weights[i][k] = 0.0;
	};
    };

    int Ref_Tot_Num = 0;
    long double All_Est_Pos[3][1] = {0.0,0.0,0.0};
    for (int Ref_Anchor_Num:Range_Ref_Anchors){
	int num_i = -1;
	long double Max_Dist = 0.0;
	long double A_cpp[7][3];
	long double A_cpp_trn[3][7];
	long double B_init1 = 0.0;
	long double B_init2 = 0.0;
	for (int i=0;i<Avail_Num_Anchors;i++){
	    if (i!=Ref_Anchor_Num){
		num_i = num_i + 1;		
		A_cpp[num_i][0] = 2.0*(Avail_All_Anchors[i][0]-Avail_All_Anchors[Ref_Anchor_Num][0]);
		A_cpp[num_i][1] = 2.0*(Avail_All_Anchors[i][1]-Avail_All_Anchors[Ref_Anchor_Num][1]);
		A_cpp[num_i][2] = 2.0*(Avail_All_Anchors[i][2]-Avail_All_Anchors[Ref_Anchor_Num][2]);
		A_cpp_trn[0][num_i] = A_cpp[num_i][0];
		A_cpp_trn[1][num_i] = A_cpp[num_i][1];
		A_cpp_trn[2][num_i] = A_cpp[num_i][2];
		B_init1 = (Avail_All_Dist[Ref_Anchor_Num][0]*Avail_All_Dist[Ref_Anchor_Num][0]) -
			(Avail_All_Anchors[Ref_Anchor_Num][0]*Avail_All_Anchors[Ref_Anchor_Num][0]) -
			(Avail_All_Anchors[Ref_Anchor_Num][1]*Avail_All_Anchors[Ref_Anchor_Num][1]) -
			(Avail_All_Anchors[Ref_Anchor_Num][2]*Avail_All_Anchors[Ref_Anchor_Num][2]);
		B_init2 = (Avail_All_Dist[i][0]*Avail_All_Dist[i][0]) -
		        (Avail_All_Anchors[i][0]*Avail_All_Anchors[i][0]) -
		        (Avail_All_Anchors[i][1]*Avail_All_Anchors[i][1]) -
		        (Avail_All_Anchors[i][2]*Avail_All_Anchors[i][2]);
		B[num_i][0] = B_init1 - B_init2;		
	    };
	    if (Avail_All_Dist[i][0]>Max_Dist){
		Max_Dist = Avail_All_Dist[i][0];
	    };
	};
	Max_Dist = Max_Dist + 1000.0;
	int num_j = -1;
	for (int i=0;i<Avail_Num_Anchors;i++){
	    if (i!=Ref_Anchor_Num){
		num_j = num_j + 1;
		Weights[num_j][num_j] = (Max_Dist - Avail_All_Dist[i][0])/Max_Dist;		
	    };
	};	
	int num = -1;
	long double P_dot[3][1] = {0.0,0.0,0.0};
	long double P[3][1] = {0.0,0.0,0.0};
	long double P_old[3][1] = {0.0,0.0,0.0};
	long double err = 0.0;
	long double err_Arr = 0.0;
	long double err_Arr_old = 0.0;
	long double Dif_err = 0.0;
	long double Abs_Dif_err = 1.0e+6;
	while (Abs_Dif_err>Thresh){
	    num = num+1;
	    mat_dot1(*A_cpp,*P_old,*B_hat_init,(Avail_Num_Anchors-1),3,1);
	    mat_scl1(*B_hat_init,-1.0,*B_hat,(Avail_Num_Anchors-1),1);
	    mat_add1(*B,*B_hat,*e,(Avail_Num_Anchors-1),1);
	    mat_dot1(*alpha,*A_cpp_trn,*P_dot_init1,3,3,(Avail_Num_Anchors-1));
	    mat_dot1(*P_dot_init1,*Weights,*P_dot_init2,3,(Avail_Num_Anchors-1),(Avail_Num_Anchors-1));
	    mat_dot1(*P_dot_init2,*e,*P_dot,3,(Avail_Num_Anchors-1),1);
	    P[0][0] = P_old[0][0] + P_dot[0][0];
	    P[1][0] = P_old[1][0] + P_dot[1][0];
	    P[2][0] = P_old[2][0] + P_dot[2][0];	    
	    err = mat_nrm1(*e, (Avail_Num_Anchors-1));
	    err_Arr = err;
	    if (num>1){
		Dif_err = err_Arr - err_Arr_old;
		Abs_Dif_err = abs_ali1(Dif_err);		
	    };	    	    
	    if (num>brk_itr_num){
		if (Dif_err>0.0){
		    P[0][0] = P_old[0][0];
		    P[1][0] = P_old[1][0];
		    P[2][0] = P_old[2][0];
		    break;
		};
		if (num>(Num_It-brk_itr_num)){
		    break;
		};
	    };
	    P_old[0][0] = P[0][0];
	    P_old[1][0] = P[1][0];
	    P_old[2][0] = P[2][0];
	    err_Arr_old = err_Arr;	    
	};
	All_Est_Pos[0][Ref_Tot_Num] = P[0][0];
	All_Est_Pos[1][Ref_Tot_Num] = P[1][0];
	All_Est_Pos[2][Ref_Tot_Num] = P[2][0];
	Ref_Tot_Num = Ref_Tot_Num + 1;
	if (Ref_Tot_Num == Num_Req_Ref)
	{
	    break;
	};
    };
    for (int i=0;i<Num_Req_Ref;i++){
	X_out[0] = X_out[0] + All_Est_Pos[0][i];
	X_out[1] = X_out[1] + All_Est_Pos[1][i];
	X_out[2] = X_out[2] + All_Est_Pos[2][i];
    };
    X_out[0] = X_out[0]/(long double)(Num_Req_Ref);
    X_out[1] = X_out[1]/(long double)(Num_Req_Ref);
    X_out[2] = X_out[2]/(long double)(Num_Req_Ref);
}

