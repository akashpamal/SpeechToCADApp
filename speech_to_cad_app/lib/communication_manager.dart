import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:typed_data';

class CommunicationManager {
  // This is the client side of the socket communication
  static const String HOST = "127.0.0.1";
  static const int PORT = 4567;

  bool isConnectionEstablished = false;
  var socket; // TODO make this a constant or final

  CommunicationManager() {
    // this.establishConnection();
  }

  void establishConnection() async {
    if (this.isConnectionEstablished) {
      print("Connection is already established");
    } else {
      print("Binding socket");

      // connect to the socket server
      final socket = await Socket.connect('localhost', 4567);
      print(
          'Connected to: ${socket.remoteAddress.address}:${socket.remotePort}');
      this.socket = socket;
    }
  }

  Future<void> sendMessage(String message) async {
    print('Client: $message');
    this.socket.write(message);
    // await Future.delayed(Duration(seconds: 2));
  }
}
