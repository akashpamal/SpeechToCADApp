import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:typed_data';

class CommunicationManager {
  // This is the client side of the socket
  Socket? socket = null;
  bool isConnectionEstablished = false;

  CommunicationManager() {
    print('Constructor for SocketClientClass');
    this._establishConnection();
  }

  void _establishConnection() async {
    if (!this.isConnectionEstablished) {
      final socket = await Socket.connect('localhost', 4567);
      print(
          'Connected to: ${socket.remoteAddress.address}:${socket.remotePort}');
      this.socket = socket;
      this.isConnectionEstablished = true;

      // listen for responses from the server
      socket.listen(
        // handle data from the server
        (Uint8List data) {
          final serverResponse = String.fromCharCodes(data);
          print('Server: $serverResponse');
        },

        // handle errors
        onError: (error) {
          print(error);
          socket.destroy();
        },

        // handle server ending connection
        onDone: () {
          print('Server left.');
          socket.destroy();
        },
      );
    } else {
      print("Connection already established. Will not re-establish");
    }
  }

  Future<void> sendMessage(String message) async {
    if (this.isConnectionEstablished) {
      print('Client: $message');
      this.socket!.write(message);
    } else {
      print('Client is not connected');
    }
  }
}
