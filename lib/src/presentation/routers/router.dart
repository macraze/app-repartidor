import 'package:app_repartidor/src/presentation/routers/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_repartidor/main.dart';
import 'package:go_router/go_router.dart';

import 'package:app_repartidor/src/presentation/modules/auth/auth_page.dart';
import 'package:app_repartidor/src/presentation/modules/home/home_page.dart';
import 'package:app_repartidor/src/presentation/providers/providers.dart';
import 'package:app_repartidor/src/presentation/modules/order/order_page.dart';

mixin RouterMixin on State<MyApp> {
  final rootNavigatorKey = GlobalKey<NavigatorState>();
  // final _shellNavigatorKey = GlobalKey<NavigatorState>();

  GoRouter? _router;

  GoRouter? get router {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    if (_router != null) return _router!;

    _router = GoRouter(
        refreshListenable: authProvider,
        initialLocation: '/splash',
        navigatorKey: rootNavigatorKey,
        errorBuilder: (context, state) {
          return const ErrorPage();
        },
        routes: [
          GoRoute(
            path: '/splash',
            name: Routes.splash,
            builder: (context, state) => const SplashPage(),
          ),
          GoRoute(
            path: '/login',
            name: Routes.login,
            builder: (context, state) => LoginPage(),
          ),
          GoRoute(
            path: '/',
            builder: (context, state) => const SettingsPage(),
          ),
          GoRoute(
            path: '/orderWait',
            name: Routes.orderWait,
            builder: (context, state) => OrderWaitPage(),
          ),
        ],
        redirect: (context, state) {
          final authProvider =
              Provider.of<AuthProvider>(context, listen: false);

          final isGointTo = state.subloc;
          final authStatus = authProvider.authStatus;

          if (isGointTo == '/splash' && authStatus == AuthStatus.checking) {
            return null;
          }

          if (authStatus == AuthStatus.notAuthenticated) {
            if (isGointTo == '/login' || isGointTo == '/register') return null;
            return '/login';
          }

          if (authStatus == AuthStatus.authenticated) {
            if (isGointTo == '/login' ||
                isGointTo == '/register' ||
                isGointTo == '/splash') return '/';
          }

          return null;
        });

    return _router!;
  }
}
