part of 'widgets.dart';

class SolicitudConductor extends StatelessWidget {
  
@override
  Widget build(BuildContext context) {
    return BlocBuilder<BusquedaBloc, BusquedaState>(
      builder: (context, state) {
        if ( state.seleccionConductor ) {
          return _SolicitudConductor();
        } else {
          return Container();
        }
        
      },
    );
  }

}
class _SolicitudConductor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Stack(
      // Boton regresar
      children: [
        Positioned(
          top: 124,
          left: 20,
          child: FadeInLeft(
            duration: Duration(milliseconds: 300),
            child: CircleAvatar(
              maxRadius: 25,
              backgroundColor: Colors.white,
              child: IconButton(
                icon: Icon( Icons.arrow_back, color: Colors.blue[700],),
              onPressed: () {
                
                BlocProvider.of<BusquedaBloc>(context).add(OnDesactivarBtnSolicitud ());
                BlocProvider.of<BusquedaBloc>(context).add(OnDesactivarMarcadorManual());
              }
              
              ),
              ),
          )
          ),

          
        Positioned(
          bottom: 70,
          left: 40,
          child: FadeIn(                     
            child: MaterialButton(
              minWidth: width -120,
              child: Text('Solicitar Conductor', style: TextStyle( color: Colors.white)),
              color: Colors.purple[700],
              shape: StadiumBorder(),
              elevation: 0,
              splashColor: Colors.transparent, 
              onPressed: () {
                
                 // Enviar localizacion a database
                 this.enviarCoordenadas(context);
              },
              ),
          )
          ),


      ],     

    );
  }
  
  

  void enviarCoordenadas(BuildContext context) async {

    calculandoOrder(context);

    final trafficService = new TrafficService();

    //final inicio = BlocProvider.of<MiUbicacionBloc>(context).state.ubicacion;
    //final destino = BlocProvider.of<MapaBloc>(context).state.ubicacionCentral; 

   await trafficService.sendCoordenadasInicioYDestino(context);

   Navigator.of(context).pop();
   BlocProvider.of<BusquedaBloc>(context).add( OnDesactivarMarcadorManual() ); 
  }
 // final registroOk = await trafficService.sendCoordenadasInicioYDestino(inicio, destino);
}