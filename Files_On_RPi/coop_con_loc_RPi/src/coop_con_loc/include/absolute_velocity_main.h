#ifndef ABSOLUTE_VELOCITY_MAIN_H
#define ABSOLUTE_VELOCITY_MAIN_H

#endif // ABSOLUTE_VELOCITY_MAIN_H

std::vector<int> vel_data_DIST;
long double data_x_UWB_mm = -10000.0;
long double data_y_UWB_mm;
long double data_z_UWB_mm;

std_msgs::String publish_data_Vel_NED;

const int vel_Num_Anchors = 8;
long double vel_Diff_Accept_XY = 2000.0;
long double vel_Diff_Accept_Z = 2000.0;
long double PI = 3.14159265;
long double vel_psi_coordinate_conversion = 35.0*PI/180.0; //angle between North and X axis of the UWB system

long double V[3][1] = {0.0,0.0,0.0};


