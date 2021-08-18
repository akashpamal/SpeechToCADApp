from FusionScriptRunner import CommunicationManagerServer


def main():
    print('Starting main method')
    communication_manager_object = CommunicationManagerServer()
    communication_manager_object.listen_and_execute_incoming_commands()
    print('Program complete')

main()