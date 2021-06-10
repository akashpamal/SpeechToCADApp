print('Starting imports...')
import adsk.core, adsk.fusion, math, traceback
import socket, time, asyncio
import math
import asyncio
print('Imports complee')

# Make the client on Fusion360 and the server on the app

def run(context):
    ui = None
    try:
        print('Starting program...')
        communication_manager_object = CommunicationManagerServer()
        communication_manager_object.listen_and_execute_incoming_commands()
        # app = adsk.core.Application.get()
        # # ui = app.userInterface
        # # ui.messageBox('Starting')

        # doc = app.documents.add(adsk.core.DocumentTypes.FusionDesignDocumentType)
        # design = app.activeProduct

        # # Get the root component of the active design.
        # rootComp = design.rootComponent
        # sketch = rootComp.sketches.add(rootComp.xYConstructionPlane)
        # rec1 = sketch.sketchCurves.sketchLines.addTwoPointRectangle(adsk.core.Point3D.create(0, 0, 0), adsk.core.Point3D.create(20, 20, 0))
        # # DRAWING A CUBE
        # extrude = rootComp.features.extrudeFeatures.addSimple(sketch.profiles[-1], adsk.core.ValueInput.createByReal(20), adsk.fusion.FeatureOperations.NewBodyFeatureOperation)
        
        
        # centerAndShowInWindowAllVisibleObjects()


        # Create a new sketch on the xy plane.
        print('Terminating program...')
    except:
        if ui:
            ui.messageBox('Failed:\n{}'.format(traceback.format_exc()))

class CommunicationManagerServer:
    HOST = "127.0.0.1"  # Standard loopback interface address (localhost)
    PORT = 4567  # Port to listen on (non-privileged ports are > 1023)
    
    def __init__(self) -> None:
        pass

    def listen_and_execute_incoming_commands_old(self, print_method=print):
        # setup items
        app = adsk.core.Application.get()
        ui = app.userInterface
        # doc = app.documents.add(adsk.core.DocumentTypes.FusionDesignDocumentType)
        design = app.activeProduct
        rootComp = design.rootComponent
        # sketch = rootComp.sketches.add(rootComp.xYConstructionPlane)

        # Start listening to the socket
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
            s.bind((CommunicationManagerServer.HOST, CommunicationManagerServer.PORT))
            # s.setblocking(False)
            print('Server listening')
            s.listen()
            conn, addr = s.accept()
            # conn.setblocking(0)
            print('Server accepted')
            conn.settimeout(3)
            with conn:
                print("Connected by", addr)
                while True:
                    # print(time.perf_counter())
                    print('Waiting for new data:')
                    conn.settimeout(3)
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
                        # print(time.perf_counter())
                        print()
                        # print('Waiting for some time:')
                        # asyncio.sleep(4)
                        # print('Finished waiting')
                    except Exception as e:
                        print('Faced Exception:')
                        print(e)
        print('Program complete')

    def listen_and_execute_incoming_commands(self, print_method=print):
        # setup items
        global app, ui, design, rootComp
        app = adsk.core.Application.get()
        ui = app.userInterface
        design = app.activeProduct
        rootComp = design.rootComponent

        # Start listening to the socket
        async def handle_echo(reader, writer):

            global app, ui, design, rootComp

            data = await reader.read(1024)
            print('data received:', data)
            message = data.decode()
            print('decoded message:', message)
            print('Executing message...')
            try:
                exec(message)
                print('Message finished executing')
            except Exception as e:
                print('Message was not executable')
                print(e)
            # addr = writer.get_extra_info('peername')

            # print(f"Received {message!r} from {addr!r}")

            print(f"Send: {message!r}")
            print()
            writer.write(data)
            await writer.drain()

            # print("Close the connection")
            writer.close()

        async def asyncio_main():
            server = await asyncio.start_server(
                handle_echo, '127.0.0.1', 4567)

            # addr = server.sockets[0].getsockname()
            # print(f'Serving on {addr}')

            # print('print 1')
            async with server:
                await server.serve_forever()
                # print('print 2')
        
        print('Starting server...')
        asyncio.run(asyncio_main())
        # print('Program complete')

