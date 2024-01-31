import 'package:app_repartidor/src/presentation/modules/order/pages.dart';
import 'package:app_repartidor/src/presentation/providers/providers.dart';
import 'package:flutter/material.dart';

class AssignOrderPage extends StatelessWidget {
  const AssignOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isRepartidorPropio = UserProvider().isRepartidorPropio;

    if (!isRepartidorPropio) {
      return AssignOrderByCodePage();
    }

    return const ListOrdersPendingDeliveryLocalPage();
  }
}
