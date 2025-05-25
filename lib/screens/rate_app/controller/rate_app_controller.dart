import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RateAppController extends GetxController {
  final fnRateApp = FocusNode();
  final tecRateApp = TextEditingController();
  var appRating = 0.0.obs;
}
