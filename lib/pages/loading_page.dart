import 'package:enri_client/pages/home_Page.dart';
import 'package:enri_client/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:enri_client/service/socket_service.dart';
import 'package:enri_client/service/auth_service.dart';


class LoadingPage extends StatelessWidget { 


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: ( context, snapshot) {
                         
               return Center (
                 child: Text ('Espere...')
                );
        }, 
      ),
    ); 
  }

  Future checkLoginState( BuildContext context ) async {

    final authService = Provider.of<AuthService>(context, listen: false);
    final socketService = Provider.of<SocketService>( context, listen: false );
       
    final autenticado = await authService.isLoggedIn();
    if ( autenticado ) {
      socketService.onConnect();   
      Navigator.pushReplacement(
        context, 
        PageRouteBuilder(
          pageBuilder: ( _, __, ___ ) => HomePage(),
          transitionDuration: Duration(milliseconds: 0)
        )
      );





    } else {
      Navigator.pushReplacement(
        context, 
        PageRouteBuilder(
          pageBuilder: ( _, __, ___ ) => LoginPage(),
          transitionDuration: Duration(milliseconds: 0)
        )
      );
    }

  }
}  


 
 