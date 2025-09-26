import 'package:barber_select/generated/assets.dart';
import 'package:barber_select/screens/splash/controller/splash_controller.dart';
import 'package:barber_select/utils/app_colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SplashController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Center(
          child: Image.asset(
            Assets.appLogo,
            width: 200.w,
            color: AppColors.whiteColor,
          ),
        ),
      ),
    );
  }
}
