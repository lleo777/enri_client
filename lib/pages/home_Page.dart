import 'package:enri_client/utils/color.dart';
//import 'package:enri_client/widgets/Boton_marron.dart';
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
               colors: [orangeColors, orangeLightColors]
              
              ),
            ),
            //child: Column(
              //children: <Widget>[
                //  BotonMarron(
                  //  text: 'Empezar',
                    // onPressed:(){
                     // Navigator.pushReplacementNamed(context, 'loading_gps');
                    //},
            
                  )
              //]
            );
      
  
  }
}

