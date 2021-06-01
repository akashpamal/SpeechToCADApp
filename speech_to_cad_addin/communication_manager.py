import socket

class CommunicationManager:
    HOST = "127.0.0.1"  # Standard loopback interface address (localhost)
    PORT = 4567  # Port to listen on (non-privileged ports are > 1023)
    
    def __init__(self) -> None:
        pass