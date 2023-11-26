import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_repartidor/main.dart';
import 'package:go_router/go_router.dart';

import 'package:app_repartidor/src/presentation/pages/auth/auth_page.dart';
import 'package:app_repartidor/src/presentation/pages/home/home_page.dart';
import 'package:app_repartidor/src/presentation/providers/providers.dart';

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
            builder: (context, state) => const SplashPage(),
          ),
          GoRoute(
            path: '/login',
            builder: (context, state) => LoginPage(),
          ),
          GoRoute(
            path: '/',
            builder: (context, state) => const SettingsPage(),
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
