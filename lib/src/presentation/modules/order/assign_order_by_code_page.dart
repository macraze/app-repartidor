import 'package:app_repartidor/src/data/local/local_storage.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:app_repartidor/src/domain/models/models.dart';
import 'package:app_repartidor/src/presentation/styles/styles.dart';
import 'package:app_repartidor/src/presentation/widgets/widgets.dart';
import 'package:app_repartidor/src/presentation/providers/providers.dart';
import 'package:app_repartidor/src/presentation/common/utils/snackbars.dart';
import 'package:app_repartidor/src/presentation/common/constants/constants.dart';
import 'package:app_repartidor/src/presentation/common/utils/validators.dart';

class AssignOrderByCodePage extends StatelessWidget {
  AssignOrderByCodePage({super.key});

  final FocusNode _focusUser = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getBody(context),
    );
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
      key: provider.formKey,
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
              onFieldSubmitted: (_) => actionAsignOrder(context),
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
                disabled:
                    !provider.isValidForm() || provider.isLoadingOrderCode,
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

    if (!assignOrderByCodeProvider.isValidForm()) return;

    FocusScope.of(context).unfocus();

    final String? errorMessage =
        await assignOrderByCodeProvider.assignOrderProvider(
            idPedido: int.parse(assignOrderByCodeProvider.orderCode),
            idRepartidor: user.idrepartidor);

    final orderProvider = Provider.of<OrderProvider>(context, listen: false);

    final String? errorMeesage2 =
        await orderProvider.acceptListOrdersByIdsProvider(
            ids: assignOrderByCodeProvider.orderCode);

    final listOrders = await orderProvider.getListOrdersAcceptedByIdsProvider(
        ids: assignOrderByCodeProvider.orderCode);

    final socketProvider = Provider.of<SocketProvider>(context, listen: false);

    LocalStorage.pedidosAceptados = orderAcceptedLocalToJson(listOrders);

    socketProvider.cocinarLisPedidosNotificar(listOrders: listOrders);

    final orderTempProvider =
        Provider.of<OrderTempProvider>(context, listen: false);

    orderTempProvider.isShowCatWaiting = false;

    // if (errorMessage != null) {
    //   Snackbars.showSnackbarError(errorMessage);
    // } else {
    Snackbars.showSnackbarSuccess('Asignación de pedido correcta.');
    // }
  }
}
