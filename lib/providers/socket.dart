import 'package:flutter/cupertino.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


enum ServerStatus{
  online,
  offLine,
  connecting
}

class SocketProvider with ChangeNotifier{

  late ServerStatus _serverStatus = ServerStatus.connecting;
  late IO.Socket _socket;

  SocketProvider(){
    _initConfi();
  }
  
  ServerStatus get serverStatus => _serverStatus;
  IO.Socket get socket => _socket;

  Function get emit => _socket.emit;

  void _initConfi() {
    //Dark Client
    _socket = IO.io('http://10.0.2.2:3000/', 
    IO.OptionBuilder()
    .setTransports(['websocket'])
    .disableAutoConnect()
    .build()
    );
    _socket.connect();

    _socket.onConnect( (_) {
      print('connect');
      _serverStatus = ServerStatus.online;
      notifyListeners();
    });
    
    _socket.onDisconnect( (_) {
      print('disconnect');
      _serverStatus = ServerStatus.offLine;
      notifyListeners();
    });
  }

}