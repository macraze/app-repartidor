import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app_repartidor/src/presentation/styles/styles.dart';
import 'package:app_repartidor/src/presentation/widgets/widgets.dart';
import 'package:app_repartidor/src/presentation/common/constants/constants.dart';
import 'package:app_repartidor/src/presentation/common/utils/snackbars.dart';
import 'package:app_repartidor/src/presentation/common/utils/validators.dart';
import 'package:app_repartidor/src/presentation/providers/auth_provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final FocusNode _focusUser = FocusNode();
  final FocusNode _focusPassword = FocusNode();

  static const String title = 'PAPAYA';
  static const String subTitle = 'Repartidor Autorizado';

  static const String labelUsername = 'Usuario *';
  static const String hintUsername = 'Ingresa tu nombre de usuario';

  static const String labelPassword = 'Clave *';
  static const String hintPassword = 'Ingresa tu clave';

  static const String labelButton = 'Iniciar sesión';
  static const String messageSnackbarSuccess = 'Inicio de sesión correcto';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getBody(context),
    );
  }

  Widget _getBody(context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: ContainerWidget(
        width: size.width * 1,
        height: size.height * 1,
        child: Column(
          children: [
            Expanded(
              child: ContainerWidget(
                height: size.height * 0.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      fit: BoxFit.contain,
                      IconConstant.logoShippingMotorcycle,
                      height: size.height * 0.3,
                      width: double.infinity,
                    ),
                    const TextWidget(
                        text: title, color: Colors.black, fontSize: 40),
                    const TextWidget(
                        text: subTitle,
                        color: AppColors.textColorLight,
                        fontSize: 15)
                  ],
                ),
              ),
            ),
            Expanded(
              child: ContainerWidget(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.backgroundLogin,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _getInputs(context),
                    _getButtons(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getInputs(context) {
    final loginForm = Provider.of<AuthProvider>(context);
    final obscureText = loginForm.obscureText;
    return Form(
      key: loginForm.formKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: ContainerWidget(
        decoration: const BoxDecoration(color: Colors.transparent),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextWidget(
              text: labelUsername,
              color: AppColors.textColorLight,
            ),
            TextFieldWidget(
              style: const TextStyle(color: Colors.black, fontSize: 14),
              onChanged: (value) => loginForm.username = value,
              validator: Validators.usernameValidator,
              focusNode: _focusUser,
              onFieldSubmitted: (value) =>
                  FocusScope.of(context).requestFocus(_focusPassword),
              decoration: CustomInputs.loginInputDecoration(
                  hintText: hintUsername,
                  hintStyle: const TextStyle(color: AppColors.textColorLight),
                  color: Colors.transparent,
                  isDense: true),
            ),
            const SizedBox(height: 20),
            const TextWidget(
              text: labelPassword,
              color: AppColors.textColorLight,
            ),
            TextFieldWidget(
              style: const TextStyle(color: Colors.black, fontSize: 14),
              onChanged: (value) => loginForm.password = value,
              validator: Validators.passwordValidator,
              onFieldSubmitted: (_) => actionLogin(context),
              focusNode: _focusPassword,
              keyboardType: TextInputType.visiblePassword,
              obscureText: obscureText,
              decoration: CustomInputs.loginInputDecoration(
                isDense: true,
                hintText: hintPassword,
                hintStyle: const TextStyle(color: AppColors.textColorLight),
                color: Colors.transparent,
                suffixIcon: CupertinoButton(
                    minSize: 0,
                    padding: const EdgeInsets.only(right: 10),
                    onPressed: () => loginForm.getObscureText(),
                    child: Icon(
                      obscureText
                          ? CupertinoIcons.eye
                          : CupertinoIcons.eye_slash,
                      color: AppColors.secondary,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getButtons(context) {
    final loginForm = Provider.of<AuthProvider>(context);

    return Column(
      children: [
        ButtonWidget(
          margin: const EdgeInsets.only(top: 30),
          constraints: const BoxConstraints(minWidth: 136),
          text: labelButton,
          onPressed: () => actionLogin(context),
          disabled: loginForm.isLoadingLogin,
          color: AppColors.secondary,
          colorDisabled: AppColors.secondary,
          loading: loginForm.isLoadingLogin,
        ),
      ],
    );
  }

  Future actionLogin(context) async {
    final loginForm = Provider.of<AuthProvider>(context, listen: false);

    if (!loginForm.isValidForm()) return;

    FocusScope.of(context).unfocus();

    final String? errorMessage =
        await loginForm.login(loginForm.username, loginForm.password);

    if (errorMessage != null) {
      Snackbars.showSnackbarError(errorMessage);
    } else {
      Snackbars.showSnackbarSuccess(messageSnackbarSuccess);
    }
  }
}
