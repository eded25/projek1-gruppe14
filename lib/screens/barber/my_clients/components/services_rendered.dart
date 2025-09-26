import 'package:barber_select/models/service_model.dart';
import 'package:barber_select/utils/app_colors.dart';
import 'package:barber_select/utils/app_text_styles.dart';
import 'package:barber_select/utils/gaps.dart';
import 'package:barber_select/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ServicesRendered extends StatelessWidget {
  const ServicesRendered({super.key, required this.service});
  final ServiceModel service;
  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<CustomDrawerController>();
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
          width: 100.w,
          height: 110.h,
          decoration: BoxDecoration(
            color: Get.isDarkMode ? AppColors.darkBgThree : AppColors.screenBg,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppColors.blackColor.withOpacity(0.2),
                blurRadius: 3,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
               service.quantity.toString(),
                style: AppTextStyles.getPoppins(
                  30.sp,
                  6.weight,
                  themeController.isDarkMode,
                ),
              ),
              Spacer(),
              Center(
                child: Text(
                  service.name,
                  style: AppTextStyles.getPoppins(
                    12.sp,
                    4.weight,
                    themeController.isDarkMode,
                  ),
                ),
              ),
              3.ph,
            ],
          ),
        ),
        5.ph,
      ],
    );
  }
}
