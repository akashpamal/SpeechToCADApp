import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:typed_data';

class CommunicationManagerClient {
  // This is the client side of the socket
  Socket? socket = null;
  List<String> globalPythonVariables = [];

  CommunicationManagerClient() {
    this.establishConnection();
  }

  Future<void> establishConnection() async {
    final socket = await Socket.connect('localhost', 4567);
    print('Connected to: ${socket.remoteAddress.address}:${socket.remotePort}');
    // socket.asBroadcastStream()
    this.socket = socket;

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
  }

  void addGlobalVariable(String globalVariable) {
    this.globalPythonVariables.add(globalVariable);
  }
  
  Future<void> sendMessage(String message) async {
    await this.establishConnection();
    String globalPythonVariablesString = 'global ' + this.globalPythonVariables.join(', ') + '\n';

    String sendingMessage = globalPythonVariablesString + message + "\n";
    this.socket!.write(sendingMessage);

    // this.refreshViewUNIMPLEMENTED();
    print('Message sent: ' + sendingMessage);
  }

  Future<void> createNewDocument() async {
    await this.sendMessage("app = adsk.core.Application.get()");
    await this.sendMessage("ui = app.userInterface");
    await this.sendMessage(
        "doc = app.documents.add(adsk.core.DocumentTypes.FusionDesignDocumentType)");
    await this.sendMessage("design = app.activeProduct");
    await this.sendMessage("rootComp = design.rootComponent");
  }

  Future<void> fitCameraViewBROKEN() async {
    await this.sendMessage("camera = app.activeViewport.camera");
    await this.sendMessage("camera.isFitView = True");
    await this.sendMessage("app.activeViewport.camera = camera");
  }

  Future<void> refreshView() async {
    // this.sendMessage("adsk.doEvents()");
    await this.sendMessage("global app; app.activeViewport.refresh()");
  }
}
//
// class CommunicationManagerServer {
//   // This is the server side of the socket
//   // Socket? socket = null;
//   bool isConnectionEstablished = false;
//
//   CommunicationManagerServer() {
//     print('Constructor for SocketClientClass');
//     this._establishConnection();
//   }
//
//   void _establishConnection() async {
//     if (!this.isConnectionEstablished) {
//       final server = await ServerSocket.bind(InternetAddress.anyIPv4, 4567);
//
//       // print('Runtime type:' + server.runtimeType.toString());
//       // print('isBroadcast: ' + server.isBroadcast.toString());
//       // client.write('Hello there');
//       // client.write('This is my second message');
//       // client.write('Welcome to the gulag');
//
//       // listen for clent connections to the server
//       server.listen((client) {
//         // client.write('Hello there');
//         client.listen(
//
//           // handle data from the client
//               (Uint8List data) async {
//             // await Future.delayed(Duration(seconds: 1));
//             final message = String.fromCharCodes(data);
//             if (message == 'Knock, knock.') {
//               client.write('Who is there?');
//             } else if (message.length < 10) {
//               client.write('$message who?');
//             } else {
//               client.write('Very funny.');
//               client.close();
//             }
//           },
//
//           // handle errors
//           onError: (error) {
//             print(error);
//             client.close();
//           },
//
//           // handle the client closing the connection
//           onDone: () {
//             print('Client left');
//             client.close();
//           },
//         );
//       });
//
//     } else {
//       print("Connection already established. Will not re-establish");
//     }
//   }
//
//   Future<void> sendMessage(String message) async {
//     if (this.isConnectionEstablished) {
//       print('Client: $message');
//       this.socket!.write(message);
//     } else {
//       print('Client is not connected');
//     }
//   }
// }
