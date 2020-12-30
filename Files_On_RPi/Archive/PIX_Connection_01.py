from pymavlink import mavutil
import time

connection = mavutil.mavlink_connection("/dev/ttyACM0")
connection.wait_heartbeat()
print("Heartbeat:(%u,%u)" % (connection.target_system,connection.target_system))

try:
    while 1:
        msg0 = connection.recv_match(type='HIGHRES_IMU',blocking=True)
        connection.mav.vision_position_estimate_send(msg0.time_usec,50,20,30,0,0,0)
        #time.sleep(1)
        msg = connection.recv_match(type='LOCAL_POSITION_NED',blocking=True)
        if not msg:
            print("break!")
            break
        if msg.get_type() == "BAD_DATA":
            print("nothing to print!")
        else:
            print("%s" %msg)

except KeyboardInterrupt:
    print("Done!")

