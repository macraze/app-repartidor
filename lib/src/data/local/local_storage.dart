import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static late SharedPreferences _prefs;

  static String _token = '';
  static String _user = '';
  static bool _online = true;
  static String _pedidosAceptados = '';

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String get token {
    return _prefs.getString('token') ?? _token;
  }

  static set token(String token) {
    _token = token;
    _prefs.setString('token', token);
  }

  static void removeToken() {
    _token = '';
    _prefs.remove('token');
  }

  static String get user {
    return _prefs.getString('user') ?? _user;
  }

  static set user(String user) {
    _user = user;
    _prefs.setString('user', user);
  }

  static void removeUser() {
    _user = '';
    _prefs.remove('user');
  }

  static bool get online {
    return _prefs.getBool('online') ?? _online;
  }

  static set online(bool value) {
    _online = value;
    _prefs.setBool('online', value);
  }

  static String get pedidosAceptados {
    return _prefs.getString('pedidos-aceptados') ?? _pedidosAceptados;
  }

  static set pedidosAceptados(String value) {
    _pedidosAceptados = value;
    _prefs.setString('pedidos-aceptados', value);
  }
}
