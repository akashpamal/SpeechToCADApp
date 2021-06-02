#Author-
#Description-

import adsk.core, adsk.fusion, adsk.cam, traceback
import socket

def run(context):
    print('Beginning run method')
    ui = None
    try:
        app = adsk.core.Application.get()
        ui  = app.userInterface
        ui.messageBox('Hello script')

        my_communication_manager = CommunicationManager()

        print('Opening socket and listening now...')
        my_communication_manager.listen_and_execute_incoming_commands() # THERE SHOULD NOT BE ANY COMMANDS AFTER THIS LINE. This method blocks the thread and continues forever or until interrupted

    except:
        if ui:
            ui.messageBox('Failed:\n{}'.format(traceback.format_exc()))


class CommunicationManager:
    HOST = "127.0.0.1"  # Standard loopback interface address (localhost)
    PORT = 4567  # Port to listen on (non-privileged ports are > 1023)
    
    def __init__(self) -> None:
        pass
    #!/usr/bin/env python3

    def listen_and_execute_incoming_commands(self):
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
            s.bind((CommunicationManager.HOST, CommunicationManager.PORT))
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
                    print('Running message:')
                    try:
                        exec(data)
                    except Exception:
                        print('Invalid python command passed through socket:', data)
                    print()