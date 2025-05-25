import 'package:barber_select/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeController extends GetxController {
  var currentPage = 0.obs;

  List<Map<String, String>> pages = [
    {
      "title": "Your Barber, Your Way",
      "description":
          "Effortless booking, exceptional cuts, Cut Quest is your go-to destination for a seamless barber expeirence. Find, book and enjoy the perfect cut, all in one place.",
      "background": Assets.barberImage1,
    },
    {
      "title": "Your Barber, Your Way",
      "description":
          "Effortless booking, exceptional cuts, Cut Quest is your go-to destination for a seamless barber expeirence. Find, book and enjoy the perfect cut, all in one place.",
      "background": Assets.barberImage2,
    },
    {
      "title": "Your Barber, Your Way",
      "description":
          "Effortless booking, exceptional cuts, Cut Quest is your go-to destination for a seamless barber expeirence. Find, book and enjoy the perfect cut, all in one place.",
      "background": Assets.barberImage3,
    },
  ];

  void skip() {
    // Get.to(() => CreateAccount());
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    for (var page in pages) {
      precacheImage(AssetImage(page["background"]!), Get.context!);
    }
  }
}
