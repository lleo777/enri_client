import 'dart:async';
import 'package:bloc/bloc.dart';


import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart' as Geolocator;
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:meta/meta.dart';

part 'mi_ubicacion_event.dart';
part 'mi_ubicacion_state.dart';

class MiUbicacionBloc extends Bloc<MiUbicacionEvent, MiUbicacionState> {
  MiUbicacionBloc() : super(MiUbicacionState());  
 
  StreamSubscription<Geolocator.Position> _positionSubscription;
  
  void iniciarSeguimiento(){    
     
     Geolocator.Geolocator.getPositionStream(
      desiredAccuracy: Geolocator.LocationAccuracy.high, 
      distanceFilter: 10)
        .listen((Geolocator.Position position) {                    
          add(OnUbicacionCambio(LatLng(position.latitude, position.longitude)));          
          // print(position);
          
    });

  }
  void cancelarSeguimiento() {
    _positionSubscription?.cancel();
  }

  @override
  Stream<MiUbicacionState> mapEventToState( MiUbicacionEvent event,) async* {
    // print('Event: $event');
    // print('state: ${state.ubicacion}');
    // implement mapEventToState
    if ( event is OnUbicacionCambio ) {
     yield state.copyWith(
       existeUbicacion: true,
       ubicacion: event.ubicacion
      );
    }
    // print('state: ${state.ubicacion}');
  }


  
  
}








