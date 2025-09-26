import 'package:barber_select/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeController extends GetxController {
  var currentPage = 0.obs;

  List<Map<String, String>> pages = [
    {
      "title": "Dein Look. Dein Friseur.",
      "description":
          "Einfach buchen. Stylisch aussehen. Ihre Adresse für ein reibungsloses Friseurerlebnis  von der schnellen Terminfindung bis zum perfekten Haarschnitt. Finden, buchen und genießen  alles an einem Ort.",
      "background": Assets.barberImage1,
    },
    {
      "title": "Dein Look. Dein Friseur.",
      "description":
          "Einfach buchen. Stylisch aussehen. Ihre Adresse für ein reibungsloses Friseurerlebnis  von der schnellen Terminfindung bis zum perfekten Haarschnitt. Finden, buchen und genießen alles an einem Ort.",
      "background": Assets.barberImage2,
    },
    {
      "title": "Dein Look. Dein Friseur.",
      "description":
          "Einfach buchen. Stylisch aussehen. Ihre Adresse für ein reibungsloses Friseurerlebnis  von der schnellen Terminfindung bis zum perfekten Haarschnitt. Finden, buchen und genießen  alles an einem Ort.",
      "background": Assets.barberImage3,
    },
  ];

  void skip() {}

  @override
  void onInit() {
    super.onInit();
    for (var page in pages) {
      precacheImage(AssetImage(page["background"]!), Get.context!);
    }
  }
}
