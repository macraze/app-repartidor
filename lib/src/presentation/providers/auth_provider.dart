import 'package:flutter/material.dart';

import 'package:app_repartidor/src/data/services/services.dart';
import 'package:app_repartidor/src/data/local/local_storage.dart';

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthProvider extends ChangeNotifier {
  AuthProvider() {
    verifyToken();
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  AuthStatus _authStatus = AuthStatus.checking;
  AuthStatus get authStatus => _authStatus;
  set authStatus(AuthStatus value) {
    _authStatus = value;
    notifyListeners();
  }

  String username = '';
  String password = '';
  bool obscureText = true;

  bool _isLoadingLogin = false;
  bool get isLoadingLogin => _isLoadingLogin;
  set isLoadingLogin(bool value) {
    _isLoadingLogin = value;
    notifyListeners();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }

  void getObscureText() {
    obscureText == true ? obscureText = false : obscureText = true;
    notifyListeners();
  }

  Future<String?> login(String username, String password) async {
    isLoadingLogin = true;
    AuthService service = AuthService();
    try {
      final resp = await service.login(username, password);
      if (resp != null) {
        authStatus = AuthStatus.notAuthenticated;
        return 'Hubo un inconveniente en el inicio de sesión, inténtelo de nuevo o más tarde por favor: $resp';
      } else {
        authStatus = AuthStatus.authenticated;
        return null;
      }
    } catch (e) {
      authStatus = AuthStatus.notAuthenticated;
      return e.toString();
    } finally {
      isLoadingLogin = false;
      notifyListeners();
    }
  }

  Future verifyToken() async {
    final String token = LocalStorage.token;
    if (token.isEmpty) {
      return logout();
    }

    AuthService service = AuthService();
    try {
      final response = await service.getUserByToken();
      if (response != null) {
        return logout();
      } else {
        authStatus = AuthStatus.authenticated;
        return null;
      }
    } catch (e) {
      return logout();
    }
  }

  void logout() {
    authStatus = AuthStatus.notAuthenticated;
    LocalStorage.removeToken();
    notifyListeners();
  }
}
