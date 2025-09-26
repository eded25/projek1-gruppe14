import 'package:barber_select/models/service_model.dart';
import 'package:barber_select/utils/app_colors.dart';
import 'package:barber_select/utils/app_text_styles.dart';
import 'package:barber_select/utils/gaps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SettingServiceContainer extends StatelessWidget {
  const SettingServiceContainer({super.key, required this.service});

  final ServiceModel service;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 90.w,
          height: 100.h,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: Get.isDarkMode ? AppColors.darkBgThree : AppColors.greyColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                blurRadius: 5,
                color: AppColors.blackColor.withOpacity(0.3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.cut),
              Spacer(),
              Center(
                child: Text(
                  service.name,
                  style: AppTextStyles.getPoppins(12.sp, 5.weight),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
