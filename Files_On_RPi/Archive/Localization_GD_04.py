import serial
import time
import numpy as np
import math
from numpy.linalg import multi_dot
from numpy import linalg
from pymavlink import mavutil

serial_inst = serial.Serial("/dev/serial0")
serial_inst.baudrate = 115200

PX4_connection = mavutil.mavlink_connection("/dev/ttyACM0")
PX4_connection.wait_heartbeat()
print("PX4 Heartbeat(%u,%u)" % (PX4_connection.target_system, PX4_connection.target_system))


def distance_print():
    n = 0
    data0 = serial_inst.readline()
    for i in range(0, len(data0)):
        if data0[i] == 32:
            n = i - 1
            break

    data = 0
    for j in range(0, n):
        data = data + ((data0[j] - 48) * (10 ** (n - j)))

    data = data + (data0[n] - 48)
    print(data)

    return


def distance_return():
    n = 0
    data0 = serial_inst.readline()
    for i in range(0, len(data0)):
        if data0[i] == 32:
            n = i - 1
            break

    data = 0
    for j in range(0, n):
        data = data + ((data0[j] - 48) * (10 ** (n - j)))

    data = data + (data0[n] - 48)

    return (data)


def localization(dist01_inp, dist02_inp, dist03_inp, dist04_inp, dist05_inp, dist06_inp, dist07_inp, dist08_inp):
    Anchor01 = [0, 0, 711]  # A
    Anchor02 = [5360, 0, 737]  # B
    Anchor03 = [-305, 5868, 356]  # C
    Anchor04 = [5944, 5842, 350]  # D
    Anchor05 = [0, 0, 2300]  # E
    Anchor06 = [5360, 0, 2300]  # F
    Anchor07 = [-305, 5868, 2300]  # G
    Anchor08 = [5944, 5842, 2300]  # H

    X_out = [0, 0, 0]
    Dif_err = 0

    A = np.array([[-2 * Anchor01[0], -2 * Anchor01[1], -2 * Anchor01[2], 1],
                  [-2 * Anchor02[0], -2 * Anchor02[1], -2 * Anchor02[2], 1],
                  [-2 * Anchor03[0], -2 * Anchor03[1], -2 * Anchor03[2], 1],
                  [-2 * Anchor04[0], -2 * Anchor04[1], -2 * Anchor04[2], 1],
                  [-2 * Anchor05[0], -2 * Anchor05[1], -2 * Anchor05[2], 1],
                  [-2 * Anchor06[0], -2 * Anchor06[1], -2 * Anchor06[2], 1],
                  [-2 * Anchor07[0], -2 * Anchor07[1], -2 * Anchor07[2], 1],
                  [-2 * Anchor08[0], -2 * Anchor08[1], -2 * Anchor08[2], 1]])

    Y = [((dist01_inp ** 2) - (Anchor01[0] ** 2) - (Anchor01[1] ** 2) - (Anchor01[2] ** 2)),
         ((dist02_inp ** 2) - (Anchor02[0] ** 2) - (Anchor02[1] ** 2) - (Anchor02[2] ** 2)),
         ((dist03_inp ** 2) - (Anchor03[0] ** 2) - (Anchor03[1] ** 2) - (Anchor03[2] ** 2)),
         ((dist04_inp ** 2) - (Anchor04[0] ** 2) - (Anchor04[1] ** 2) - (Anchor04[2] ** 2)),
         ((dist05_inp ** 2) - (Anchor05[0] ** 2) - (Anchor05[1] ** 2) - (Anchor05[2] ** 2)),
         ((dist06_inp ** 2) - (Anchor06[0] ** 2) - (Anchor06[1] ** 2) - (Anchor06[2] ** 2)),
         ((dist07_inp ** 2) - (Anchor07[0] ** 2) - (Anchor07[1] ** 2) - (Anchor07[2] ** 2)),
         ((dist08_inp ** 2) - (Anchor08[0] ** 2) - (Anchor08[1] ** 2) - (Anchor08[2] ** 2))]

    Max_Dist = max(
        [dist01_inp, dist02_inp, dist03_inp, dist04_inp, dist05_inp, dist06_inp, dist07_inp, dist08_inp]) + 500
    Sum_Dist = (Max_Dist - dist01_inp) + (Max_Dist - dist02_inp) + (Max_Dist - dist03_inp) + (Max_Dist - dist04_inp) + \
               (Max_Dist - dist05_inp) + (Max_Dist - dist06_inp) + (Max_Dist - dist07_inp) + (Max_Dist - dist08_inp)
    w1 = (Max_Dist - dist01_inp) / Sum_Dist
    w2 = (Max_Dist - dist02_inp) / Sum_Dist
    w3 = (Max_Dist - dist03_inp) / Sum_Dist
    w4 = (Max_Dist - dist04_inp) / Sum_Dist
    w5 = (Max_Dist - dist05_inp) / Sum_Dist
    w6 = (Max_Dist - dist06_inp) / Sum_Dist
    w7 = (Max_Dist - dist07_inp) / Sum_Dist
    w8 = (Max_Dist - dist08_inp) / Sum_Dist
    W = np.diag([w1, w2, w3, w4, w5, w6, w7, w8])
    Thresh = 1e+2
    num = -1
    alpha = 1e-9 * np.diag([1, 1, 1, 1])
    Abs_Dif_err = 1e+6

    Num_It = 1000
    P = np.zeros([3, Num_It])
    err_Arr = [0] * Num_It

    while Abs_Dif_err > Thresh:
        num = num + 1
        dist01_hat = math.sqrt(
            (P[0][num] - Anchor01[0]) ** 2 + (P[1][num] - Anchor01[1]) ** 2 + (P[2][num] - Anchor01[2]) ** 2)
        dist02_hat = math.sqrt(
            (P[0][num] - Anchor02[0]) ** 2 + (P[1][num] - Anchor02[1]) ** 2 + (P[2][num] - Anchor02[2]) ** 2)
        dist03_hat = math.sqrt(
            (P[0][num] - Anchor03[0]) ** 2 + (P[1][num] - Anchor03[1]) ** 2 + (P[2][num] - Anchor03[2]) ** 2)
        dist04_hat = math.sqrt(
            (P[0][num] - Anchor04[0]) ** 2 + (P[1][num] - Anchor04[1]) ** 2 + (P[2][num] - Anchor04[2]) ** 2)
        dist05_hat = math.sqrt(
            (P[0][num] - Anchor05[0]) ** 2 + (P[1][num] - Anchor05[1]) ** 2 + (P[2][num] - Anchor05[2]) ** 2)
        dist06_hat = math.sqrt(
            (P[0][num] - Anchor06[0]) ** 2 + (P[1][num] - Anchor06[1]) ** 2 + (P[2][num] - Anchor06[2]) ** 2)
        dist07_hat = math.sqrt(
            (P[0][num] - Anchor07[0]) ** 2 + (P[1][num] - Anchor07[1]) ** 2 + (P[2][num] - Anchor07[2]) ** 2)
        dist08_hat = math.sqrt(
            (P[0][num] - Anchor08[0]) ** 2 + (P[1][num] - Anchor08[1]) ** 2 + (P[2][num] - Anchor08[2]) ** 2)

        Y_hat = [((dist01_hat ** 2) - (Anchor01[0] ** 2) - (Anchor01[1] ** 2) - (Anchor01[2] ** 2)),
                 ((dist02_hat ** 2) - (Anchor02[0] ** 2) - (Anchor02[1] ** 2) - (Anchor02[2] ** 2)),
                 ((dist03_hat ** 2) - (Anchor03[0] ** 2) - (Anchor03[1] ** 2) - (Anchor03[2] ** 2)),
                 ((dist04_hat ** 2) - (Anchor04[0] ** 2) - (Anchor04[1] ** 2) - (Anchor04[2] ** 2)),
                 ((dist05_hat ** 2) - (Anchor05[0] ** 2) - (Anchor05[1] ** 2) - (Anchor05[2] ** 2)),
                 ((dist06_hat ** 2) - (Anchor06[0] ** 2) - (Anchor06[1] ** 2) - (Anchor06[2] ** 2)),
                 ((dist07_hat ** 2) - (Anchor07[0] ** 2) - (Anchor07[1] ** 2) - (Anchor07[2] ** 2)),
                 ((dist08_hat ** 2) - (Anchor08[0] ** 2) - (Anchor08[1] ** 2) - (Anchor08[2] ** 2))]

        e = np.subtract(Y, Y_hat)
        P_dot = multi_dot([alpha, np.transpose(A), W, e])
        P[0][num + 1] = P[0][num] + P_dot[0]
        P[1][num + 1] = P[1][num] + P_dot[1]
        P[2][num + 1] = P[2][num] + P_dot[2]
        err = linalg.norm(e)
        err_Arr[num] = err

        if num > 1:
            Dif_err = err_Arr[num] - err_Arr[num - 1]
            Abs_Dif_err = abs(Dif_err)

        if num > 10:
            if Dif_err > 0:
                break

        if num > (Num_It - 50):
            break

    if P[2][num] < 0:
        alpha[2][2] = -1 * alpha[2][2]
        num = -1
        Abs_Dif_err = 1e+6
        Num_It = 1000
        P = np.zeros([3, Num_It])
        err_Arr = [0] * Num_It
        while Abs_Dif_err > Thresh:
            num = num + 1
            dist01_hat = math.sqrt(
                (P[0][num] - Anchor01[0]) ** 2 + (P[1][num] - Anchor01[1]) ** 2 + (P[2][num] - Anchor01[2]) ** 2)
            dist02_hat = math.sqrt(
                (P[0][num] - Anchor02[0]) ** 2 + (P[1][num] - Anchor02[1]) ** 2 + (P[2][num] - Anchor02[2]) ** 2)
            dist03_hat = math.sqrt(
                (P[0][num] - Anchor03[0]) ** 2 + (P[1][num] - Anchor03[1]) ** 2 + (P[2][num] - Anchor03[2]) ** 2)
            dist04_hat = math.sqrt(
                (P[0][num] - Anchor04[0]) ** 2 + (P[1][num] - Anchor04[1]) ** 2 + (P[2][num] - Anchor04[2]) ** 2)
            dist05_hat = math.sqrt(
                (P[0][num] - Anchor05[0]) ** 2 + (P[1][num] - Anchor05[1]) ** 2 + (P[2][num] - Anchor05[2]) ** 2)
            dist06_hat = math.sqrt(
                (P[0][num] - Anchor06[0]) ** 2 + (P[1][num] - Anchor06[1]) ** 2 + (P[2][num] - Anchor06[2]) ** 2)
            dist07_hat = math.sqrt(
                (P[0][num] - Anchor07[0]) ** 2 + (P[1][num] - Anchor07[1]) ** 2 + (P[2][num] - Anchor07[2]) ** 2)
            dist08_hat = math.sqrt(
                (P[0][num] - Anchor08[0]) ** 2 + (P[1][num] - Anchor08[1]) ** 2 + (P[2][num] - Anchor08[2]) ** 2)

            Y_hat = [((dist01_hat ** 2) - (Anchor01[0] ** 2) - (Anchor01[1] ** 2) - (Anchor01[2] ** 2)),
                     ((dist02_hat ** 2) - (Anchor02[0] ** 2) - (Anchor02[1] ** 2) - (Anchor02[2] ** 2)),
                     ((dist03_hat ** 2) - (Anchor03[0] ** 2) - (Anchor03[1] ** 2) - (Anchor03[2] ** 2)),
                     ((dist04_hat ** 2) - (Anchor04[0] ** 2) - (Anchor04[1] ** 2) - (Anchor04[2] ** 2)),
                     ((dist05_hat ** 2) - (Anchor05[0] ** 2) - (Anchor05[1] ** 2) - (Anchor05[2] ** 2)),
                     ((dist06_hat ** 2) - (Anchor06[0] ** 2) - (Anchor06[1] ** 2) - (Anchor06[2] ** 2)),
                     ((dist07_hat ** 2) - (Anchor07[0] ** 2) - (Anchor07[1] ** 2) - (Anchor07[2] ** 2)),
                     ((dist08_hat ** 2) - (Anchor08[0] ** 2) - (Anchor08[1] ** 2) - (Anchor08[2] ** 2))]

            e = np.subtract(Y, Y_hat)
            P_dot = multi_dot([alpha, np.transpose(A), W, e])
            P[0][num + 1] = P[0][num] + P_dot[0]
            P[1][num + 1] = P[1][num] + P_dot[1]
            P[2][num + 1] = P[2][num] + P_dot[2]
            err = linalg.norm(e)
            err_Arr[num] = err

            if num > 1:
                Dif_err = err_Arr[num] - err_Arr[num - 1]
                Abs_Dif_err = abs(Dif_err)

            if num > 10:
                if Dif_err > 0:
                    break

            if num > (Num_It - 50):
                break

    X_out[0] = P[0][num]
    X_out[1] = P[1][num]
    X_out[2] = P[2][num]

    return X_out


def MeasuredArray(dist_inp, distArray_inp, NUM_inp):
    for i in range(0, (NUM_inp - 2)):
        distArray_inp[i + 1] = distArray_inp[i]

    distArray_inp[0] = dist_inp
    return distArray_inp


def AverageFilter(distArray_inp, NUM_inp):
    SUM = 0
    for i in range(0, (NUM_inp - 1)):
        SUM = SUM + distArray_inp[i]

    AVG = SUM / NUM_inp
    return AVG


try:

    serial_inst.isOpen()
    c1 = 'A'
    c2 = 'B'
    c3 = 'C'
    c4 = 'D'
    c5 = 'E'
    c6 = 'F'
    c7 = 'G'
    c8 = 'H'

    print("Localization is started!")

    NUM_AVG = 10
    dist01_Array = [0] * NUM_AVG
    dist02_Array = [0] * NUM_AVG
    dist03_Array = [0] * NUM_AVG
    dist04_Array = [0] * NUM_AVG
    dist05_Array = [0] * NUM_AVG
    dist06_Array = [0] * NUM_AVG
    dist07_Array = [0] * NUM_AVG
    dist08_Array = [0] * NUM_AVG

    X = [0, 0, 0]
    X_m = [0, 0, 0]

    while 1:
        c11 = None
        c22 = None
        c33 = None
        c44 = None
        c55 = None
        c66 = None
        c77 = None
        c88 = None
        while c11 is None:
            serial_inst.write(c1.encode())
            time.sleep(0.001)
            c11 = serial_inst.readline()

        while c22 is None:
            serial_inst.write(c2.encode())
            time.sleep(0.001)
            c22 = serial_inst.readline()

        while c33 is None:
            serial_inst.write(c3.encode())
            time.sleep(0.001)
            c33 = serial_inst.readline()

        while c44 is None:
            serial_inst.write(c4.encode())
            time.sleep(0.001)
            c44 = serial_inst.readline()

        while c55 is None:
            serial_inst.write(c5.encode())
            time.sleep(0.001)
            c55 = serial_inst.readline()

        while c66 is None:
            serial_inst.write(c6.encode())
            time.sleep(0.001)
            c66 = serial_inst.readline()

        while c77 is None:
            serial_inst.write(c7.encode())
            time.sleep(0.001)
            c77 = serial_inst.readline()

        while c88 is None:
            serial_inst.write(c8.encode())
            time.sleep(0.001)
            c88 = serial_inst.readline()

        time.sleep(0.01)
        if (c11 is not None) & (c22 is not None):
            if (c33 is not None) & (c44 is not None):
                if (c55 is not None) & (c66 is not None):
                    if (c77 is not None) & (c88 is not None):
                        dist01 = distance_return()
                        time.sleep(0.001)
                        dist02 = distance_return()
                        time.sleep(0.001)
                        dist03 = distance_return()
                        time.sleep(0.001)
                        dist04 = distance_return()
                        time.sleep(0.001)
                        dist05 = distance_return()
                        time.sleep(0.001)
                        dist06 = distance_return()
                        time.sleep(0.001)
                        dist07 = distance_return()
                        time.sleep(0.001)
                        dist08 = distance_return()
                        time.sleep(0.001)
                        dist01_Array = MeasuredArray(dist01, dist01_Array, NUM_AVG)
                        dist02_Array = MeasuredArray(dist02, dist02_Array, NUM_AVG)
                        dist03_Array = MeasuredArray(dist03, dist03_Array, NUM_AVG)
                        dist04_Array = MeasuredArray(dist04, dist04_Array, NUM_AVG)
                        dist05_Array = MeasuredArray(dist05, dist05_Array, NUM_AVG)
                        dist06_Array = MeasuredArray(dist06, dist06_Array, NUM_AVG)
                        dist07_Array = MeasuredArray(dist07, dist07_Array, NUM_AVG)
                        dist08_Array = MeasuredArray(dist08, dist08_Array, NUM_AVG)
                        dist01_AVG = AverageFilter(dist01_Array, NUM_AVG)
                        dist02_AVG = AverageFilter(dist02_Array, NUM_AVG)
                        dist03_AVG = AverageFilter(dist03_Array, NUM_AVG)
                        dist04_AVG = AverageFilter(dist04_Array, NUM_AVG)
                        dist05_AVG = AverageFilter(dist05_Array, NUM_AVG)
                        dist06_AVG = AverageFilter(dist06_Array, NUM_AVG)
                        dist07_AVG = AverageFilter(dist07_Array, NUM_AVG)
                        dist08_AVG = AverageFilter(dist08_Array, NUM_AVG)
			X = localization(dist01_AVG, dist02_AVG, dist03_AVG, dist04_AVG, dist05_AVG, dist06_AVG,dist07_AVG, dist08_AVG)
except KeyboardInterrupt:
	print("done.")

			#X_m[1] = 0.001*X[1]
			#X_m[2] = 0.001*X[2]
			#print(X[0])
			#PX4_connection.mav.vision_position_estimate_send(0, X_m[0], X_m[1], X_m[2], 0, 0, 0)
			#time.sleep(0.001)
			#PX4_msg = PX4_connection.recv_match(type='LOCAL_POSITION_NED', blocking=True)
			#if not PX4_msg:
			#	print("PX4 message is not received.")
			#if PX4_msg.get_type() == "BAD_DATA":
			#	print("Nothing to print!")
			#else:
			#	print("%s" % PX4_msg)
