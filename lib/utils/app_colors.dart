import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFFDAA346);
  static const Color darkPrimaryColor = Color(0xffD5A453);
  static const Color primaryColor2 = Color(0xff99671C);

  static const Color whiteColor = Colors.white;
  static const Color textfieldBg = Color(0xffFCFCFA);
  static const Color screenBg = Color(0xffF6F6FD);
  static const Color darkScreenBg = Color(0xff1C1C1C);
  static const Color darkModeTextColor = Color(0xff9FA9B1);
  static const Color darkBgThree = Color(0xff131311);
  static const Color darkBorderColor = Color(0xff5D554B);

  static const Color lightGreyColor = Color.fromARGB(255, 142, 141, 141);
  static const Color textBlackColor = Color(0xff141414);
  static const Color blackColor = Color(0xff000000);
  static const Color borderColor = Color(0xffA1A1A1);
  static const Color darkBrownColor = Color(0xff1C1303);
  static const Color darkBgSecondary = Color(0xff2D2C2B);
  static const redColor = Color(0xff5E111B);
  static const redColor2 = Color(0xffFF5963);
  static const greenColor = Color(0xff145D1C);
  static const greyColor = Color(0xffEFEFEF);
  static const iconContainerColor = Color(0xffE9E8EE);

  static LinearGradient primaryGradient = LinearGradient(
    colors: [
      AppColors.primaryColor.withOpacity(0.2),
      AppColors.whiteColor.withOpacity(0),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
