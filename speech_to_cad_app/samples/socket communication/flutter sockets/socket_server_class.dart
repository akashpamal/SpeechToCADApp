import 'dart:io';
import 'dart:typed_data';
import 'dart:core';
// import


void main() async {
  // bind the socket server to an address and port
  final server = await ServerSocket.bind(InternetAddress.anyIPv4, 4567);

  // print('Runtime type:' + server.runtimeType.toString());
  // print('isBroadcast: ' + server.isBroadcast.toString());
  // client.write('Hello there');
  // client.write('This is my second message');
  // client.write('Welcome to the gulag');

  // listen for clent connections to the server
  server.listen((client) {
    // client.write('Hello there');
    handleConnection(client);
  });

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

  client.write('Hello there');
  // client.write('This is my second message');
  // client.write('Welcome to the gulag');

}