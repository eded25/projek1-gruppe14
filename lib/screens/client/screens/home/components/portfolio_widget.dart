import 'package:barber_select/generated/assets.dart';
import 'package:barber_select/models/portfolio_model.dart';
import 'package:barber_select/models/service_model.dart';
import 'package:barber_select/utils/app_colors.dart';
import 'package:barber_select/utils/app_text_styles.dart';
import 'package:barber_select/utils/gaps.dart';
import 'package:barber_select/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';

class PortfolioWidget extends StatelessWidget {
  const PortfolioWidget({super.key, required this.portfolio});

  final PortfolioModel portfolio;

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<CustomDrawerController>();
    return Column(
      children: [
        Container(
          width: 250.w,
          height: 120.h,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: AppColors.greyColor,
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: AssetImage(Assets.barberImage2),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                portfolio.name,
                style: AppTextStyles.getPoppins(
                  15.sp,
                  7.weight,
                  themeController.isDarkMode,

                  AppColors.whiteColor,
                ),
              ),
              Row(
                children: [
                  Text(
                    "20+ ",
                    style: AppTextStyles.getPoppins(
                      13.sp,
                      4.weight,
                      themeController.isDarkMode,

                      AppColors.whiteColor,
                    ),
                  ),
                  Text(
                    "Templates".tr,
                    style: AppTextStyles.getPoppins(
                      13.sp,
                      4.weight,
                      themeController.isDarkMode,

                      AppColors.whiteColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
