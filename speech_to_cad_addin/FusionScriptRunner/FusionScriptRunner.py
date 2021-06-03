#Author-
#Description-

import adsk.core, adsk.fusion, adsk.cam, traceback
import socket
# from

def run(context):
    print('Beginning run method')
    ui = None
    try:
        app = adsk.core.Application.get()
        ui = app.userInterface
        # for i 
        # print('Can fusion print things?')
        # ui.messageBox('Hello script')

        my_communication_manager = CommunicationManager()

        # print('Opening socket and listening now...')
        my_communication_manager.listen_and_execute_incoming_commands(print_method=ui.messageBox) # THERE SHOULD NOT BE ANY COMMANDS AFTER THIS LINE. This method blocks the thread and continues forever or until interrupted

    except:
        if ui:
            ui.messageBox('Failed:\n{}'.format(traceback.format_exc()))


class CommunicationManager:
    HOST = "127.0.0.1"  # Standard loopback interface address (localhost)
    PORT = 4567  # Port to listen on (non-privileged ports are > 1023)
    
    def __init__(self) -> None:
        pass
    #!/usr/bin/env python3

    def listen_and_execute_incoming_commands(self, print_method=print):
        while True: # re-establish the server connection after each command. The connection must first be terminated to allow the Fusion API call to process
            with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
                s.bind((CommunicationManager.HOST, CommunicationManager.PORT))
                # print_method('Server listening')
                s.listen()
                conn, addr = s.accept()
                print_method('Server accepted')
                with conn:
                    # print_method("Connected by", ', '.join(list([str(elem) for elem in addr]))) # print connection address
                    data = conn.recv(1024)
                    if not data:
                        break
                    conn.sendall(data)
                    data = data.decode("utf-8")
                    # print_method('Message received: ' + data)
                    print_method('Running message: ' + data)
                    try:
                        exec(data)
                    except Exception as e:
                        print_method('Invalid python command passed through socket: ' + data)
                        print_method(e)
                    # print_method('\n')
        print_method("Terminiating program. Goodbye!")