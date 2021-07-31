import 'package:enri_client/widgets/boton_azul.dart';
import 'package:enri_client/widgets/logo.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container (
            width: double.infinity,
            
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
      height: MediaQuery.of(context).size.height * 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                 Logo(
                   titulo: 'Empieza tu viaje',
                   subtitulo: '',
                  ),


                 BotonAzul(
                   text: 'Empezar',
                    onPressed:(){
                     Navigator.pushReplacementNamed(context, 'loading_gps');
                    },
            
                  
                  ),

              ]
            )
            )
            );
            
      
  
  }
}

