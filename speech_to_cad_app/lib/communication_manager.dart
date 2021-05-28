import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:typed_data';

class CommunicationManager {
  // This is the server side of the socket communication
  static const String HOST = "127.0.0.1";
  static const int PORT = 4567;

  int arbitraryCounter = 0;

  var server; // TODO make this a constant or final

  CommunicationManager() {
    this.establishConnection();
  }

  void establishConnection() async {
    print("Binding socket");
    // bind the socket server to an address and port
    final server = await ServerSocket.bind(InternetAddress.anyIPv4, 4567);
    this.server = server;
    print("Type of server variable:");
    print(server.runtimeType);
  }

  // bool isAlreadyConnected = false;

  bool isConnected() {
    return false;
  }

  void sendInstructions() {
    arbitraryCounter++;
    this.server.listen((client) {
      client.write(arbitraryCounter.toString());
    });
  }

  void mainConnection() async {
    print("Binding socket");
    // bind the socket server to an address and port
    final server = await ServerSocket.bind(InternetAddress.anyIPv4, 4567);

    print("Listening for connection");
    // listen for clent connections to the server
    server.listen((client) {
      handleConnection(client);
    });
  }

  void handleConnection(Socket client) {
    print('Connection from'
        ' ${client.remoteAddress.address}:${client.remotePort}');

    client.write("Test 1 from Flutter server");
    // listen for events from the client
    // client.listen(
    //   // handle data from the client
    //   (Uint8List data) async {
    //     await Future.delayed(Duration(seconds: 1)); // TODO delete this line if possible (it looks like it's just waiting a second for no reason)
    //     final message = String.fromCharCodes(data);
    //     if (message == 'Knock, knock.') {
    //       client.write('Who is there?');
    //     } else if (message.length < 10) {
    //       client.write('$message who?');
    //     } else {
    //       client.write('Very funny.');
    //       client.close();
    //     }
    //   },
    //
    //   // handle errors
    //   onError: (error) {
    //     print(error);
    //     client.close();
    //   },
    //
    //   // handle the client closing the connection
    //   onDone: () {
    //     print('Client left');
    //     client.close();
    //   },
    // );
  }
}
