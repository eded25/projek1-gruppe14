import 'package:barber_select/screens/barber/home/controller/barber_home_controller.dart';
import 'package:barber_select/utils/app_colors.dart';
import 'package:barber_select/utils/app_text_styles.dart';
import 'package:barber_select/utils/gaps.dart';
import 'package:barber_select/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BarberHeader extends StatelessWidget {
  const BarberHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BarberHomeController());
    final themeController = Get.find<CustomDrawerController>();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            40.ph,
            Obx(
              () => Text(
                'Hello, Robert Davis',
                style: AppTextStyles.getPoppins(
                  16.sp,
                  5.weight,
                  themeController.isDarkMode,
                ),
              ),
            ),
            Obx(
              () => Text(
                'You are in your schedule'.tr,
                style: AppTextStyles.getPoppins(
                  12.sp,
                  4.weight,
                  themeController.isDarkMode,
                ),
              ),
            ),
          ],
        ),
        Spacer(),
        Obx(
          () => Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color:
                  themeController.isDarkMode.value
                      ? AppColors.blackColor
                      : AppColors.iconContainerColor,
            ),
            child: Center(
              child: Obx(
                () => InkWell(
                  onTap: () {
                    controller.showBalance.value =
                        !controller.showBalance.value;
                  },
                  child: Icon(
                    controller.showBalance.value
                        ? Icons.visibility
                        : Icons.visibility_off_outlined,
                    color:
                        controller.showBalance.value
                            ? AppColors.primaryColor
                            : themeController.isDarkMode.value
                            ? AppColors.darkModeTextColor
                            : AppColors.blackColor,
                  ),
                ),
              ),
            ),
          ),
        ),
        10.pw,
        GestureDetector(
          onTap: () {
            controller.scaffoldKey.currentState!.openDrawer();
          },
          child: Obx(
            () => Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color:
                    themeController.isDarkMode.value
                        ? AppColors.blackColor
                        : AppColors.iconContainerColor,
              ),
              child: Center(
                child: Icon(
                  Icons.menu_open_rounded,
                  color:
                      themeController.isDarkMode.value
                          ? AppColors.darkModeTextColor
                          : AppColors.blackColor,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
