import adsk.core, adsk.fusion, math, traceback
import socket, time, asyncio



# Make the client on Fusion360 and the server on the app

def run(context):
    ui = None
    try:
        communication_manager_object = CommunicationManager()
        communication_manager_object.listen_and_execute_incoming_commands()
        # app = adsk.core.Application.get()
        # ui = app.userInterface
        # ui.messageBox('Starting')

        # # doc = app.documents.add(adsk.core.DocumentTypes.FusionDesignDocumentType)
        # design = app.activeProduct

        # # Get the root component of the active design.
        # rootComp = design.rootComponent
        # sketch = rootComp.sketches.add(rootComp.xYConstructionPlane)
        # rec1 = sketch.sketchCurves.sketchLines.addTwoPointRectangle(adsk.core.Point3D.create(0, 0, 0), adsk.core.Point3D.create(20, 20, 0))
        # # DRAWING A CUBE
        # extrude = rootComp.features.extrudeFeatures.addSimple(sketch.profiles[-1], adsk.core.ValueInput.createByReal(20), adsk.fusion.FeatureOperations.NewBodyFeatureOperation)


        # Create a new sketch on the xy plane.

        """
        Do not delete this section – it's used for parsing
        """
    except:
        if ui:
            ui.messageBox('Failed:\n{}'.format(traceback.format_exc()))

class CommunicationManager:
    HOST = "127.0.0.1"  # Standard loopback interface address (localhost)
    PORT = 4567  # Port to listen on (non-privileged ports are > 1023)
    
    def __init__(self) -> None:
        pass

    def listen_and_execute_incoming_commands(self, print_method=print):
        app = adsk.core.Application.get()
        ui = app.userInterface
        design = app.activeProduct
        rootComp = design.rootComponent
        sketch = rootComp.sketches.add(rootComp.xYConstructionPlane)
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
            s.bind((CommunicationManager.HOST, CommunicationManager.PORT))
            # s.setblocking(False)
            print('Server listening')
            s.listen()
            conn, addr = s.accept()
            # conn.setblocking(0)
            print('Server accepted')
            with conn:
                print("Connected by", addr)
                while True:
                    print(time.perf_counter())
                    print('Waiting for new data:')
                    data = conn.recv(1024)
                    if not data:
                        print('not data if-statement triggered')
                        break
                    conn.sendall(data)
                    print('Message received:', str(data))
                    try:
                        print('Executing message...')
                        exec(data)
                        print('Message finished executing')
                        print(time.perf_counter())
                        print()
                        # print('Waiting for some time:')
                        # asyncio.sleep(4)
                        # print('Finished waiting')
                    except Exception as e:
                        print('Faced Exception:')
                        print(e)
                        exit()

        
        # while True: # re-establish the server connection after each command. The connection must first be terminated to allow the Fusion API call to process
        #     with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        #         s.bind((CommunicationManager.HOST, CommunicationManager.PORT))
        #         # print_method('Server listening')
        #         s.listen()
        #         conn, addr = s.accept()
        #         # print_method('Server accepted')
        #         with conn:
        #             # print_method("Connected by", ', '.join(list([str(elem) for elem in addr]))) # print connection address
        #             data = conn.recv(1024)
        #             if not data:
        #                 break
        #             conn.sendall(data)
        #             data = data.decode("utf-8")
        #             # print_method('Message received: ' + data)
        #             # print_method('Running message: ' + data)
        #             try:
        #                 exec(data)
        #             except Exception as e:
        #                 # print_method('Invalid python command passed through socket: ' + data)
        #                 # print_method(e)
        #             # print_method('\n')