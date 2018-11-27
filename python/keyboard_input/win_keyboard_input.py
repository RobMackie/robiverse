#!/usr/bin/env python3

import msvcrt
import os
import sys
import time
import socket

HOST = '192.168.4.1'  # The server's hostname or IP address
PORT = 15000        # The port used by the server


with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s_robot:
    s_robot.connect((HOST, PORT))
    s_robot.sendall(b'H')

    stop = 1;
    while (stop):
        byteIn = msvcrt.getch()
        if (byteIn == b'q'):
            stop = 0;
        text = str(byteIn, "UTF-8")
        print(text, end="")
        sys.stdout.flush()
        s_robot.sendall(byteIn)
            
    print("Done with the whole thing\n")

