import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import 'package:app_repartidor/src/domain/models/models.dart';
import 'package:app_repartidor/src/presentation/routers/index.dart';
import 'package:app_repartidor/src/presentation/styles/styles.dart';
import 'package:app_repartidor/src/presentation/widgets/widgets.dart';
import 'package:app_repartidor/src/presentation/providers/providers.dart';
import 'package:app_repartidor/src/presentation/common/utils/snackbars.dart';
import 'package:app_repartidor/src/presentation/common/helpers/helpers.dart';

class ListOrdersAcceptedDeliveryLocalPage extends StatefulWidget {
  const ListOrdersAcceptedDeliveryLocalPage({super.key});

  @override
  State<ListOrdersAcceptedDeliveryLocalPage> createState() =>
      _ListOrdersAcceptedDeliveryLocalPageState();
}

class _ListOrdersAcceptedDeliveryLocalPageState
    extends State<ListOrdersAcceptedDeliveryLocalPage> {
  void initFunctions() async {
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);
    final socketProvider = Provider.of<SocketProvider>(context, listen: false);
    final list = orderProvider.selectedOrdersAssignedLocal.join(',');

    final newList =
        await orderProvider.getListOrdersAcceptedByIdsProvider(ids: list);

    if (orderProvider.errorListOrdersPendingDeliveryLocal.isNotEmpty) {
      Snackbars.showSnackbarError(orderProvider.errorListOrdersAcceptedByIds);
    } else {
      socketProvider.cocinarLisPedidosNotificar(listOrders: newList);
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => initFunctions());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getBody(context),
    );
  }

  Widget _getBody(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ContainerWidget(
      height: size.height * 1,
      decoration: const BoxDecoration(color: AppColors.backgroundGrey),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const AppbarWidget(),
            _buildBodyContainer(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBodyContainer(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);

    double totalProductos =
        calculateTotalProductos(orderProvider.listOrdersAcceptedByIds);
    double costoDelivery =
        calculateCostoDelivery(orderProvider.listOrdersAcceptedByIds);

    if (orderProvider.isLoadingListOrdersAcceptedByIds) {
      return const Center(
          child: CircularIndicatorWidget(color: AppColors.primary));
    }

    return ContainerWidget(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const TextWidget(
                  text: 'Lista de Pedidos', color: Colors.black, fontSize: 16),
              ButtonWidget(
                padding: const EdgeInsets.all(8),
                text: 'Asignarse Pedido',
                style: CustomTextStyles.fontLabel(
                    fontSize: 13, fontWeight: FontWeight.bold),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                color: Colors.black,
              )
            ],
          ),
          const Divider(),
          ContainerWidget(
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: orderProvider.listOrdersAcceptedByIds.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final order = orderProvider.listOrdersAcceptedByIds[index];
                return OrderItemWidget(order: order);
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
            ),
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      const TextWidget(
                        text: 'Total Productos: ',
                        color: Colors.black,
                        fontSize: 13,
                      ),
                      TextWidget(
                        text: ' ${totalProductos.toStringAsFixed(2)}',
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const TextWidget(
                        text: 'Costo Delivery: ',
                        color: Colors.black,
                        fontSize: 13,
                      ),
                      TextWidget(
                        text: ' ${costoDelivery.toStringAsFixed(2)}',
                        color: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  static double calculateTotalProductos(List<Order> orders) {
    return orders
        .map((order) => order.totalPagaRepartidor ?? 0.0)
        .fold(0.0, (acc, total) => acc + total);
  }

  static double calculateCostoDelivery(List<Order> orders) {
    return orders
        .map((order) => order.costoDelivery ?? 0.0)
        .fold(0.0, (acc, costo) => acc + costo);
  }
}

class OrderItemWidget extends StatelessWidget {
  const OrderItemWidget({
    super.key,
    required this.order,
  });

  final Order order;

  @override
  Widget build(BuildContext context) {
    final delivery = order.jsonDatosDelivery!.isNotEmpty
        ? jsonOneDatosDeliveryFromJson(order.jsonDatosDelivery!)
        : JsonDatosDelivery();

    final time = OrderHelper.calculateTimePedido(order.fechaHora.toString());

    return CupertinoButton(
      onPressed: () {
        handleGoToDetailOrder(context);
      },
      minSize: 0,
      padding: EdgeInsets.zero,
      child: ContainerWidget(
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: getOrderDecoration(order.pwaEstado),
        child: Row(
          children: [
            _buildBadgeSection(),
            _buildOrdersDetail(delivery, time),
            _buildPaymentDetail(delivery)
          ],
        ),
      ),
    );
  }

  void handleGoToDetailOrder(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);
    orderProvider.orderDetailSelected = order;
    GoRouter.of(context).pushNamed(Routes.orderDetail);
  }

  ContainerWidget _buildBadgeSection() {
    return ContainerWidget(
      child: Column(
        children: [
          if (order.flagIsCliente == 1)
            _buildBadge(text: 'APP', color: Colors.green)
          else
            _buildBadge(text: 'No App', color: Colors.red),
          if (order.pwaEstado == 'E')
            _buildBadge(
              text: 'Entregado',
              color: Colors.green,
              margin: EdgeInsets.zero,
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              fontSize: 10,
            ),
        ],
      ),
    );
  }

  Widget _buildBadge(
      {required String text,
      required Color color,
      EdgeInsetsGeometry? margin,
      EdgeInsetsGeometry? padding,
      double? fontSize}) {
    return ContainerWidget(
      margin: margin ?? const EdgeInsets.only(bottom: 5),
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: color.withOpacity(0.1),
        border: Border.all(color: color),
      ),
      child: TextWidget(
        text: text,
        color: color,
        fontSize: fontSize ?? 11,
      ),
    );
  }

  BoxDecoration? getOrderDecoration(String? pwaEstado) {
    return (pwaEstado == 'E')
        ? const BoxDecoration(color: Color(0xfff5fff5))
        : null;
  }

  Expanded _buildOrdersDetail(
      JsonDatosDelivery delivery, Map<String, dynamic> time) {
    bool cameToTheStore = order.timeLine?.llegoAlComercio ?? false;
    bool isOnTheWay = order.timeLine?.enCaminoAlCliente ?? false;

    return Expanded(
      child: ContainerWidget(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
              text: '${delivery.pHeader?.arrDatosDelivery?.nombres}',
              color: Colors.black,
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 3),
            TextWidget(
              text:
                  '${delivery.pHeader?.arrDatosDelivery?.establecimiento?.nombre}',
              color: Colors.black,
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 3),
            TextWidget(
              text: '${time['horaString']}',
              color: time['minutos'] < 20 ? Colors.green : Colors.red,
              textAlign: TextAlign.start,
            ),
            if (cameToTheStore && !isOnTheWay)
              const TextWidget(text: '✅ Llego', color: Colors.green),
            if (isOnTheWay)
              const TextWidget(text: '🛵 En Camino', color: Colors.green),
          ],
        ),
      ),
    );
  }

  ContainerWidget _buildPaymentDetail(JsonDatosDelivery delivery) {
    // var total = int.parse(order.total ?? '0').toStringAsFixed(2);

    return ContainerWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ContainerWidget(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: BoxDecoration(
                color: Colors.black12,
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(5)),
            child: TextWidget(
              text:
                  '${delivery.pHeader?.arrDatosDelivery?.metodoPago?.descripcion}',
              color: Colors.black,
              fontSize: 9,
            ),
          ),
          const SizedBox(height: 5),
          TextWidget(
            text: '${order.totalPagaRepartidor?.toStringAsFixed(2)}',
            color: Colors.black,
            textAlign: TextAlign.end,
            fontSize: 16,
          ),
        ],
      ),
    );
  }
}
