import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import 'package:app_repartidor/src/domain/models/models.dart';
import 'package:app_repartidor/src/presentation/styles/styles.dart';
import 'package:app_repartidor/src/presentation/routers/index.dart';
import 'package:app_repartidor/src/presentation/widgets/widgets.dart';
import 'package:app_repartidor/src/presentation/providers/providers.dart';
import 'package:app_repartidor/src/presentation/common/helpers/helpers.dart';
import 'package:app_repartidor/src/presentation/common/utils/snackbars.dart';
import 'package:app_repartidor/src/presentation/common/constants/constants.dart';

class ListOrdersPendingDeliveryLocalPage extends StatefulWidget {
  const ListOrdersPendingDeliveryLocalPage({super.key});

  @override
  State<ListOrdersPendingDeliveryLocalPage> createState() =>
      _ListOrdersPendingDeliveryLocalPageState();
}

class _ListOrdersPendingDeliveryLocalPageState
    extends State<ListOrdersPendingDeliveryLocalPage> {
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
            Image.asset(
              IconConstant.logoHappyMusic,
              width: size.width * 0.8,
            ),
            _buildBodyContainer(context)
          ],
        ),
      ),
    );
  }

  Widget _buildBodyContainer(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);

    if (!orderProvider.showListOrdersPendingDeliveryLocal) {
      return ButtonWidget(
        text: 'Asignarse pedido',
        onPressed: () async {
          final orderProvider =
              Provider.of<OrderProvider>(context, listen: false);

          await orderProvider.getListOrdersPendingDeliveryLocalProvider();

          if (orderProvider.errorListOrdersPendingDeliveryLocal.isNotEmpty) {
            Snackbars.showSnackbarError(
                orderProvider.errorListOrdersPendingDeliveryLocal);
          } else {
            orderProvider.toggleVisibilityListOrdersPendingDeliveryLocal();
          }
        },
        margin: const EdgeInsets.only(top: 20),
        disabled: orderProvider.isLoadingListOrdersPendingDeliveryLocal,
        colorDisabled: AppColors.secondary,
        loading: orderProvider.isLoadingListOrdersPendingDeliveryLocal,
      );
    }

    return Column(
      children: [
        const SizedBox(height: 20),
        TextWidget(
          text:
              'Pedidos pendientes de entrega (${orderProvider.listOrdersPendingDeliveryLocal.length})',
          color: Colors.black,
          fontSize: 17,
        ),
        ContainerWidget(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), // Color de la sombra
                spreadRadius: 2, // Extensión de la sombra
                blurRadius: 5, // Difuminado de la sombra
                offset: const Offset(
                    0, 3), // Desplazamiento de la sombra en dirección y
              ),
            ],
          ),
          child: Column(
            children: [
              _buildListOrders(context),
              const Divider(height: 50),
              _buildButtonsActionsOrders(context)
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildListOrders(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);

    if (orderProvider.listOrdersPendingDeliveryLocal.isEmpty) {
      return const ContainerWidget(
        child: TextWidget(
          text: 'Aquí aparecerán los pedidos pendientes de entrega',
          fontWeight: FontWeight.w400,
          fontSize: 13,
          color: Colors.black,
          maxLines: 3,
        ),
      );
    }

    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(height: 20),
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: orderProvider.listOrdersPendingDeliveryLocal.length,
      itemBuilder: (context, index) {
        final order = orderProvider.listOrdersPendingDeliveryLocal[index];
        return ItemOrderWidget(order: order);
      },
    );
  }

  Row _buildButtonsActionsOrders(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (orderProvider.listOrdersPendingDeliveryLocal.isNotEmpty)
          ButtonWidget(
            text: 'Listo!',
            color: AppColors.primary,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            style: CustomTextStyles.fontLabel(
                fontSize: 15, fontWeight: FontWeight.bold),
            loading: orderProvider.isLoadingAcceptListOrdersByIds,
            disabled: orderProvider.isLoadingAcceptListOrdersByIds,
            colorDisabled: AppColors.primary,
            onPressed: () => _handleAcceptOrders(context),
          ),
        const SizedBox(width: 10),
        ButtonWidget(
          text: 'Atras',
          color: AppColors.textColor,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          style: CustomTextStyles.fontLabel(
              fontSize: 15, fontWeight: FontWeight.bold),
          onPressed: () {
            orderProvider.toggleVisibilityListOrdersPendingDeliveryLocal();
          },
        ),
      ],
    );
  }

  void _handleAcceptOrders(BuildContext context) async {
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);

    if (orderProvider.selectedOrdersAssignedLocal.isEmpty) {
      return;
    }

    final list = orderProvider.selectedOrdersAssignedLocal.join(',');

    final response =
        await orderProvider.acceptListOrdersByIdsProvider(ids: list);

    if (!mounted) return;

    if (response != null) {
      Snackbars.showSnackbarError(response);
    } else {
      Snackbars.showSnackbarSuccess('Los pedidos han sido enviado con éxito!');
      GoRouter.of(context).pushNamed(Routes.ordersAccepted);
      // log(list);
    }
  }
}

class ItemOrderWidget extends StatelessWidget {
  const ItemOrderWidget({
    super.key,
    required this.order,
  });

  final Order order;

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);

    final delivery = jsonOneDatosDeliveryFromJson(order.jsonDatosDelivery!);

    final time = OrderHelper.calculateTimePedido(order.fechaHora.toString());

    final isSelected = orderProvider.selectedOrdersAssignedLocal
        .contains(order.idpedido.toString());

    return ContainerWidget(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ContainerWidget(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: '${delivery.pHeader?.arrDatosDelivery?.nombres}',
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 3),
                  TextWidget(
                    text: '${delivery.pHeader?.arrDatosDelivery?.direccion}',
                    color: AppColors.textColorLight,
                    maxLines: 3,
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 3),
                  TextWidget(
                    text: '${delivery.pHeader?.arrDatosDelivery?.referencia}',
                    color: Colors.black,
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      ButtonWidget(
                        padding: const EdgeInsets.all(5),
                        text:
                            '${delivery.pHeader?.arrDatosDelivery?.metodoPago?.descripcion} ${order.totalR}',
                        decoration: BoxDecoration(
                            color: AppColors.backgroundGrey,
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(5)),
                        style: CustomTextStyles.fontLabel(color: Colors.black),
                        onPressed: () {
                          // log('ordr ===${order.idpedido}');
                        },
                      ),
                      const SizedBox(width: 5),
                      TextWidget(
                        text: '${time['horaString']}',
                        color: time['minutos'] < 20 ? Colors.green : Colors.red,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          isSelected
              ? const TextWidget(text: '✅', fontSize: 16)
              : ButtonWidget(
                  text: 'Lo llevo',
                  onPressed: () =>
                      orderProvider.toggleSelectionOrderIdPendingDeliveryLocal(
                          order.idpedido.toString()),
                  padding: const EdgeInsets.all(10),
                )
        ],
      ),
    );
  }
}
