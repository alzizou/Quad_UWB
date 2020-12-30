#!/bin/bash

sudo mkdir /root/logs
cd /root/coop_con_loc_RPi
source devel/setup.bash
roslaunch coop_con_loc $@

