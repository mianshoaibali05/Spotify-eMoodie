import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../main.dart';
import 'global_key.dart';

class Utils {

  static void showLoader() {
    if (!navigatorKey.currentContext!.loaderOverlay.visible) {
      navigatorKey.currentContext!.loaderOverlay.show();
    }
  }

  static void hideLoader() {
    if (navigatorKey.currentContext!.loaderOverlay.visible) {
      Future.delayed(const Duration(milliseconds: 500), () {
        navigatorKey.currentContext!.loaderOverlay.hide();
      });
    }
  }

  static void showGlobalSnackBar(String value, Color color) {
    globalKey.currentState!.hideCurrentSnackBar();
    final SnackBar snackBar = SnackBar(
      content: Text(value, style: const TextStyle(color: Colors.white),),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      duration: const Duration(seconds: 3),
      backgroundColor: color,
    );
    globalKey.currentState?.showSnackBar(snackBar);
  }
}
