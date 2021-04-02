
import 'package:enri_client/utils/color.dart';
import 'package:enri_client/widgets/Boton_marron.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:enri_client/models/usuario.dart';
import 'package:enri_client/service/auth_service.dart';
//import 'package:enri_client/service/chat_service.dart';
import 'package:enri_client/service/socket_service.dart';
import 'package:enri_client/service/usuarios_service.dart';




class UsuariosPage extends StatefulWidget {
  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {

  final usuarioService = new UsuariosService();
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  List<Usuario> usuarios = [];


  @override
  void initState() {
    this._cargarUsuarios();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final authService   = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>( context );

    final usuario = authService.usuario;

    return Scaffold(
      appBar: AppBar(
        title: Text( usuario.nombre , style: TextStyle(color: Colors.black87 ) ),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon( Icons.exit_to_app, color: Colors.black87 ),
          onPressed: () {

            socketService.disconnect();
            Navigator.pushReplacementNamed(context, 'login');
            AuthService.deleteToken();

          },
        ),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only( right: 10 ),
            child: (socketService.serverStatus == ServerStatus.Online )
            ? Icon( Icons.check_circle, color: Colors.blue[400] )
            : Icon( Icons.offline_bolt, color: Colors.red ),
          )
        ],
      ),
        
      body: Container(
        width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
               colors: [orangeColors, orangeLightColors]
              
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                  BotonMarron(
                    text: 'Empezar',
                     onPressed:(){
                      Navigator.pushReplacementNamed(context, 'loading_gps');
                    },
            
                  )
              ]
            ),
        )
   );
  }

    

  _cargarUsuarios() async { 

    this.usuarios = await usuarioService.getUsuarios();
    setState(() {});

    // await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();

  }
}








