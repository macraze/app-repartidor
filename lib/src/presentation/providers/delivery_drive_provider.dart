import 'package:app_repartidor/src/domain/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeliveryDriver {
  static final DeliveryDriver _instance = DeliveryDriver._internal();
  User? _userData;

  factory DeliveryDriver() {
    return _instance;
  }

  DeliveryDriver._internal() {
    _loadUserData();
  }

  User? get userData => _userData;

  bool get isLoggedIn => _userData != null;

  void login(User userData) {
    _userData = userData;
    _saveUserData(userToJson(userData));
  }

  void logout() {
    _userData = null;
    _clearUserData();
  }

  void sumarPedidosAsignados() {
    // Aquí actualizas los pedidos asignados del usuario y guardas los cambios
    _userData?.pedidosAsignados = (_userData?.pedidosAsignados ?? 0) + 1;
    _saveUserData(userToJson(_userData!));
  }

  void resetPedidosAsignados() {
    // Aquí restableces los pedidos asignados del usuario y guardas los cambios
    _userData?.pedidosAsignados = 0;
    _saveUserData(userToJson(_userData!));
  }

  bool isRepartidorPropio() {
    return _userData?.idsedeSuscrito != null;
  }

  void _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    String? userStr = prefs.getString('user');
    if (userStr != null) {
      _userData = userFromJson(userStr);
    }
  }

  void _saveUserData(String userStr) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user', userStr);
  }

  void _clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('user');
  }
}
