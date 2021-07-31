import 'package:enri_client/pages/acceso_gps_page.dart';
import 'package:enri_client/pages/loading_gps.dart';
import 'package:enri_client/pages/mapa_page.dart';
import 'package:enri_client/pages/home_Page.dart';
import 'package:enri_client/pages/test_conection.text';
import 'package:enri_client/pages/usuario_page.dart';
import 'package:flutter/material.dart';


import 'package:enri_client/pages/chat_page.dart';
import 'package:enri_client/pages/loading_page.dart';
import 'package:enri_client/pages/login_page.dart';
import 'package:enri_client/pages/register_page.dart';




final Map<String, Widget Function(BuildContext)> appRoutes = {

  'acceso_gps'  : ( _ ) => AccesoGpsPage(),
  'chat'        : ( _ ) => ChatPage(),
  'login'       : ( _ ) => LoginPage(),
  'register'    : ( _ ) => RegisterPage(),
  'loading'     : ( _ ) => LoadingPage(),
  'mapa'        : ( _ ) => MapaPage(),
  'home_page'   : ( _ ) => HomePage(),
  'loading_gps' : ( _ ) => LoadingGps(),
  'usuarios'    : ( _ ) => UsuariosPage(),
  'conection'   : ( _ ) => TestConection(),
  
  
};


