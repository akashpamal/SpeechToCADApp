import 'dart:io';
import 'dart:typed_data';
import 'dart:core';
// import


void main() async {
  // bind the socket server to an address and port
  final server = await ServerSocket.bind(InternetAddress.anyIPv4, 4567);
  var client_variable = null;

  // print('Runtime type:' + server.runtimeType.toString());
  // print('isBroadcast: ' + server.isBroadcast.toString());
  // client.write('Hello there');
  // client.write('This is my second message');
  // client.write('Welcome to the gulag');

  // listen for client connections to the server
  server.listen((client) {
    // client.write('Hello there');
    handleConnection(client);
    // client_variable = client;
  });

  // client_variable.write("Message from client variable");


  // client.write("Hello there again");
  // server.listen((client) {
  //   client.write('This is my second message');
  // });

  // server.listen((client) {
  //   client.write('Welcome to the gulag');
  // });



}

void handleConnection(Socket client) {
  print('Connection from'
      ' ${client.remoteAddress.address}:${client.remotePort}');

  // client.write('Hello there');
  // client.write('This is my second message');
  // client.write('Welcome to the gulag');

  client.listen(

    // handle data from the client
        (Uint8List data) async {
      // await Future.delayed(Duration(seconds: 1));
      final message = String.fromCharCodes(data);
      print('Messaged received: ' + message);
      // if (message == 'Knock, knock.') {
      //   client.write('Who is there?');
      // } else if (message.length < 10) {
      //   client.write('$message who?');
      // } else {
      //   client.write('Very funny.');
      //   client.close();
      // }
    },

    // handle errors
    onError: (error) {
      print(error);
      client.close();
    },

    // handle the client closing the connection
    onDone: () {
      print('Client left');
      client.close();
    },
  );
}