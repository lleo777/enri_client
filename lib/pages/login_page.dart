import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'package:enri_client/service/socket_service.dart';
import 'package:enri_client/service/auth_service.dart';

import 'package:enri_client/helpers/mostrar_alerta.dart';

import 'package:enri_client/widgets/labels.dart';
import 'package:enri_client/widgets/logo.dart';

import 'package:enri_client/widgets/custom_input.dart';
import 'package:enri_client/widgets/boton_azul.dart';


class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              // stops: [0.5, 1],  
              colors: [
                Colors.white10,
                Colors.purpleAccent[400],
                Colors.purple[800],
                
                ]
          )
      ),
           height: MediaQuery.of(context).size.height * 0.97,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[

                Logo( 
                  titulo: 'Bienvenido',
                  subtitulo: 'a Inri', ),


                _Form(),

                Labels( 
                  ruta: 'register',
                  titulo: '¿No tienes cuenta?',
                  subTitulo: 'Crea una ahora!',
                ),

                Text('Términos y condiciones de uso', style: TextStyle( fontWeight: FontWeight.w400, color: Colors.white ),)

              ],
            ),
          ),
        ),
      )
   );
  }
}



class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {

  final emailCtrl = TextEditingController();
  final passCtrl  = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final authService   = Provider.of<AuthService>( context );
    final socketService = Provider.of<SocketService>( context );

    return Container(
      margin: EdgeInsets.only(top: 30),
      padding: EdgeInsets.symmetric( horizontal: 45 ),
       child: Column(
         children: <Widget>[
           
           SizedBox(
             height: 65,
             child: CustomInput(
               icon: Icons.mail_outline,
               placeholder: 'Correo',
               keyboardType: TextInputType.emailAddress, 
               textController: emailCtrl,
             ),
           ),

           SizedBox(
             height: 65,
             child: CustomInput(
               icon: Icons.lock_outline,
               placeholder: 'Contraseña',
               textController: passCtrl,
               isPassword: true,
             ),
           ),
           

           BotonAzul(
             text: 'Ingrese',
             onPressed: authService.autenticando ? null : () async {

               FocusScope.of(context).unfocus();

               final loginOk = await authService.login( emailCtrl.text.trim(), passCtrl.text.trim() );

                if ( loginOk ) {
                  socketService.onConnect();
                  Navigator.pushReplacementNamed(context, 'usuarios');
                } else {
                  // Mostara alerta
                  mostrarAlerta(context, 'Login incorrecto', 'Revise sus credenciales nuevamente');
                }

             },
           )



         ],
       ),
    );
  }
}
