#include "ros/ros.h"
#include "std_msgs/String.h"
#include <stdio.h>
#include <string>
#include <math.h>
#include <iostream>
#include <fstream>
#include "json.hpp"
#include "ekf_dist.h"
#include "localization.h"
#include "localization_main.h"

using json = nlohmann::json;

long double abs_ali(long double inp){
    long double out = inp;
    if (inp < 0.0){
	out = -1.0 * out;
    }
    return out;
}

void callbackDIST(const std_msgs::String::ConstPtr& msg)
{
    auto jsonObject = json::parse(msg->data.c_str());
    data_DIST = jsonObject["DIST"].get<std::vector<int>>();
}

void callbackVel(const std_msgs::String::ConstPtr& msg)
{
    auto jsonObject = json::parse(msg->data.c_str());
    data_vx_NED_m = jsonObject["vx_NED_m"].get<long double>();
    data_vy_NED_m = jsonObject["vy_NED_m"].get<long double>();
    data_vz_NED_m = jsonObject["vz_NED_m"].get<long double>();
}

int main(int argc, char **argv)
{
    std::cout.precision(17);
    long double X[3][1] = {0.0,0.0,0.0};
    long double pos_z_Flt = 0.0;
    long double X_m[3][1] = {0.0,0.0,0.0};
    long double X_new[3][1] = {0.0,0.0,0.0};
    long double x_hat_KF_z[3][1] = {0.0,0.0,0.0};
    long double P_KF_z[3][3] = {
        {1.0,0.0,0.0},
        {0.0,1.0,0.0},
        {0.0,0.0,1.0}
    };
    long double vx_NED_m = 0.0;
    long double vy_NED_m = 0.0;
    long double vz_NED_m = 0.0;
    ros::init(argc,argv,"localization_main");
    ros::NodeHandle n;
    ros::Rate loop_rate(120.0);
    ros::Subscriber sub_DIST = n.subscribe("ALL_DIST",1, callbackDIST);
    ros::Subscriber sub_Vel = n.subscribe("Vel_NED",1, callbackVel);
    ros::Publisher pub_Pos_UWB = n.advertise<std_msgs::String>("Pos_UWB",1);
    ros::Publisher pub_NED = n.advertise<std_msgs::String>("NED_POS_VEL",1);
    ros::Time time_stmp = ros::Time::now();
    std::ofstream Results_File;
    Results_File.precision(17);
    if (Results_File.is_open()){
	Results_File.close();
    };
    Results_File.open("/root/logs/Results_File.txt");
    std::ofstream Results_File_NED_LOC;
    Results_File_NED_LOC.precision(17);
    if (Results_File_NED_LOC.is_open()){
	Results_File_NED_LOC.close();
    };
    Results_File_NED_LOC.open("/root/logs/Results_File_NED_LOC.txt");
    std::ofstream Results_File_Freq_Pos;
    Results_File_Freq_Pos.precision(17);
    if (Results_File_Freq_Pos.is_open()){
	Results_File_Freq_Pos.close();
    };
    Results_File_Freq_Pos.open("/root/logs/Results_File_Freq_Pos.txt");

    while (ros::ok())
    {
	long double DIST[Num_Anchors][1];
	//-----------------------------------------------------------------------------------------------
	//(START) subscribing to all collected distances	
	if (data_DIST.empty())
	{
	    for (int i=0;i<Num_Anchors;i++)
	    {
		DIST[i][0] = 0.0;
	    }
	}
	else
	{
	    for (int i=0;i<Num_Anchors;i++)
	    {
		DIST[i][0] = (long double)(data_DIST[i]);
	    }
	}	
	//(END) subscribing to all collected distances
	//-----------------------------------------------------------------------------------------------
	//(START) measuring the frequency of the localziation estimation process
	long double period = (ros::Time::now() - time_stmp).toSec();
	time_stmp = ros::Time::now();
	long double frequency = 1.0/period;
//	std::cout << "Cpp Localization Frequency (Hz):" << ' ' << frequency<< std::endl;
	Results_File_Freq_Pos << time_stmp << " " << frequency << "\n";
	//(END) measuring the frequency of the localziation estimation process
	//-----------------------------------------------------------------------------------------------
	//(START) doing localization
	X_new[0][0] = 0.0;
	X_new[1][0] = 0.0;
	X_new[2][0] = 0.0;
	localization(*DIST,*X_new);
	if ((X[0][0]==0.0) && (X[1][0]==0.0) && (X[2][0]==0.0)){
	    X[0][0] = X_new[0][0];
	    X[1][0] = X_new[1][0];
	    X[2][0] = X_new[2][0];
	};
	long double C_val_x = abs_ali(X[0][0]-X_new[0][0]);
	long double C_val_y = abs_ali(X[1][0]-X_new[1][0]);
	long double C_val_z = abs_ali(X[2][0]-X_new[2][0]);
	if ((C_val_x<Diff_Accept_XY) && (C_val_y<Diff_Accept_XY) && (C_val_z<Diff_Accept_Z)){
	    X[0][0] = X_new[0][0];
	    X[1][0] = X_new[1][0];
	    if (X_new[2][0]>0.0){
		X[2][0] = X_new[2][0];
	    }
	};
	//(END) doing localization
	//---------------------------------------------------------------------------------------------------------------------
	//(START) Kalman filter on z-axis estimation
	ekf_dist(X[2][0],*x_hat_KF_z,*P_KF_z,period,*x_hat_KF_z,*P_KF_z);
	pos_z_Flt = x_hat_KF_z[0][0];
	//(END) Kalman filter on z-axis estimation
	//--------------------------------------------------------------------------------------------------------------------
	//(START) logging localization data
	Results_File << time_stmp << " " << X[0][0] << " " << X[1][0] << " " << pos_z_Flt << "\n";
	X_m[0][0] = 0.001*X[0][0];
	X_m[1][0] = 0.001*X[1][0];
	X_m[2][0] = 0.001*pos_z_Flt; //X[2][0];
	//(END) logging localization data
	//--------------------------------------------------------------------------------------------------------------------
	//(START) converting the estimated UWB position to the local NED frame
	long double x_m_NED = (X_m[0][0]*cos(psi_coordinate_conversion)) + (X_m[1][0]*sin(psi_coordinate_conversion));
	long double y_m_NED = (X_m[0][0]*sin(psi_coordinate_conversion)) - (X_m[1][0]*cos(psi_coordinate_conversion));
	long double z_m_NED = -X_m[2][0];
	//(END) converting the estimated UWB position to the local NED frame
	//--------------------------------------------------------------------------------------------------------------------
	//(START) subscribing to estimated NED velocity
	if (data_vx_NED_m == -100.0)
	{
//	    ROS_INFO("No NED velocities are received!");
	}else
	{
//	    ROS_INFO("NED velocities are received!");
//	    std::cout <<data_vx_NED_m<< std::endl;
	    vx_NED_m = data_vx_NED_m;
	    vy_NED_m = data_vy_NED_m;
	    vz_NED_m = data_vz_NED_m;
	}
	//(END) subscribing to estimated NED velocity
	//--------------------------------------------------------------------------------------------------------------------
	//(START) publishing estimated local position in UWB frame
	json data_pos_UWB;
	data_pos_UWB["x_UWB_mm"] = X[0][0];
	data_pos_UWB["y_UWB_mm"] = X[1][0];
	data_pos_UWB["z_UWB_mm"] = pos_z_Flt; //X[2][0];
	publish_data_Pos_UWB.data = data_pos_UWB.dump();
	pub_Pos_UWB.publish(publish_data_Pos_UWB);
	//(END) publishing estimated local position in UWB frame
	//--------------------------------------------------------------------------------------------------------------------
	//(START) publishing estimated local position and velocity in local NED frame
	Results_File_NED_LOC << time_stmp << " " << x_m_NED << " " << y_m_NED << " " << z_m_NED << " " << vx_NED_m << " " << vy_NED_m << " " << vz_NED_m << "\n";
	json data_NED;
	data_NED["px"] = x_m_NED;
	data_NED["py"] = y_m_NED;
	data_NED["pz"] = z_m_NED;
	data_NED["vx"] = vx_NED_m;
	data_NED["vy"] = vy_NED_m;
	data_NED["vz"] = vz_NED_m;
	publish_data_NED.data = data_NED.dump();
	pub_NED.publish(publish_data_NED);
	//(END) publishing estimated local position and velocity in local NED frame
	//--------------------------------------------------------------------------------------------------------------------
	ros::spinOnce();
	loop_rate.sleep();
    };
    Results_File.close();
    Results_File_NED_LOC.close();
    return 0;
}

