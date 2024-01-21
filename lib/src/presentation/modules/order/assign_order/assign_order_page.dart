import 'package:app_repartidor/src/presentation/modules/order/order_page.dart';
import 'package:app_repartidor/src/presentation/providers/providers.dart';
import 'package:app_repartidor/src/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AssignOrderPage extends StatelessWidget {
  const AssignOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isRepartidorPropio = UserProvider().isRepartidorPropio;

    // return Scaffold(
    //   body: ContainerWidget(
    //       child: SafeArea(
    //     child: Column(
    //       children: [
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             ButtonWidget(
    //               text: 'Asignarse pedido',
    //               onPressed: () {},
    //               margin: const EdgeInsets.only(right: 20),
    //             ),
    //             ButtonWidget(
    //               text: 'Cancelar',
    //               onPressed: () {},
    //               margin: const EdgeInsets.only(),
    //             )
    //           ],
    //         )
    //       ],
    //     ),
    //   )),
    // );
    if (!isRepartidorPropio) {
      return AssignOrderByCodePage();
    }

    return ListOrdersPendingDeliveryLocalPage();
  }
}
