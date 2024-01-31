import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app_repartidor/src/domain/models/models.dart';
import 'package:app_repartidor/src/presentation/widgets/widgets.dart';
import 'package:app_repartidor/src/presentation/providers/providers.dart';
import 'package:app_repartidor/src/presentation/providers/order_provider.dart';

class OrderPendingPage extends StatefulWidget {
  const OrderPendingPage({super.key});

  @override
  State<OrderPendingPage> createState() => _OrderPendingPageState();
}

class _OrderPendingPageState extends State<OrderPendingPage> {
  void initFunctions() {
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);
    final orderPendingProvider =
        Provider.of<OrderPendingProvider>(context, listen: false);

    final orderPending = orderProvider.orderPending;

    if (orderPending != null) {
      orderPendingProvider.initPage(order: orderPending);
      orderProvider.existOrderPending =
          orderPending.pedidoPorAceptar?.pedidos?.isNotEmpty ?? false;
    }
  }

  @override
  void initState() {
    initFunctions();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orderPendingProvider = Provider.of<OrderPendingProvider>(context);
    final orderTempProvider = Provider.of<OrderProvider>(context);
    final orderProvider = Provider.of<OrderProvider>(context).orderPending;

    if (!orderTempProvider.existOrderPending) {
      return const ContainerWidget();
    }

    return SafeArea(
      child: CardWidget(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const TextWidget(
              text: 'Pedido por Aceptar 🎉',
              color: Colors.black,
              fontSize: 15,
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    TextWidget(
                        text:
                            '🎁 ${orderProvider?.pedidoPorAceptar?.pedidos?.length}',
                        color: Colors.black,
                        fontSize: 20),
                    const TextWidget(text: 'Pedidos', color: Colors.black),
                  ],
                ),
                const SizedBox(width: 20),
                Column(
                  children: [
                    TextWidget(
                        text:
                            '💵 ${orderProvider?.pedidoPorAceptar?.importePagar}',
                        color: Colors.black,
                        fontSize: 20),
                    const TextWidget(text: 'Importe', color: Colors.black),
                  ],
                )
              ],
            ),
            const Divider(),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: AnimatedBuilder(
                  animation: orderPendingProvider,
                  builder: (context, _) {
                    return LinearProgressIndicator(
                      value: orderPendingProvider.progress,
                      minHeight: 10,
                      backgroundColor: Colors.grey[200],
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(Colors.blue),
                    );
                  }),
            ),
            const SizedBox(height: 10),
            const TextWidget(
                text: 'Tiene un minuto para aceptar', color: Colors.black),
            ButtonWidget(
                text: 'Aceptar',
                onPressed: () {
                  acceptOrder(orderProvider);
                },
                margin: const EdgeInsets.only(top: 20))
          ],
        ),
      ),
    );
  }

  void acceptOrder(OrdersToAccept? orderPending) async {
    final listOrders = orderPending?.pedidoPorAceptar?.pedidos ?? [];

    final orderPendingProvider =
        Provider.of<OrderPendingProvider>(context, listen: false);

    final orderTempProvider =
        Provider.of<OrderProvider>(context, listen: false);

    final orderHeaderProvider = Provider.of<OrderHeaderProvider>(context, listen: false);

    final ids = orderPendingProvider.getIdsPedidosNoLocalStorage(listOrders);

    if (ids.isEmpty) {
      orderTempProvider.orderPending = null;
      await orderPendingProvider.setNullPedidosPorAceptar();
      orderTempProvider.existOrderPending =
          false; // TODO: descomentar //TODO: Retroceder
      return;
    }

    final listIds = ids.join(',');

    await orderHeaderProvider.acceptListOrdersByIdsProvider(ids: listIds);

    await orderHeaderProvider.getListOrdersAcceptedByIdsProvider(ids: listIds);

    //TODO: Falta 1 funcion que junta los ids

    // orderTempProvider.isShowOrderPending = false; // TODO: descomentar

    //TODO: Enviar a la lista de pedidos
    orderTempProvider.orderPending = null;
  }
}
