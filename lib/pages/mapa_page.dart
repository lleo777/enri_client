import 'package:enri_client/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



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
    body: Center(
    child: BlocBuilder<MiUbicacionBloc, MiUbicacionState>(
      builder: (context, state){
        return Text('${state.ubicacion.latitude},${state.ubicacion.longitude}'
        );
      },
      )
    ),
  );
 }
}

