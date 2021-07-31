//import 'package:enri_client/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:enri_client/global/environment.dart';
import 'package:enri_client/service/auth_service.dart';
import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus {
  Online,
  Offline,
  Connecting
}


class SocketService with ChangeNotifier {

  ServerStatus _serverStatus = ServerStatus.Connecting;
  IO.Socket _socket;

  ServerStatus get serverStatus => this._serverStatus; 

  IO.Socket get socket => this._socket;
  Function get emit => this._socket.emit;
  
  
  void onConnect() async {

    final token = await AuthService.getToken();
    
    //Dart client
    this._socket = IO.io( Environment.urlSocket,
        IO.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .enableAutoConnect()
            .setExtraHeaders({'x-token': token }) // optional
            .build());
      
    
    
    this._socket.onConnect( (_) {
      this._serverStatus = ServerStatus.Online;
      print('connect');
      notifyListeners();
    });

    this._socket.onDisconnect( (_) {
      this._serverStatus = ServerStatus.Offline;
      print('ondisconnect');
      notifyListeners();
    });

  
  }
  void onDisconnect() {

      this._socket.onDisconnect((_) => print('disconnect'));
      notifyListeners(); 
  }

}