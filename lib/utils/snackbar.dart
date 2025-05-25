
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

void showSnackbar(String title, String message, Color color) {
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: color,
    colorText: Colors.white,
    icon: Icon(
      title == 'Success' ? Icons.check_circle : Icons.error,
      color: Colors.white,
    ),
    duration: Duration(seconds: 3),
    margin: EdgeInsets.all(12),
    borderRadius: 8,
    animationDuration: Duration(milliseconds: 500),
    isDismissible: true,
    forwardAnimationCurve: Curves.easeOutBack,
  );
}
