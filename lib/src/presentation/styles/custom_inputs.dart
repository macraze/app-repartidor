import 'package:flutter/material.dart';
import 'package:app_repartidor/src/presentation/styles/styles.dart';

class CustomInputs {
  static InputDecoration loginInputDecoration({
    String? hintText,
    Widget? suffixIcon,
    Color? color,
    bool? isDense,
    EdgeInsetsGeometry? contentPadding,
    Color? colorEnabledBorder,
    Color? colorFocusedBorder,
    TextStyle? hintStyle,
    BoxConstraints? suffixIconConstraints,
  }) {
    return InputDecoration(
      contentPadding: contentPadding ??
          const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      fillColor: color ?? AppColors.greyOverlay,
      filled: true,
      errorMaxLines: 3,
      errorStyle: const TextStyle(color: Colors.red),
      focusedErrorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red,
          width: 1,
        ),
      ),
      border: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.transparent,
          width: 1,
        ),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: colorEnabledBorder ?? AppColors.textColor,
          width: 1,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: colorFocusedBorder ?? AppColors.secondary,
          width: 1,
        ),
      ),
      suffixIcon: suffixIcon,
      suffixIconConstraints: suffixIconConstraints ??
          const BoxConstraints(maxHeight: 30, maxWidth: 30),
      hintText: hintText,
      hintStyle: hintStyle ?? const TextStyle(color: AppColors.secondary),
      isDense: isDense,
    );
  }
}
