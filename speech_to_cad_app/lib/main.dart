import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:typed_data';

import 'package:speech_to_cad_app/communication_manager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  CommunicationManager communicationManager = CommunicationManager();
  final textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: textEditingController,
            ),
            TextButton(
              onPressed: () {
                communicationManager
                    .sendMessage("app = adsk.core.Application.get()");
                // communicationManager.sendMessage("exit()");
              },
              child: Text("Command 1"),
            ),
            TextButton(
              onPressed: () {
                communicationManager.sendMessage("ui = app.userInterface");
              },
              child: Text("Command 2"),
            ),
            TextButton(
              onPressed: () {
                communicationManager
                    .sendMessage("design = app.activeProduct");
              },
              child: Text("Command 3"),
            ),
            TextButton(
              onPressed: () {
                communicationManager
                    .sendMessage("rootComp = design.rootComponent");
              },
              child: Text("Command 4"),
            ),
            TextButton(
              onPressed: () {
                communicationManager.sendMessage(
                    "sketch = rootComp.sketches.add(rootComp.xYConstructionPlane)");
              },
              child: Text("Command 5"),
            ),
            TextButton(
              onPressed: () {
                communicationManager.sendMessage(
                    "rec1 = sketch.sketchCurves.sketchLines.addTwoPointRectangle(adsk.core.Point3D.create(0, 0, 0), adsk.core.Point3D.create(20, 20, 0))");
              },
              child: Text("Command 6"),
            ),
            TextButton(
              onPressed: () {
                communicationManager.sendMessage(
                    "exit()");
              },
              child: Text("exit()"),
            ),TextButton(
              onPressed: () {
                communicationManager.sendMessage(
                    "break");
              },
              child: Text("break"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // print("Floating Action Button pressed");
          // communicationManager.establishConnection();
          communicationManager.sendMessage(textEditingController.text);
          // mainConnection();
          // print(textEditingController.text);
        },
        child: Icon(Icons.wifi),
      ),
    );
  }
}

// void mainConnection() async {
//   print("Binding socket");
//   // bind the socket server to an address and port
//   final server = await ServerSocket.bind(InternetAddress.anyIPv4, 4567);
//
//   print("Listening for connection");
//   // listen for clent connections to the server
//   server.listen((client) {
//     handleConnection(client);
//   });
// }
//
// void handleConnection(Socket client) {
//   print('Connection from'
//       ' ${client.remoteAddress.address}:${client.remotePort}');
//
//   // listen for events from the client
//   client.listen(
//     // handle data from the client
//     (Uint8List data) async {
//       await Future.delayed(Duration(seconds: 1));
//       final message = String.fromCharCodes(data);
//       if (message == 'Knock, knock.') {
//         client.write('Who is there?');
//       } else if (message.length < 10) {
//         client.write('$message who?');
//       } else {
//         client.write('Very funny.');
//         client.close();
//       }
//     },
//
//     // handle errors
//     onError: (error) {
//       print(error);
//       client.close();
//     },
//
//     // handle the client closing the connection
//     onDone: () {
//       print('Client left');
//       client.close();
//     },
//   );
// }
