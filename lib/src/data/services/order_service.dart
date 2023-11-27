import 'dart:convert';

import 'package:app_repartidor/src/data/api.dart';

class OrderService {
  Future<String?> postConnectOrder(
      {required int idRepartidor,
      required int mount,
      required int isOnline}) async {
    final Map<String, dynamic> body = {
      'idrepartidor': idRepartidor,
      'efectivo': mount,
      'online': isOnline
    };

    try {
      final response =
          await Api.post('/repartidor/set-efectivo-mano', jsonEncode(body));
      final Map<String, dynamic> decodedResp = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return null;
      } else {
        return decodedResp['message'];
      }
    } catch (e) {
      return e.toString();
    }
  }
}
