import 'dart:io';
import 'package:app_repartidor/src/presentation/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Alerts {
  static showRecover(Widget child, BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: child,
          );
        });
  }

  static mostrarAlerta(String title, String message, Function() onPressed,
      BuildContext context) {
    if (!Platform.isAndroid) {
      return showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => WillPopScope(
                onWillPop: () async => false,
                child: AlertDialog(
                  title: Text(title),
                  content: Text(message),
                  actions: <Widget>[
                    MaterialButton(
                      elevation: 5,
                      textColor: Colors.blue,
                      onPressed: onPressed,
                      child: const Text('OK'),
                    ),
                  ],
                ),
              ));
    }
    return showCupertinoDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => WillPopScope(
              onWillPop: () async => false,
              child: CupertinoAlertDialog(
                title: Text(title),
                content: Text(message),
                actions: <Widget>[
                  MaterialButton(
                    elevation: 5,
                    textColor: Colors.blue,
                    onPressed: onPressed,
                    child: const Text('OK'),
                  ),
                ],
              ),
            ));
  }

  static loadingAlert(String text, BuildContext context) {
    if (Platform.isAndroid) {
      return showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) => Material(
                color: Colors.transparent,
                child: WillPopScope(
                  onWillPop: () async => true,
                  child: ContainerWidget(
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const CircularProgressIndicator(),
                        const SizedBox(height: 10),
                        Text(
                          text,
                          style: const TextStyle(
                              fontSize: 15, color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
              ));
    }
    return showCupertinoDialog(
        context: context,
        barrierDismissible: true,
        builder: (_) => Material(
              color: Colors.transparent,
              child: WillPopScope(
                onWillPop: () async => true,
                child: ContainerWidget(
                  decoration: const BoxDecoration(
                    color: Colors.black45,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CupertinoActivityIndicator(),
                      const SizedBox(height: 10),
                      Text(
                        text,
                        style:
                            const TextStyle(fontSize: 15, color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
            ));
  }

  static Future alertBasicTwoButton({
    required BuildContext context,
    required String title,
    required String description,
    required String text1,
    Color? color1,
    TextStyle? style1,
    required void Function() onPressed1,
    required String text2,
    Color? color2,
    TextStyle? style2,
    required void Function() onPressed2,
  }) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (builder) {
          return Material(
            color: Colors.transparent,
            child: StatefulBuilder(
              builder: (BuildContext context, setState) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  title: TextWidget(
                    text: title,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextWidget(
                        text: description,
                        style: const TextStyle(
                          color: Color(0xff7F7F7F),
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 10,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          ButtonWidget(
                            color: color1,
                            onPressed: onPressed1,
                            text: text1,
                          ),
                          ButtonWidget(
                            color: color2,
                            onPressed: onPressed2,
                            text: text2,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        });
  }

  static Future alertBasicTwoButtonTextWidget({
    required BuildContext context,
    required String title,
    required Widget description,
    required String text1,
    Color? color1,
    TextStyle? style1,
    required void Function() onPressed1,
    required String text2,
    Color? color2,
    TextStyle? style2,
    required void Function() onPressed2,
  }) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (builder) {
          return Material(
            color: Colors.transparent,
            child: StatefulBuilder(
              builder: (BuildContext context, setState) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  title: TextWidget(
                    text: title,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      description,
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          ButtonWidget(
                            color: color1,
                            onPressed: onPressed1,
                            text: text1,
                          ),
                          ButtonWidget(
                            color: color2,
                            onPressed: onPressed2,
                            text: text2,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        });
  }
}
