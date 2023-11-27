import 'package:app_repartidor/src/presentation/routers/index.dart';
import 'package:app_repartidor/src/presentation/styles/styles.dart';
import 'package:flutter/material.dart';

import 'package:app_repartidor/src/presentation/widgets/widgets.dart';
import 'package:go_router/go_router.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static const String title =
      'Es necesario que otorgues los siguientes permisos';

  static const String permissionOrder =
      'Permiso para recibir notificaciones de pedidos.';
  static const String labelButtonOrder = 'Aceptar Notificación';

  static const String permissionGPS = 'Active su GPS o Ubicación.';
  static const String labelButtonGPS = 'Aceptar Geolocalización';

  static const String labelButton = 'Listo, Iniciar';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getBody(context),
    );
  }

  Widget _getBody(context) {
    Size size = MediaQuery.of(context).size;
    return ContainerWidget(
      width: size.width * 1,
      height: size.height * 1,
      decoration: const BoxDecoration(
        color: AppColors.backgroundGrey,
      ),
      child: SafeArea(
        child: Column(
          children: [
            ContainerWidget(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              width: size.width * 1,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: AppColors.textColorLight),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  const TextWidget(
                    text: title,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 30),
                  const TextWidget(
                    text: permissionOrder,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    maxLines: 3,
                  ),
                  ButtonWidget(
                    margin: const EdgeInsets.only(top: 5),
                    text: labelButtonOrder,
                    onPressed: () {},
                    color: AppColors.secondary,
                  ),
                  const SizedBox(height: 20),
                  const TextWidget(
                    text: permissionGPS,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    maxLines: 3,
                  ),
                  ButtonWidget(
                    margin: const EdgeInsets.only(top: 5),
                    text: labelButtonGPS,
                    onPressed: () {},
                    color: AppColors.secondary,
                  ),
                  ButtonWidget(
                    margin: const EdgeInsets.only(top: 30),
                    text: labelButton,
                    onPressed: () {
                      GoRouter.of(context).pushNamed(Routes.orderWait);
                    },
                    color: AppColors.primary,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
