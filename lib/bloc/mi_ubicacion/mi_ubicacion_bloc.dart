import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart' as Geolocator;
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:meta/meta.dart';

part 'mi_ubicacion_event.dart';
part 'mi_ubicacion_state.dart';

class MiUbicacionBloc extends Bloc<MiUbicacionEvent, MiUbicacionState> {
  MiUbicacionBloc() : super(MiUbicacionState());

 // BlocProvider.of<MapaPage>(context, AccesoGpsPage);

  //Geolocator
  //final _geolocator = new Geolocator();
  StreamSubscription<Geolocator.Position> _positionSubscription;
  

  void iniciarSeguimiento(){  

    Geolocator.Geolocator.getPositionStream()
        .listen((Geolocator.Position position) {
      print(position);
    });


  }
  void cancelarSeguimiento() {
    _positionSubscription?.cancel();
  }

  @override
  Stream<MiUbicacionState> mapEventToState(MiUbicacionEvent event,) async* {
    // implement mapEventToState
    if ( event is OnUbicacionCambio ) {
     yield state.copyWith(
       existeUbicacion: true,
       ubicacion: event.ubicacion
      );
    }
  }
}


//void iniciarSeguimiento() {
  //  Geolocator.Geolocator.getPositionStream()
    //    .listen((Geolocator.Position position) {
     // print(position);
    //(//)});
 // }






