import 'package:flutter/material.dart';

class CustomTextStyles {
  static TextStyle fontLabel(
      {double? fontSize = 12,
      Color? color = Colors.white,
      FontWeight? fontWeight = FontWeight.w500}) {
    return TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      fontFamily: 'Montserrat',
    );
  }
}
