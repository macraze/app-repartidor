import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:app_repartidor/src/data/environment.dart';
import 'package:app_repartidor/src/data/local/local_storage.dart';

class ApiService {
  static final String _api = Environment.urlApi;

  static Future post(String path, Object? body) async {
    final url = Uri.parse('$_api$path');
    String token = LocalStorage.token;
    try {
      log('POST $path');
      final resp = await http.post(url, body: body, headers: {
        'Content-Type': 'application/json',
        'Authorization': token
      });
      return resp;
    } catch (e) {
      throw Exception('Error post === $url === $e');
    }
  }

  static Future get(String path) async {
    final url = Uri.parse('$_api$path');
    String token = LocalStorage.token;
    try {
      log("GET $path");
      final resp = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': token
      });
      return resp;
    } catch (e) {
      throw Exception('Error get === $url === $e');
    }
  }

  static Future getNoAuth(String path) async {
    final url = Uri.parse('$_api$path');
    try {
      log('GET NO AUTH $path');
      final resp = await http.get(url, headers: {
        'Content-Type': 'application/json',
      });
      return resp;
    } catch (e) {
      throw Exception('Error getNoAuth === $url === $e');
    }
  }

  static Future getNoPath(String path) async {
    final url = Uri.parse(path);
    String token = LocalStorage.token;
    try {
      log("GET WHITHOUT API $path");
      final resp = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': token
      });
      return resp;
    } catch (e) {
      throw Exception('Error getNoPath === $url === $e');
    }
  }

  static Future put(String path, Object? body) async {
    final url = Uri.parse('$_api$path');
    String token = LocalStorage.token;
    try {
      log('PUT $path');
      final resp = await http.put(url, body: body, headers: {
        'Content-Type': 'application/json',
        'Authorization': token
      });
      return resp;
    } catch (e) {
      throw Exception('Error put === $url === $e');
    }
  }
}
