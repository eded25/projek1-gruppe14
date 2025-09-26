import 'package:barber_select/screens/auth/screens/login_screen.dart';
import 'package:barber_select/utils/app_colors.dart';
import 'package:barber_select/utils/app_text_styles.dart';
import 'package:barber_select/utils/gaps.dart';
import 'package:barber_select/utils/responsive.dart';
import 'package:barber_select/widgets/custom_button.dart';
import 'package:barber_select/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<CustomDrawerController>();
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 400.w,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Get.isDarkMode ? AppColors.darkBgThree : AppColors.whiteColor,

          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(
              () => Text(
                "Sicher?".tr,
                textAlign: TextAlign.center,
                style: AppTextStyles.getPoppins(
                  18.sp,
                  6.weight,
                  themeController.isDarkMode,
                ),
              ),
            ),
            10.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 80.w,
                  child: CustomButtonWidget(
                    btnLabel: 'Zustimmen',
                    bgColor: AppColors.primaryColor,
                    borderRadius: 12,
                    onTap: () {
                      Get.offAll(() => LoginScreen());
                    },
                  ),
                ),
                20.pw,

                SizedBox(
                  width: 80.w,
                  child: Obx(
                    () => CustomButtonWidget(
                      borderRadius: 12,
                      btnLabel: 'Abbruch',
                      bgColor: AppColors.blackColor.withOpacity(0.7),
                      onTap: () {
                        Get.back();
                      },
                      btnLabelStyle: AppTextStyles.getPoppins(
                        Responsive.isMobile(context) ? 16.sp : 20.sp,
                        7.weight,
                        themeController.isDarkMode,
                        AppColors.whiteColor,
                      ),
                    ),
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: 20),
          ],
        ),
      ),
    );
  }
}
