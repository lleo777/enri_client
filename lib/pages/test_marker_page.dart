import 'package:enri_client/custom_markers/custom_markers.dart';
import 'package:flutter/material.dart';


class TestMarkerPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
       child: Container(
         width: 350,
         height: 150,
         color: Colors.red,
         child: CustomPaint(
           painter: MarkerInicioPainter( 250 ),
          //  painter: MarkerDetinoPainter(
          //    'Mi casa por algún lado del mundo, esta aquí, asdasd asdasd',
          //    250904
          //  ),
         ),
       ),
     ),
   );
  }
}