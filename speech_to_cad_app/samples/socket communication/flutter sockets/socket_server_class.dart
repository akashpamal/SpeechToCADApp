import 'dart:io';
import 'dart:typed_data';
import 'dart:core';
// import

void main() async {
  // bind the socket server to an address and port
  var socketServerObject = SocketServerClass();

  // client_variable.write("Message from client variable");

  // client.write("Hello there again");
  // server.listen((client) {
  //   client.write('This is my second message');
  // });

  // server.listen((client) {
  //   client.write('Welcome to the gulag');
  // });
}

class SocketServerClass {
  var server = null;

  SocketServerClass() {
    print('Constructor for SocketServerClass');
    this._establishConnection();
  }

  void _establishConnection() async {
    final server = await ServerSocket.bind(InternetAddress.anyIPv4, 4567);
    this.server = server;

    // listen for client connections to the server
    server.listen((client) {
      handleConnection(client);
    });
  }

  void handleConnection(Socket client) {
    print('Connection from'
        ' ${client.remoteAddress.address}:${client.remotePort}');

    client.listen(
      // handle data from the client
      (Uint8List data) async {
        // await Future.delayed(Duration(seconds: 1));
        final message = String.fromCharCodes(data);
        print('Messaged received: ' + message);
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
}
