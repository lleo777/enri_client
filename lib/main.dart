import 'package:enri_client/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:enri_client/mapa/mapa_bloc.dart';
import 'package:enri_client/busqueda/busqueda_bloc.dart';
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
        
        
        
      ],

      child: MultiBlocProvider(
        providers: [
           BlocProvider(create: (_) => MiUbicacionBloc() ),
           BlocProvider(create: ( _ ) => MapaBloc() ),
           BlocProvider(create: ( _ ) => BusquedaBloc() ),
              ], 
               child: MaterialApp(
                          debugShowCheckedModeBanner: false,
                          title: 'Chat App',
                          initialRoute: 'login',
                          //initialRoute: 'mapa',
                          routes: appRoutes,
                          
                        ),
              )
               
            );  
          }
        }
        
        
      
        
  
