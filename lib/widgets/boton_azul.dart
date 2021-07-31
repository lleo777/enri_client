import 'package:flutter/material.dart';

class BotonAzul extends StatelessWidget {

  final String text;
  final Function onPressed;

  const BotonAzul({
    Key key, 
    @required this.text, 
    @required this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
          
        onPressed: this.onPressed,
        style: ElevatedButton.styleFrom(
          primary: Colors.blue,
          elevation: 5,
          shape: StadiumBorder(),
          minimumSize: Size(195, 37)
          
        ),
        
        child: Text( this.text , style: TextStyle( color: Colors.white, fontSize: 17 ),  
                    
        ),
    );
    
  }

}