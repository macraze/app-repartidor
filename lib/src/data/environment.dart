import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static initEnvironment() async {
    await dotenv.load(fileName: '.env');
  }

  static String urlApi = dotenv.env['URL_API'] ?? '';
  static String urlServerSocket = dotenv.env['URL_SERVER_SOCKET'] ?? '';
}
