#include "ros/ros.h"
#include "std_msgs/String.h"
#include <stdio.h>
#include <string>
#include <math.h>
#include <iostream>
#include <fstream>
#include "json.hpp"
#include "sliding_differentiator.h"
#include "velocitization_lower_anchor_01.h"
#include "absolute_velocity_main_lower_anchor_01.h"

// Anchors at HumanITAS office
long double vel_All_Anchors_lower_01_main[vel_Num_Anchors_lower_01][3] = {
    {-500.0,0.0,250.0},
    {4880.0,0.0,250.0},
    {0.0,5920.0,280.0},
    {5590.0,5790.0,400.0},
    {0.0,0.0,2290.0},
    {4880.0,0.0,2240.0},
    {0.0,5920.0,2390.0},
    {5260.0,5790.0,2290.0}
};

using json = nlohmann::json;

long double vel_abs_ali_lower_anchor_01(long double inp){
    long double out = inp;
    if (inp < 0.0){
	out = -1.0 * out;
    }
    return out;
}

void callbackDIST_lower_anchor_01(const std_msgs::String::ConstPtr& msg)
{
    auto jsonObject = json::parse(msg->data.c_str());
    vel_data_DIST = jsonObject["DIST"].get<std::vector<int>>();
}

void callbackUWBPos_lower_anchor_01(const std_msgs::String::ConstPtr& msg)
{
    auto jsonObject = json::parse(msg->data.c_str());
    data_x_UWB_mm = jsonObject["x_UWB_mm"].get<long double>();
    data_y_UWB_mm = jsonObject["y_UWB_mm"].get<long double>();
    data_z_UWB_mm = jsonObject["z_UWB_mm"].get<long double>();
}

int main(int argc, char **argv)
{
    std::cout.precision(17);
    long double Abs_Vel[3][1] = {0.0,0.0,0.0};
    long double Abs_Vel_new[3][1] = {0.0,0.0,0.0};
    long double Abs_Vel_m[3][1] = {0.0,0.0,0.0};
    long double Pos_UWB_X[3][1] = {0.0,0.0,0.0};

    long double DIST[vel_Num_Anchors_lower_01][1] = {0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0};
    long double Diff_DIST[vel_Num_Anchors_lower_01][1] = {0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0};
    long double Diff_variable1[vel_Num_Anchors_lower_01][1] = {0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0};
    long double Diff_variable2[vel_Num_Anchors_lower_01][1] = {0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0};
    long double delta_Euclidean[vel_Num_Anchors_lower_01][1] = {0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0};
    long double Diff_delta[vel_Num_Anchors_lower_01][1] = {0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0};
    long double Diff_delta_variable1[vel_Num_Anchors_lower_01][1] = {0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0};
    long double Diff_delta_variable2[vel_Num_Anchors_lower_01][1] = {0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0};

    ros::init(argc,argv,"absolute_velocity_main_lower_anchor_01");
    ros::NodeHandle n;
    ros::Rate loop_rate(30.0);
    ros::Subscriber sub_DIST = n.subscribe("ALL_DIST",1, callbackDIST_lower_anchor_01);
    ros::Subscriber sub_pos_UWB = n.subscribe("Pos_UWB_lower_01",1, callbackUWBPos_lower_anchor_01);
    ros::Publisher pub_vel_NED = n.advertise<std_msgs::String>("Vel_NED_lower_01",1);
    ros::Time time_stmp = ros::Time::now();
    std::ofstream Results_File_DIST_ABS_VEL_lower_anchor_01;
    Results_File_DIST_ABS_VEL_lower_anchor_01.precision(17);
    if (Results_File_DIST_ABS_VEL_lower_anchor_01.is_open()){
	Results_File_DIST_ABS_VEL_lower_anchor_01.close();
    };
    Results_File_DIST_ABS_VEL_lower_anchor_01.open("/root/logs/Results_File_DIST_ABS_VEL_lower_anchor_01.txt");
    std::ofstream Results_File_ABS_VEL_lower_anchor_01;
    Results_File_ABS_VEL_lower_anchor_01.precision(17);
    if (Results_File_ABS_VEL_lower_anchor_01.is_open()){
	Results_File_ABS_VEL_lower_anchor_01.close();
    };
    Results_File_ABS_VEL_lower_anchor_01.open("/root/logs/Results_File_ABS_VEL_lower_anchor_01.txt");
    std::ofstream Results_File_delta_lower_anchor_01;
    Results_File_delta_lower_anchor_01.precision(17);
    if (Results_File_delta_lower_anchor_01.is_open()){
	Results_File_delta_lower_anchor_01.close();
    };
    Results_File_delta_lower_anchor_01.open("/root/logs/Results_File_delta_lower_anchor_01.txt");
    std::ofstream Results_File_Freq_Vel_lower_anchor_01;
    Results_File_Freq_Vel_lower_anchor_01.precision(17);
    if (Results_File_Freq_Vel_lower_anchor_01.is_open()){
	Results_File_Freq_Vel_lower_anchor_01.close();
    };
    Results_File_Freq_Vel_lower_anchor_01.open("/root/logs/Results_File_Freq_Vel_lower_anchor_01.txt");

    while (ros::ok())
    {	
	//-----------------------------------------------------------------------------------------------
	//(START) subscribing to all collected distances
	if (vel_data_DIST.empty())
	{
	    for (int i=0;i<vel_Num_Anchors_lower_01;i++)
	    {
		DIST[i][0] = 0.0;
	    }
	}
	else
	{
	    for (int i=0;i<8;i++)
	    {
		DIST[i][0] = (long double)(vel_data_DIST[i]);
//		if (i==0)
//		{
//		    DIST[0][0] = (long double)(vel_data_DIST[i]);
//		}
//		if (i==3)
//		{
//		    DIST[1][0] = (long double)(vel_data_DIST[i]);
//		}
//		if (i==5)
//		{
//		    DIST[2][0] = (long double)(vel_data_DIST[i]);
//		}
//		if (i==6)
//		{
//		    DIST[3][0] = (long double)(vel_data_DIST[i]);
//		}
	    }
	}
	//(END) subscribing to all collected distances
	//-----------------------------------------------------------------------------------------------
	//(START) subscribing to estimated NED velocity
	if (data_x_UWB_mm == -10000.0)
	{
	    ROS_INFO("No UWB positions are received!");
	}else
	{
//	    ROS_INFO("UWB positions are received!");
	    Pos_UWB_X[0][0] = data_x_UWB_mm;
	    Pos_UWB_X[1][0] = data_y_UWB_mm;
	    Pos_UWB_X[2][0] = data_z_UWB_mm;
	}
	//(END) subscribing to estimated NED velocity
	//--------------------------------------------------------------------------------------------------------------------
	//(START) measuring the frequency of the localziation estimation process
	long double period = (ros::Time::now() - time_stmp).toSec();
	time_stmp = ros::Time::now();
	long double frequency = 1.0/period;
//	std::cout << "Cpp Velocitization Frequency (Hz):" << ' ' << frequency<< std::endl;
	Results_File_Freq_Vel_lower_anchor_01 << time_stmp << " " << frequency << "\n";
	Results_File_DIST_ABS_VEL_lower_anchor_01 << time_stmp << " " << DIST[0][0] << " " << DIST[1][0] << " " << DIST[2][0] << " " << DIST[3][0] << " " << DIST[4][0] << " " << DIST[5][0] << " " << DIST[6][0] << " " << DIST[7][0] << "\n";
	//(END) measuring the frequency of the localziation estimation process
	//-----------------------------------------------------------------------------------------------
	//(START) Computing the errors on Euclidean distances
	for (int i=0;i<vel_Num_Anchors_lower_01;i++){
	    delta_Euclidean[i][0] = ( pow((Pos_UWB_X[0][0] - vel_All_Anchors_lower_01_main[i][0]),2) + pow((Pos_UWB_X[1][0] - vel_All_Anchors_lower_01_main[i][1]),2) + pow((Pos_UWB_X[2][0] - vel_All_Anchors_lower_01_main[i][2]),2) ) - (pow(DIST[i][0],2));
	};
	Results_File_delta_lower_anchor_01 << " " << delta_Euclidean[0][0] << " " << delta_Euclidean[1][0] << " " << delta_Euclidean[2][0] << " " << delta_Euclidean[3][0] << " " << delta_Euclidean[4][0] << " " << delta_Euclidean[5][0] << " " << delta_Euclidean[6][0] << " " << delta_Euclidean[7][0] << "\n";
	//(END) Computing the errors on Euclidean distances
	//-----------------------------------------------------------------------------------------------
	//(START) computing the time-derivation of the measured distances
	for (int i=0;i<vel_Num_Anchors_lower_01;i++){
	    if (DIST[i][0]>0){		
		slid_diff(*DIST,*Diff_variable1,*Diff_variable2,period,*Diff_DIST,*Diff_variable1,*Diff_variable2,i);
		slid_diff(*delta_Euclidean,*Diff_delta_variable1,*Diff_delta_variable2,period,*Diff_delta,*Diff_delta_variable1,*Diff_delta_variable2,i);
	    }
	}
	//(END) computing the time-derivation of the measured distances
	//---------------------------------------------------------------------------------------------------------------------
	//(START) doing absolute velocity estimation
	Abs_Vel_new[0][0] = 0.0;
	Abs_Vel_new[1][0] = 0.0;
	Abs_Vel_new[2][0] = 0.0;
	velocitization(*Diff_DIST,*DIST,*Diff_delta,*Pos_UWB_X,*Abs_Vel_new);
	if ((Abs_Vel[0][0]==0.0) && (Abs_Vel[1][0]==0.0) && (Abs_Vel[2][0]==0.0)){
	    Abs_Vel[0][0] = Abs_Vel_new[0][0];
	    Abs_Vel[1][0] = Abs_Vel_new[1][0];
	    Abs_Vel[2][0] = Abs_Vel_new[2][0];
	};
	long double vel_C_val_x = vel_abs_ali_lower_anchor_01(Abs_Vel[0][0]-Abs_Vel_new[0][0]);
	long double vel_C_val_y = vel_abs_ali_lower_anchor_01(Abs_Vel[1][0]-Abs_Vel_new[1][0]);
	long double vel_C_val_z = vel_abs_ali_lower_anchor_01(Abs_Vel[2][0]-Abs_Vel_new[2][0]);
	if ((vel_C_val_x<vel_Diff_Accept_XY) && (vel_C_val_y<vel_Diff_Accept_XY) && (vel_C_val_z<vel_Diff_Accept_Z)){
	    Abs_Vel[0][0] = Abs_Vel_new[0][0];
	    Abs_Vel[1][0] = Abs_Vel_new[1][0];
	    Abs_Vel[2][0] = Abs_Vel_new[2][0];
	};
	Abs_Vel_m[0][0] = 0.001*Abs_Vel[0][0];
	Abs_Vel_m[1][0] = 0.001*Abs_Vel[1][0];
	Abs_Vel_m[2][0] = 0.001*Abs_Vel[2][0];
	Results_File_ABS_VEL_lower_anchor_01 << time_stmp << " " << Abs_Vel_m[0][0] << " " << Abs_Vel_m[1][0] << " " << Abs_Vel_m[2][0] << "\n";
	//(END) doing absolute velocity estimation
	//--------------------------------------------------------------------------------------------------------------------
	//(START) converting the estimated UWB velocity to the local NED frame
	long double vx_NED_m = (Abs_Vel_m[0][0]*cos(vel_psi_coordinate_conversion)) + (Abs_Vel_m[1][0]*sin(vel_psi_coordinate_conversion));
	long double vy_NED_m = (Abs_Vel_m[0][0]*sin(vel_psi_coordinate_conversion)) - (Abs_Vel_m[1][0]*cos(vel_psi_coordinate_conversion));
	long double vz_NED_m = -Abs_Vel_m[2][0];
	//(END) converting the estimated UWB velocity to the local NED frame
	//--------------------------------------------------------------------------------------------------------------------
	//(START) publishing estimated absolute velocity in local NED frame
	json data_Vel_NED;
	data_Vel_NED["vx_NED_m"] = vx_NED_m;
	data_Vel_NED["vy_NED_m"] = vy_NED_m;
	data_Vel_NED["vz_NED_m"] = vz_NED_m;
	publish_data_Vel_NED.data = data_Vel_NED.dump();
	pub_vel_NED.publish(publish_data_Vel_NED);
	//(END) publishing estimated absolute velocity in local NED frame
	//---------------------------------------------------------------------------------------------------------------------
	ros::spinOnce();
	loop_rate.sleep();
    };
    Results_File_DIST_ABS_VEL_lower_anchor_01.close();
    Results_File_ABS_VEL_lower_anchor_01.close();
    Results_File_delta_lower_anchor_01.close();
    Results_File_Freq_Vel_lower_anchor_01.close();
    return 0;
}



