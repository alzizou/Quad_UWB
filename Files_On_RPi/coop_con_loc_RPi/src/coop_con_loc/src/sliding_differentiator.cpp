#include "std_msgs/String.h"
#include <stdio.h>
#include <string>
#include <math.h>

long double slid_abs_ali(long double inp){
    long double out = inp;
    if (inp < 0.0){
	out = -1.0 * out;
    }
    return out;
}

long double slid_abs_sign(long double inp){
    long double out = 0.0;
    if (inp < 0.0){
	out = -1.0;
    }
    if (inp > 0.0){
	out = +1.0;
    }
    return out;
}

void slid_diff(long double *measured_inp,long double *variable1_inp, long double *variable2_inp, long double dt_inp, long double *Out_Diff, long double *Out_var1, long double *Out_var2, int num_inp){
    long double k1 = 10.0;
    long double k2 = 1.0;
    long double diff = variable1_inp[num_inp] - measured_inp[num_inp];
    long double abs_diff = slid_abs_ali(diff);
    long double sign_diff = slid_abs_sign(diff);
    long double out_diff = ( -k1 * pow(abs_diff,0.5) * sign_diff ) + variable2_inp[num_inp];

    long double D_variable1 = out_diff;
    long double D_variable2 = -k2 * sign_diff;
    long double var1 = variable1_inp[num_inp] + (D_variable1 * dt_inp);
    long double var2 = variable2_inp[num_inp] + (D_variable2 * dt_inp);

    Out_Diff[num_inp] = out_diff;
    Out_var1[num_inp] = var1;
    Out_var2[num_inp] = var2;
}
