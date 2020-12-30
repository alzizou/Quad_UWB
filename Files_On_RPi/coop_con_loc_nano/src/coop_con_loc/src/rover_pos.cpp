#include "ros/ros.h"
#include "std_msgs/String.h"
#include <stdio.h>
#include <string>
#include <math.h>
#include <iostream>
#include <fstream>
#include "json.hpp"
#include "rover_pos.h"

float z_rover = 200.0; //mm
float dist1 = 0.0;
float dist2 = 0.0;
float x_anch1 = 0.0;
float y_anch1 = 0.0;
float z_anch1 = 2290.0;
float x_anch2 = 4880.0;
float y_anch2 = 0.0;
float z_anch2 = 2240.0;
int num_anch1 = 4;
int num_anch2 = 5;

using json = nlohmann::json;

void callbackDIST(const std_msgs::String::ConstPtr& msg)
{
    auto jsonObject = json::parse(msg->data.c_str());
    data_DIST = jsonObject["DIST"].get<std::vector<int>>();
}

int main(int argc, char **argv){

    ros::init(argc,argv,"rover_pos");
    ros::NodeHandle n;
    ros::Rate loop_rate(30.0);
    ros::Subscriber sub_DIST = n.subscribe("ALL_DIST",1, callbackDIST);
    ros::Publisher pub_Rov_Pos = n.advertise<std_msgs::String>("Rov_Pos_mm",1);
    ros::Time time_stmp = ros::Time::now();
    std::ofstream Results_File_Rov_Pos;
    Results_File_Rov_Pos.precision(17);
    if (Results_File_Rov_Pos.is_open()){
	Results_File_Rov_Pos.close();
    };
    Results_File_Rov_Pos.open("/root/logs/Results_File_Rov_Pos.txt");

    while (ros::ok()){

	//-----------------------------------------------------------------------------------------------
	//(START) subscribing to all collected distances
	if (data_DIST.empty())
	{
	    dist1 = 0.0;
	    dist2 = 0.0;
	}
	else
	{
	    dist1 = (long double)(data_DIST[num_anch1]);
	    dist2 = (long double)(data_DIST[num_anch2]);
	}
	//(END) subscribing to all collected distances
	//--------------------------------------------------------------------------------------------------
	// main computations
	float r1 = (dist1*dist1) - (z_rover - z_anch1)*(z_rover - z_anch1);
	float r2 = (dist2*dist2) - (z_rover - z_anch2)*(z_rover - z_anch2);
	float b0 = r1 - r2;
	float c0 = (x_anch1*x_anch1) - (x_anch2*x_anch2) + (y_anch1*y_anch1) - (y_anch1*y_anch1);
	float d0 = (b0 - c0) / (2.0*(x_anch2 - x_anch1));
	float k0 = (-2.0*(y_anch2 - y_anch1)) / (x_anch2 - x_anch1);
	float l0 = d0 - x_anch1;
	float s0 = -1.0 * (r1 - (l0*l0) - (y_anch1*y_anch1));
	float m0 = 1.0 + (k0*k0);
	float n0 = (2.0*l0*k0) - (2.0*y_anch1);
	float y0_1 = (1.0/(2.0*m0)) * (-n0 + pow(((n0*n0) - (4.0*m0*s0)),0.5));
	float y0_2 = (1.0/(2.0*m0)) * (-n0 - pow(((n0*n0) - (4.0*m0*s0)),0.5));
	float y0_sol = y0_1;
	if (y0_sol < y_anch2){
	    y0_sol = y0_2;
	}
	float x0_sol = d0 + (k0*y0_sol);
	// main computations
	//--------------------------------------------------------------------------------------------------
	//(START) publishing estimated local position and velocity in local NED frame
	Results_File_Rov_Pos << time_stmp << " " << x0_sol << " " << y0_sol << "\n";
	std::cout << "Rover_Pos_data" << " " << time_stmp << " " << x0_sol << " " << y0_sol << std::endl;
	json data_Rov_Pos;
	data_Rov_Pos["x_mm"] = x0_sol;
	data_Rov_Pos["y_mm"] = y0_sol;
	publish_data_Rov_Pos.data = data_Rov_Pos.dump();
	pub_Rov_Pos.publish(publish_data_Rov_Pos);
	//(END) publishing estimated local position and velocity in local NED frame
	//--------------------------------------------------------------------------------------------------------------------
	ros::spinOnce();
	loop_rate.sleep();
    }
    Results_File_Rov_Pos.close();
    return 0;

}
