#!/usr/bin/env python3

import socket

HOST = "127.0.0.1"  # Standard loopback interface address (localhost)
PORT = 4567  # Port to listen on (non-privileged ports are > 1023)

with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
    s.bind((HOST, PORT))
    print('Server listening')
    s.listen()
    conn, addr = s.accept()
    print('Server accepted')
    with conn:
        print("Connected by", addr)
        while True:
            data = conn.recv(1024)
            if not data:
                break
            conn.sendall(data)
            data = data.decode("utf-8")
            print('Message received:', data)
            print('Type of message:', type(data))
            print('Running message:')
            exec(data)
            exec("print('is this message working?')")
