

import 'package:flutter/material.dart';

class Logo extends StatelessWidget {

  final String titulo;
  final String subtitulo;
  const Logo({
    Key key, 
    @required this.titulo,
     this.subtitulo
  }) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 390,
        margin: EdgeInsets.only( top: 6 ),
        child: Column(
          children: <Widget>[

            Image( image: AssetImage('assets/mi-logo.png') ),
            SizedBox(
             width: double.infinity,   
              ),
            Text( this.titulo, style: TextStyle(fontSize: 44, color: Colors.white, fontFamily: 'Elegante' )),
            Text(this.subtitulo, style: TextStyle(fontSize: 38, color: Colors.white, fontFamily: 'Elegante' )
            ),


          ],
        ),
      ),
    );
  }
}