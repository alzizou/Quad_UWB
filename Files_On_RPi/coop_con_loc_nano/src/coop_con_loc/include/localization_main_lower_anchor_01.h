#ifndef LOCALIZATION_MAIN_LOWER_ANCHOR_01_H
#define LOCALIZATION_MAIN_LOWER_ANCHOR_01_H
#endif // LOCALIZATION_MAIN_LOWER_ANCHOR_01_H

std::vector<int> data_DIST;
long double data_vx_NED_m = -100.0;
long double data_vy_NED_m;
long double data_vz_NED_m;

std_msgs::String publish_data_NED;
std_msgs::String publish_data_Pos_UWB;

const int Num_Anchors_lower_01 = 8;
long double Diff_Accept_XY = 2000.0;
long double Diff_Accept_Z = 2000.0;
long double PI = 3.14159265;
long double psi_coordinate_conversion = 35.0*PI/180.0; //angle between North and X axis of the UWB system

long double X[3][1] = {0.0,0.0,0.0};


