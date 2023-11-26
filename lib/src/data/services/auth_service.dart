import 'dart:convert';

import 'package:app_repartidor/src/data/api.dart';
import 'package:app_repartidor/src/data/environment.dart';
import 'package:app_repartidor/src/data/local/local_storage.dart';

class AuthService {
  final String api = Environment.urlApi;

  Future<String?> login(String username, String password) async {
    final Map<String, dynamic> authData = {
      'nomusuario': username,
      'pass': password
    };

    try {
      final response = await Api.post(
          '/login-usuario-autorizado-repartidor', jsonEncode(authData));
      final Map<String, dynamic> decodedResp = json.decode(response.body);
      if (decodedResp.containsKey('token')) {
        LocalStorage.token = decodedResp['token'];
        LocalStorage.user = json.encode(decodedResp['user']);
        return null;
      } else if (decodedResp.containsKey('data')) {
        return decodedResp['data'];
      } else if (decodedResp.containsKey('error')) {
        return decodedResp['error'];
      } else {
        return 'Error desconocido';
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> getUserByToken() async {
    try {
      final response = await Api.get('/validar-token');
      final Map<String, dynamic> decodedResp = json.decode(response.body);
      if (decodedResp.containsKey('token')) {
        LocalStorage.token = decodedResp['token'];
        return null;
      } else {
        return decodedResp['error'];
      }
    } catch (e) {
      return e.toString();
    }
  }
}
