import 'dart:developer';

import 'package:app_repartidor/src/data/local/local_storage.dart';
import 'package:app_repartidor/src/presentation/routers/index.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:provider/provider.dart';

import 'package:app_repartidor/src/domain/models/models.dart';
import 'package:app_repartidor/src/presentation/styles/styles.dart';
import 'package:app_repartidor/src/presentation/widgets/widgets.dart';
import 'package:app_repartidor/src/presentation/providers/providers.dart';
import 'package:app_repartidor/src/presentation/common/utils/snackbars.dart';
import 'package:app_repartidor/src/presentation/common/constants/constants.dart';
import 'package:app_repartidor/src/presentation/common/utils/validators.dart';

class AssignOrderByCodePage extends StatefulWidget {
  AssignOrderByCodePage({super.key});

  @override
  State<AssignOrderByCodePage> createState() => _AssignOrderByCodePageState();
}

class _AssignOrderByCodePageState extends State<AssignOrderByCodePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode _focusUser = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getBody(context),
    );
  }

  @override
  void dispose() {
    _focusUser.dispose();
    super.dispose();
  }

  Widget _getBody(BuildContext context) {
    return ContainerWidget(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          AppbarWidget(),
          Expanded(
            child: _buildBody(context),
          ),
        ],
      ),
    );
  }

  ContainerWidget _buildBody(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ContainerWidget(
      width: double.infinity,
      decoration: const BoxDecoration(color: AppColors.backgroundGrey),
      child: Column(
        children: [
          Image.asset(
            IconConstant.logoHappyMusic,
            width: size.width * 0.8,
          ),
          _buildBodyContainer(context)
        ],
      ),
    );
  }

  Widget _buildBodyContainer(BuildContext context) {
    final provider = Provider.of<AssignOrderByCodeProvider>(context);

    if (!provider.showListOrdersPendingDeliveryLocal) {
      return ButtonWidget(
        text: 'Asignarse pedido',
        onPressed: () async {
          provider.toggleVisibilityListOrdersPendingDeliveryLocal();
        },
        margin: const EdgeInsets.only(top: 20),
        colorDisabled: AppColors.secondary,
      );
    }

    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: Column(
        children: [
          const SizedBox(height: 20),
          const TextWidget(
            text: 'Escribe el código del pedido',
            color: Colors.black,
            fontSize: 17,
          ),
          const SizedBox(height: 10),
          ContainerWidget(
            constraints: const BoxConstraints(maxWidth: 200),
            child: TextFieldWidget(
              textAlign: TextAlign.center,
              autocorrect: false,
              style: const TextStyle(color: Colors.black, fontSize: 14),
              onChanged: (value) => provider.orderCode = value,
              validator: Validators.orderCodeValidator,
              focusNode: _focusUser,
              keyboardType: TextInputType.number,
              // onFieldSubmitted: (_) => actionAsignOrder(context),
              cursorColor: Colors.black,
              decoration: CustomInputs.inputDecoration(
                  hintText: 'Código',
                  hintStyle: const TextStyle(color: AppColors.textColorLight),
                  isDense: true),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonWidget(
                text: 'Asignarse',
                onPressed: () async {
                  actionAsignOrder(context);
                },
                margin: const EdgeInsets.only(top: 20),
                style: CustomTextStyles.fontLabel(
                    fontSize: 15, fontWeight: FontWeight.bold),
                colorDisabled: AppColors.secondary.withOpacity(0.5),
                disabled: !(_formKey.currentState?.validate() ?? false) ||
                    provider.isLoadingOrderCode,
                loading: provider.isLoadingOrderCode,
              ),
              const SizedBox(width: 10),
              ButtonWidget(
                text: 'Cerrar',
                color: AppColors.textColor,
                margin: const EdgeInsets.only(top: 20),
                style: CustomTextStyles.fontLabel(
                    fontSize: 15, fontWeight: FontWeight.bold),
                onPressed: () async {},
              ),
            ],
          ),
          if (provider.responseMessage.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: TextWidget(
                text: provider.responseMessage,
                color: provider.isSuccess ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 16,
                maxLines: 3,
              ),
            ),
        ],
      ),
    );
  }

  Future actionAsignOrder(context) async {
    final assignOrderByCodeProvider =
        Provider.of<AssignOrderByCodeProvider>(context, listen: false);

    User user = UserProvider().user;

    if (!(_formKey.currentState?.validate() ?? false)) return;

    FocusScope.of(context).unfocus();

    final errorMessage = await assignOrderByCodeProvider.assignOrderProvider(
        idPedido: int.parse(assignOrderByCodeProvider.orderCode),
        idRepartidor: user.idrepartidor);

    if (errorMessage != null) return;

    try {
      _formKey.currentState?.reset();

      final orderProvider =
          Provider.of<OrderHeaderProvider>(context, listen: false);

      final errorMessage2 = await orderProvider.acceptListOrdersByIdsProvider(
          ids: assignOrderByCodeProvider.orderCode);

      final listOrders = await orderProvider.getListOrdersAcceptedByIdsProvider(
          ids: assignOrderByCodeProvider.orderCode);

      final socketProvider =
          Provider.of<SocketProvider>(context, listen: false);

      LocalStorage.pedidosAceptados = orderAcceptedLocalToJson(listOrders);

      socketProvider.cocinarLisPedidosNotificar(listOrders: listOrders);

      GoRouter.of(context).pushNamed(Routes.orderList);

      if (errorMessage != null) {
        Snackbars.showSnackbarError(errorMessage);
      } else {
        Snackbars.showSnackbarSuccess('Asignación de pedido correcta.');
      }
    } catch (e) {
      log('error');
    }
  }
}
