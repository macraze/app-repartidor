import 'package:app_repartidor/src/data/environment.dart';
import 'package:app_repartidor/src/data/local/local_storage.dart';
import 'package:app_repartidor/src/presentation/common/utils/snackbars.dart';
import 'package:app_repartidor/src/presentation/providers/providers.dart';
import 'package:app_repartidor/src/presentation/routers/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Environment.initEnvironment();
  await LocalStorage.init();
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<SingleChildWidget> providers = [
      ChangeNotifierProvider(create: (_) => AuthProvider()),
      ChangeNotifierProvider(create: (_) => OrderProvider()),
      ChangeNotifierProvider(create: (_) => SocketProvider(), lazy: false),
    ];

    return MultiProvider(
      providers: providers,
      child: const MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with RouterMixin {
  @override
  Widget build(BuildContext context) {
    // final socket = Provider.of<SocketProvider>(context);

    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      title: 'Repartidor App',
      scaffoldMessengerKey: Snackbars.messengerKey,
    );
  }
}
