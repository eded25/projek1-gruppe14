import 'package:barber_select/models/service_model.dart';
import 'package:barber_select/utils/app_colors.dart';
import 'package:barber_select/utils/app_text_styles.dart';
import 'package:barber_select/utils/gaps.dart';
import 'package:barber_select/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ServicesWidget extends StatelessWidget {
  const ServicesWidget({super.key, required this.service});

  final ServiceModel service;

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<CustomDrawerController>();
    return Column(
      children: [
        Container(
          width: 70.w,
          height: 70.h,
          decoration: BoxDecoration(
            color:
                Get.isDarkMode
                    ? AppColors.darkBgSecondary
                    : AppColors.greyColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Icon(
              Icons.cut,
              color:
                  Get.isDarkMode
                      ? AppColors.darkModeTextColor
                      : AppColors.primaryColor,
            ),
          ),
        ),

        Obx(
          () => Text(
            service.name,
            style: AppTextStyles.getPoppins(
              14.sp,
              5.weight,
              themeController.isDarkMode,

              themeController.isDarkMode.value
                  ? AppColors.darkModeTextColor
                  : AppColors.textBlackColor,
            ),
          ),
        ),
      ],
    );
  }
}
