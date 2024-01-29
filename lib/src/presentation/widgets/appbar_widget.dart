import 'package:app_repartidor/src/data/local/local_storage.dart';
import 'package:app_repartidor/src/domain/models/models.dart';
import 'package:app_repartidor/src/presentation/common/utils/snackbars.dart';
import 'package:app_repartidor/src/presentation/common/utils/validators.dart';
import 'package:app_repartidor/src/presentation/providers/providers.dart';
import 'package:app_repartidor/src/presentation/styles/styles.dart';
import 'package:app_repartidor/src/presentation/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppbarWidget extends StatelessWidget {
  AppbarWidget({super.key, this.actions, this.leading});

  final Widget? leading;
  final Widget? actions;
  final FocusNode _focusUser = FocusNode();

  @override
  Widget build(BuildContext context) {
    final User user = userFromJson(LocalStorage.user);

    return ContainerWidget(
      decoration: const BoxDecoration(color: AppColors.primary),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      constraints: const BoxConstraints(minHeight: 96),
      child: SafeArea(
        bottom: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            leading ?? _buildUserInfo(user),
            // actions ?? const ContainerWidget(),
            _buildSwitch(context),
          ],
        ),
      ),
    );
  }

  TextWidget _buildUserInfo(User user) {
    return TextWidget(
      text: user.nombre ?? '',
      fontSize: 13,
      maxLines: 2,
    );
  }

  Column _buildSwitch(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    String title = orderProvider.switchValue ? 'En línea' : 'Offline';

    final User user = userFromJson(LocalStorage.user);

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
}
