import 'package:app_repartidor/src/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class Snackbars {
  static GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static showSnackbar(String message) {
    final snackBar = SnackBar(
      content: TextWidget(
        text: message,
        fontSize: 13,
        maxLines: 3,
        textAlign: TextAlign.left,
      ),
    );
    messengerKey.currentState!.showSnackBar(snackBar);
  }

  static showSnackbarSuccess(String message) {
    final snackBar = SnackBar(
      backgroundColor: Colors.green.withOpacity(0.9),
      content: TextWidget(
        text: message,
        fontSize: 13,
        maxLines: 3,
        textAlign: TextAlign.left,
      ),
    );
    messengerKey.currentState!.showSnackBar(snackBar);
  }

  static showSnackbarError(String message) {
    final snackBar = SnackBar(
      backgroundColor: Colors.red.withOpacity(0.9),
      content: TextWidget(
        text: message,
        fontSize: 13,
        maxLines: 3,
        textAlign: TextAlign.left,
      ),
    );
    messengerKey.currentState!.showSnackBar(snackBar);
  }
}
