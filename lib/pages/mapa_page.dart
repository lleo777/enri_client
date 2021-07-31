import 'package:enri_client/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:enri_client/mapa/mapa_bloc.dart';


import 'package:enri_client/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';






class MapaPage extends StatefulWidget {

  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {

 
@override
  void initState() {
       
    // implement initState
    BlocProvider.of<MiUbicacionBloc>(context).iniciarSeguimiento();
    super.initState();
    
  }
  @override
  void dispose() {
        
    // implement dispose
    BlocProvider.of<MiUbicacionBloc>(context).cancelarSeguimiento();
    super.dispose();
  }

 @override 
 Widget build(BuildContext context) {

   
   
  return Scaffold (
    
    body:  Stack(
      children: [
        BlocBuilder<MiUbicacionBloc, MiUbicacionState>(
          builder: ( _ , state) => crearMapa( state)
            
          
          ),
          // Hacer el toggle cuadno estoy manualmente
          Positioned(
            top: 15,
            child: SearchBar()
            ),
          MarcadorManual(),
          SolicitudConductor(),
      ],
    ),

      floatingActionButton:Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [

          BtnUbicacion(),

          BtnSeguirUbicacion(),

          BtnMiRuta(),

          

        ],
      ),
     
    
  );

 }

 Widget crearMapa(MiUbicacionState state) {

      //final socketService = Provider.of<SocketService>( context );
   
      if (!state.existeUbicacion) return Center(child: Text('Ubicando...'));

      final mapaBloc = BlocProvider.of<MapaBloc>(context);

      mapaBloc.add( OnNuevaUbicacion( state.ubicacion ) );

     // socketService.emit(mapaBloc);



      final cameraPosition = new CameraPosition(
        target: state.ubicacion,
        zoom: 15

      );

      return BlocBuilder<MapaBloc, MapaState>(
        builder: (context, _) {
          return GoogleMap(
           initialCameraPosition: cameraPosition,
           myLocationEnabled: true,
           myLocationButtonEnabled: false,
           zoomControlsEnabled: false,
           onMapCreated: mapaBloc.initMapa,
           polylines: mapaBloc.state.polylines.values.toSet(),
           markers: mapaBloc.state.markers.values.toSet(),
           onCameraMove: ( cameraPosition ) {
            
            mapaBloc.add( OnMovioMapa( cameraPosition.target ));
          },
        );
      },
    ); 
     
 }
}





