from pymavlink import mavutil

connection = mavutil.mavlink_connection("/dev/ttyACM0")
connection.wait_heartbeat()
print("Heartbeat:(%u,%u)" % (connection.target_system,connection.target_system))

try:
    while 1:
        msg = connection.recv_match(type='HIGHRES_IMU',blocking=True)
        if not msg:
            print("break!")
            break
        if msg.get_type() == "BAD_DATA":
            print("nothing to print!")
        else:
            print("%s" %msg)
            print("x_acc:%s" %msg.xacc)
            print("y_acc:%s" %msg.yacc)
            print("z_acc:%s" %msg.zacc)

except KeyboardInterrupt:
    print("Done!")

