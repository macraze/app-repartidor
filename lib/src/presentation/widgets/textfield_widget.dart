import 'package:app_repartidor/src/presentation/styles/styles.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    Key? key,
    this.hintText,
    this.controller,
    this.onChanged,
    this.validator,
    this.keyboardType = TextInputType.emailAddress,
    this.onFieldSubmitted,
    this.obscureText = false,
    this.suffixIcon,
    this.contentPadding =
        const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
    this.decoration,
    this.focusNode,
    this.cursorColor,
    this.maxLines = 1,
    this.style,
  }) : super(key: key);

  final String? hintText;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final void Function(String)? onFieldSubmitted;
  final Widget? suffixIcon;
  final EdgeInsetsGeometry? contentPadding;
  final InputDecoration? decoration;
  final FocusNode? focusNode;
  final Color? cursorColor;
  final int? maxLines;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      onFieldSubmitted: onFieldSubmitted,
      keyboardType: keyboardType,
      onChanged: onChanged,
      validator: validator,
      focusNode: focusNode,
      textAlignVertical: TextAlignVertical.center,
      cursorColor: cursorColor ?? AppColors.secondary,
      scrollPadding: EdgeInsets.zero,
      style: style ??
          const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            letterSpacing: 0,
            color: Colors.black,
            fontFamily: 'Montserrat',
          ),
      minLines: 1,
      maxLines: maxLines,
      decoration: decoration ??
          CustomInputs.loginInputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              letterSpacing: 0,
              color: Color(0xffC4C4C4),
              fontFamily: 'Montserrat',
            ),
            suffixIcon: suffixIcon,
            contentPadding: contentPadding,
          ),
    );
  }
}
