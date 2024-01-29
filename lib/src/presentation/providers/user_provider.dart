import 'package:flutter/material.dart';
import 'package:app_repartidor/src/domain/models/models.dart';
import 'package:app_repartidor/src/data/local/local_storage.dart';

class UserProvider extends ChangeNotifier {
  // Patron Singleton: Mantiene una única instancia de la clase en toda la aplicación.
  static UserProvider? _instance;

  // Variable privada para almacenar los datos del usuario.
  late User _user;

  // Constructor privado para el patrón Singleton.
  UserProvider._internal() {
    _loadUser(); // Carga los datos del usuario cuando se crea la instancia.
  }

  // Fábrica para obtener la instancia del Singleton.
  factory UserProvider() {
    _instance ??= UserProvider._internal();
    return _instance!;
  }

  // Método privado para cargar los datos del usuario desde el almacenamiento local.
  Future<void> _loadUser() async {
    final userJson =
        LocalStorage.user; // Obtiene los datos del usuario en formato JSON.
    if (userJson.isNotEmpty) {
      _user = userFromJson(userJson); // Convierte JSON a objeto User.
      notifyListeners(); // Notifica a los oyentes que los datos del usuario han cambiado.
    }
  }

  // Getter para obtener los datos del usuario.
  User get user => _user;

  // Método para establecer los datos del usuario y guardarlos en el almacenamiento local.
  set user(User user) {
    _user = user; // Establece los datos del usuario.
    LocalStorage.user = userToJson(
        user); // Guarda los datos del usuario en formato JSON en el almacenamiento local.
    notifyListeners(); // Notifica a los oyentes que los datos del usuario han cambiado.
  }

  // Método para incrementar en 1 los pedidos asignados del usuario.
  void incrementarPedidosAsignados() {
    if (_user.pedidosAsignados != null) {
      // Incrementa en 1 el valor de pedidosAsignados.
      _user.pedidosAsignados = _user.pedidosAsignados! + 1;
    } else {
      // Si es null, inicializa a 1.
      _user.pedidosAsignados = 1;
    }
    LocalStorage.user =
        userToJson(_user); // Actualiza el usuario en el almacenamiento local.
    notifyListeners(); // Notifica a los oyentes que los datos del usuario han cambiado.
  }

  // Método para verificar si el usuario es un repartidor propio (de acuerdo a su id de sede suscrito).
  bool get isRepartidorPropio => _user.idsedeSuscrito == null ? false : true;
}
