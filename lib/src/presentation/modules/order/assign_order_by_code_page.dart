import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';

import 'package:app_repartidor/src/domain/models/models.dart';
import 'package:app_repartidor/src/data/local/local_storage.dart';
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
    final orderProvider = Provider.of<OrderProvider>(context);
    final User user = userFromJson(LocalStorage.user);

    String title = orderProvider.switchValue ? 'En línea' : 'Offline';

    Size size = MediaQuery.of(context).size;

    return ContainerWidget(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          AppbarWidget(
            actions: _buildSwitch(orderProvider, context, user, title),
          ),
          Expanded(
            child: _buildBody(context),
          ),
        ],
      ),
    );
  }

  Column _buildSwitch(OrderProvider orderProvider, BuildContext context,
      User user, String title) {
    return Column(
      children: [
        (orderProvider.isLoadingOnline == true)
            ? const CircularIndicatorWidget(height: 39, width: 59)
            : CupertinoSwitch(
                value: orderProvider.switchValue,
                activeColor: AppColors.tertiary,
                onChanged: (bool? value) async {
                  if (value == true) {
                    _showInputDialog(context, user);
                  } else {
                    await handleSwitchChange(context, value, user);
                  }
                },
              ),
        TextWidget(text: title)
      ],
    );
  }

  void _showInputDialog(BuildContext context, User user) async {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        final orderProvider = Provider.of<OrderProvider>(context);

        return AlertDialog(
          title: const TextWidget(
            text: 'Confirmación',
            color: Colors.black,
            fontSize: 22,
            textAlign: TextAlign.start,
          ),
          content: Form(
            key: orderProvider.formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const TextWidget(
                  text: '¿Está seguro de actualizar su estado a "En línea"?',
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                  maxLines: 3,
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 10),
                TextFieldWidget(
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                  onChanged: (value) =>
                      orderProvider.mount = int.tryParse(value) ?? 0,
                  validator: (value) =>
                      Validators.mountValidator(int.tryParse(value ?? '0')),
                  focusNode: _focusUser,
                  onFieldSubmitted: (_) {
                    handleAlertSwitch(context, user);
                  },
                  decoration: CustomInputs.loginInputDecoration(
                      hintText: 'Monto para empezar',
                      hintStyle:
                          const TextStyle(color: AppColors.textColorLight),
                      color: Colors.transparent,
                      isDense: true),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                handleAlertSwitch(dialogContext, user);
              },
              child: const TextWidget(text: 'Ejecutar', color: Colors.black),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const TextWidget(text: 'Cancelar', color: Colors.black),
            ),
          ],
        );
      },
    );
  }

  void handleAlertSwitch(BuildContext context, User user) {
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);

    if (!orderProvider.isValidForm()) return;

    Navigator.pop(context);

    handleSwitchChange(context, true, user);
  }

  Future handleSwitchChange(
      BuildContext context, bool? value, User user) async {
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);

    if (orderProvider.isLoadingOnline) return;

    final String? errorMessage = await orderProvider.connectOrderProvider(
        idRepartidor: user.idrepartidor,
        mount: orderProvider.mount,
        isOnline: value == true ? 1 : 0);

    if (errorMessage != null) {
      Snackbars.showSnackbarError(errorMessage);
    } else {
      orderProvider.switchValue = value ?? false;
      Snackbars.showSnackbarSuccess(
          'El estado del repartidor ha sido actualizado.');
    }
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
          ButtonWidget(
            text: 'Ok',
            margin: const EdgeInsets.only(top: 20),
            style: CustomTextStyles.fontLabel(
                fontSize: 15, fontWeight: FontWeight.bold),
            onPressed: () async {
              final provider =
                  Provider.of<OrderTempProvider>(context, listen: false);

              // provider.isShowCatWaiting; // TODO: Se tiene que dar el valor false a isShowCatWaiting
            },
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
    final provider =
        Provider.of<AssignOrderByCodeProvider>(context, listen: false);

    User user = UserProvider().user;

    if (!provider.isValidForm()) return;

    FocusScope.of(context).unfocus();

    final String? errorMessage = await provider.assignOrderProvider(
        idPedido: int.parse(provider.orderCode),
        idRepartidor: user.idrepartidor);

    if (errorMessage != null) {
      Snackbars.showSnackbarError(errorMessage);
    } else {
      Snackbars.showSnackbarSuccess('Asignación de pedido correcta.');
    }
  }
}
