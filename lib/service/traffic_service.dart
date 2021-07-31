import 'dart:async';
import 'dart:convert';

import 'package:enri_client/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:enri_client/service/auth_service.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'package:dio/dio.dart';
import 'package:enri_client/global/environment.dart';
import 'package:enri_client/helpers/debouncer.dart';
import 'package:enri_client/models/registro_coordenadas.dart';
import 'package:enri_client/models/search_response.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;


import 'package:enri_client/models/reverse_query_response.dart';
import 'package:enri_client/models/traffic_response.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';


class TrafficService {

  // Singleton
 TrafficService._privateConstructor();
 static final TrafficService _instance = TrafficService._privateConstructor();
 factory TrafficService(){
   return _instance;
  }

  AuthService authService;

  final _dio = new Dio();
  final debouncer = Debouncer<String>(duration: Duration(milliseconds: 400 ));

  final StreamController<SearchResponse> _sugerenciasStreamController = new StreamController<SearchResponse>.broadcast();
  Stream<SearchResponse> get sugerenciasStream => this._sugerenciasStreamController.stream;



  final _baseUrlDir = 'https://api.mapbox.com/directions/v5';
  final _baseUrlGeo = 'https://api.mapbox.com/geocoding/v5';
  final _apiKey  = 'pk.eyJ1IjoibHVpc2xlb25pZGFzIiwiYSI6ImNrbnhhdnZ0eDBxYWsyb3M1cTgxOTJkcTkifQ.DKDZBA4J21IuY_06Mbw-9g';
  
 
 Future<DrivingResponse> getCoordsInicioYDestino( LatLng inicio, LatLng destino ) async {   
  
   final coordString = '${ inicio.longitude },${ inicio.latitude };${ destino.longitude },${ destino.latitude }';
   final url = '${ this._baseUrlDir }/mapbox/driving/$coordString'; 

   final resp = await this._dio.get( url, queryParameters: {
      'alternatives': 'true',
      'geometries': 'polyline6',
      'steps': 'false',
      'access_token': this._apiKey,
      'language': 'es',
    });

    final data = DrivingResponse.fromJson(resp.data);    
     
     return data;               
    
   
 }

 Future<RegistroCoordenadas> sendCoordenadasInicioYDestino(BuildContext context  ) async {   

   final coordinates = BlocProvider.of<MiUbicacionBloc>(context).state.ubicacion;
   

   this.authService = Provider.of<AuthService>(context, listen: false); 
   //final coordinates = '${ inicio.latitude },${ inicio.longitude };${ destino.latitude },${ destino.longitude }';
     

   final data = {
     
    'location': this.authService.usuario.uid,      
    'coordinates': coordinates,
   }; 

   final resp = await http.post('${ Environment.apiUrl }/locations/send', 
      body: jsonEncode(data),
      headers: { 'Content-Type': 'application/json', 'Charset': 'utf-8' },
      
      ); 
     

    if ( resp.statusCode == 200 ) {      
    final rutaCoordenadas = registroCoordenadasFromJson( resp.body );
    //this.coordinates = registroCoordenadas.coordinates;
    print(rutaCoordenadas);
    return rutaCoordenadas;   
    
                 
    } else {

      final respBody = jsonDecode(resp.body);
      return respBody['Registro Incorrecto'];

    } 


  }


   Future<SearchResponse> getResultadosPorQuery( String busqueda, LatLng proximidad ) async {

    print('Buscando!!!!!');

    final url = '${ this._baseUrlGeo }/mapbox.places/$busqueda.json';

    try {
        final resp = await this._dio.get(url, queryParameters: {
          'access_token': this._apiKey,
          'autocomplete': 'true',
          'proximity'   : '${ proximidad.longitude },${ proximidad.latitude }',
          'language'    : 'es',
        });

        final searchResponse = searchResponseFromJson( resp.data );

        return searchResponse;

    } catch (e) {
      return SearchResponse( features: [] );
    }

  
  } 

   void getSugerenciasPorQuery( String busqueda, LatLng proximidad ) {

    debouncer.value = '';
    debouncer.onValue = ( value ) async {
      final resultados = await this.getResultadosPorQuery(value, proximidad);
      this._sugerenciasStreamController.add(resultados);
    };

    final timer = Timer.periodic(Duration(milliseconds: 200), (_) {
      debouncer.value = busqueda;
    });

    Future.delayed(Duration(milliseconds: 201)).then((_) => timer.cancel()); 

  } 

   Future<ReverseQueryResponse> getCoordenadasInfo( LatLng destinoCoords ) async {

    final url = '${ this._baseUrlGeo }/mapbox.places/${ destinoCoords.longitude },${ destinoCoords.latitude }.json';

    final resp = await this._dio.get( url, queryParameters: {
      'access_token': this._apiKey,
      'language': 'es',
    });

    final data = reverseQueryResponseFromJson( resp.data );

    return data;


  }

  

}

