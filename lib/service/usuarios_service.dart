
import 'package:http/http.dart' as http;


import 'package:enri_client/models/usuario.dart';
import 'package:enri_client/models/usuarios_response.dart';

import 'package:enri_client/service/auth_service.dart';
import 'package:enri_client/global/environment.dart';


class UsuariosService {

  Future<List<Usuario>> getUsuarios() async {

    try {
      
      final resp = await http.get('${ Environment.apiUrl }/usuarios',
        headers: {
          'Content-Type': 'application/json',
          'x-token': await AuthService.getToken()
        }
      );

      final usuariosResponse = usuariosResponseFromJson( resp.body );

      return usuariosResponse.usuarios;

    } catch (e) {
      return [];
    }

  }


}