#!/usr/bin/env python3

import socket

HOST = "127.0.0.1"  # The server's hostname or IP address
PORT = 4567  # The port used by the server

with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
    print('Connecting...')
    s.connect((HOST, PORT))
    print('Connected')
    while True:
        # print('Sending message')
        # s.sendall(b"Hello, world")
        # print('Finished sending message')
        data = s.recv(1024)

        print("Received", repr(data))