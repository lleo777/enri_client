import 'package:enri_client/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:enri_client/service/auth_service.dart';
import 'package:enri_client/service/chat_service.dart';
import 'package:enri_client/service/socket_service.dart';
import 'package:flutter/material.dart';


import 'package:enri_client/routes/routes.dart';

void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ ) => AuthService() ),
        ChangeNotifierProvider(create: ( _ ) => SocketService() ),
        ChangeNotifierProvider(create: ( _ ) => ChatService() ),
        BlocProvider(create: (_) => MiUbicacionBloc() ),
        //BlocProvider(create: (_) => MapaBloc()),
      ],
        
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chat App',
        //initialRoute: 'usuarios',
        initialRoute: 'login',
        routes: appRoutes,
        
      ),     
       
    );
  }
  
}