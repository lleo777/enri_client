part of 'widgets.dart';

class MarcadorManual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusquedaBloc, BusquedaState>(
      builder: (context, state) {
        if ( state.seleccionManual ) {
          return _BuildMarcadorManual();
        } else {
          return Container();
        }
        
      },
    );
  }



}

class _BuildMarcadorManual extends StatelessWidget {
  //const _BuildMarcadorManual({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Stack(
      // Boton regresar
      children: [
        Positioned(
          top: 70,
          left: 20,
          child: FadeInLeft(
            duration: Duration(milliseconds: 300),
            child: CircleAvatar(
              maxRadius: 25,
              backgroundColor: Colors.white,
              child: IconButton(
                icon: Icon( Icons.arrow_back, color: Colors.blue[700],),
              onPressed: () {
                BlocProvider.of<BusquedaBloc>(context).add(OnDesactivarMarcadorManual());

              }
              
              ),
              ),
          )
          ),

          Center(
            child: Transform.translate(
              offset: Offset(0, -12),
              child: BounceInDown(
                from: 200,
                child: Icon( Icons.location_on, size: 40, color: Colors.blue[800],)
                )
              ),
          ),

        Positioned(
          bottom: 70,
          left: 40,
          child: FadeIn(                     
            child: MaterialButton(
              minWidth: width -120,
              child: Text('Confirmar destino', style: TextStyle( color: Colors.white)),
              color: Colors.purple[700],
              shape: StadiumBorder(),
              elevation: 0,
              splashColor: Colors.transparent, 
              onPressed: (){
                // Confirmar destino
                this.calcularDestino(context);
                // Enviar localizacion a database
                // this.enviarCoordenadas(context);
              },
              ),
          )
          ),


      ],     

    );
  }
  void calcularDestino( BuildContext context) async {

    calculandoAlerta(context);

    final trafficService = new TrafficService();
    
    final inicio = BlocProvider.of<MiUbicacionBloc>(context).state.ubicacion;

    final mapaBloc = BlocProvider.of<MapaBloc>(context);

    final destino = BlocProvider.of<MapaBloc>(context).state.ubicacionCentral; 
    
    final trafficResponse = await trafficService.getCoordsInicioYDestino(inicio, destino);

    // Obtener informacion del destino
    final reverseQueryResponse = await trafficService.getCoordenadasInfo(destino);//infoWindows del lugar destino
  

    final geometry = trafficResponse.routes[0].geometry;
    final duracion = trafficResponse.routes[0].duration;
    final distancia = trafficResponse.routes[0].distance;
    final nombreDestino = reverseQueryResponse.features[0].text;
    //Decodificar los puntos del geometry
    
    final points = Poly.Polyline.Decode( encodedString: geometry, precision: 6).decodedCoords;

    final List<LatLng> rutaCoordenadas = points.map(
      (point) => LatLng(point[0], point[1])
    ).toList();
    
    mapaBloc.add( OnCrearRutaInicioDestino(
      rutaCoordenadas, distancia, duracion, nombreDestino
    ));

    Navigator.of(context).pop();
    BlocProvider.of<BusquedaBloc>(context).add( OnDesactivarMarcadorManual() );
    BlocProvider.of<BusquedaBloc>(context).add( OnActivarBtnSolicitud ());
  }

  
}
