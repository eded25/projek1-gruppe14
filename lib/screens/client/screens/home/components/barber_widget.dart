import 'package:barber_select/generated/assets.dart';
import 'package:barber_select/models/portfolio_model.dart';
import 'package:barber_select/models/service_model.dart';
import 'package:barber_select/models/user_model.dart';
import 'package:barber_select/utils/app_colors.dart';
import 'package:barber_select/utils/app_text_styles.dart';
import 'package:barber_select/utils/gaps.dart';
import 'package:barber_select/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BarberWidget extends StatelessWidget {
  const BarberWidget({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<CustomDrawerController>();
    return Column(
      children: [
        Container(
          width: 250.w,
          height: 120.h,

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
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.all(5),
                width: Get.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  color: AppColors.blackColor.withOpacity(0.4),
                ),
                child: Center(
                  child: Text(
                    user.name,
                    style: AppTextStyles.getPoppins(
                      14.sp,
                      4.weight,
                      themeController.isDarkMode,

                      AppColors.whiteColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
