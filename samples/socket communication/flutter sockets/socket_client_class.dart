import 'dart:io';
import 'dart:typed_data';

void main() async {
  // connect to the socket server
  var socketClientObject = SocketClientClass();
  await Future.delayed(Duration(seconds: 2));
  socketClientObject.sendMessage("Message 1");
  await Future.delayed(Duration(seconds: 2));
  socketClientObject.sendMessage("Message 14");

  // listen for responses from the server
  // socket.listen(
  //   // handle data from the server
  //   (Uint8List data) {
  //     final serverResponse = String.fromCharCodes(data);
  //     print('Server: $serverResponse');
  //   },
  //
  //   // handle errors
  //   onError: (error) {
  //     print(error);
  //     socket.destroy();
  //   },
  //
  //   // handle server ending connection
  //   onDone: () {
  //     print('Server left.');
  //     socket.destroy();
  //   },
  // );

  // await sendMessage(socket, "Jar Jar Binks");
}

class SocketClientClass {
  Socket? socket = null;
  bool isConnectionEstablished = false;

  SocketClientClass() {
    print('Constructor for SocketClientClass');
    this._establishConnection();
  }

  void _establishConnection() async {
    final socket = await Socket.connect('localhost', 4567);
    print('Connected to: ${socket.remoteAddress.address}:${socket.remotePort}');
    this.socket = socket;
    this.isConnectionEstablished = true;
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
