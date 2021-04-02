import 'package:flutter/material.dart';


class BotonMarron extends StatelessWidget {

  final String text;
  final Function onPressed;

  const BotonMarron({
    Key key, 
    @required this.text, 
    @required this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
          
        onPressed: this.onPressed,
        style: ElevatedButton.styleFrom(
          primary: Colors.brown [50],
          elevation: 5,
          shape: StadiumBorder(),
          minimumSize: Size(200, 40)
          
        ),
        
        child: Text( this.text , style: TextStyle( color: Colors.black, fontSize: 17 ),  
                    
        ),
    );
    
  }

}
















