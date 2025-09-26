import 'package:barber_select/screens/auth/screens/login_screen.dart'; // ← Geändert
import 'package:barber_select/utils/app_colors.dart';
import 'package:barber_select/utils/app_text_styles.dart';
import 'package:barber_select/utils/gaps.dart';
import 'package:barber_select/widgets/custom_button.dart';
import 'package:barber_select/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class EnterVerificationCode extends StatelessWidget {
  const EnterVerificationCode({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<CustomDrawerController>();

    final defaultPinTheme = PinTheme(
      width: 56.w,
      height: 56.h,
      textStyle: AppTextStyles.getPoppins(
        24.sp,
        6.weight,
        themeController.isDarkMode,
        themeController.isDarkMode.value
            ? AppColors.whiteColor.withOpacity(0.6)
            : AppColors.blackColor.withOpacity(0.6),
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Get.isDarkMode
              ? AppColors.darkPrimaryColor.withOpacity(0.4)
              : AppColors.primaryColor.withOpacity(0.4),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(6),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(
        color: Get.isDarkMode
            ? AppColors.darkPrimaryColor.withOpacity(0.5)
            : AppColors.primaryColor,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(6),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(
          color: Get.isDarkMode
              ? AppColors.darkPrimaryColor.withOpacity(0.5)
              : AppColors.primaryColor,
          width: 2,
        ),
        color: Get.isDarkMode ? AppColors.darkScreenBg : AppColors.whiteColor,
      ),
    );
    return SafeArea(
      child: Scaffold(
        backgroundColor:
            Get.isDarkMode ? AppColors.darkScreenBg : AppColors.whiteColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              60.ph,
              Obx(
                () => Text(
                  'Verifizierungscode eingeben'.tr,
                  style: AppTextStyles.getPoppins(
                      20.sp, 7.weight, themeController.isDarkMode),
                ),
              ),
              20.ph,
              Text(
                "Wir haben Ihnen einen 4-stelligen Verifizierungscode auf".tr,
                style: AppTextStyles.getPoppins(
                    15.sp, 4.weight, themeController.isDarkMode),
              ),
              Text(
                "+6141 234 5***",
                style: AppTextStyles.getPoppins(
                    15.sp, 4.weight, themeController.isDarkMode),
              ),
              20.ph,
              Pinput(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                defaultPinTheme: defaultPinTheme,
                obscureText: true,
                focusedPinTheme: focusedPinTheme,
                submittedPinTheme: submittedPinTheme,
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                showCursor: true,
                onCompleted: (pin) => print(pin),
              ),
              30.ph,
              CustomButtonWidget(
                btnLabel: 'Bestätigen',
                onTap: () {
                  // Zurück zum Login oder direkt weiterleiten
                  Get.offAll(() => LoginScreen()); // ← Geändert

                  // Oder falls Sie eine andere Logik brauchen:
                  // Get.snackbar('Verifizierung', 'Code wurde bestätigt');
                },
              ),
              20.ph,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.replay_outlined,
                    color: Get.isDarkMode
                        ? AppColors.whiteColor
                        : AppColors.blackColor,
                  ),
                  10.pw,
                  Text(
                    'Code erneut senden'.tr,
                    style: AppTextStyles.getPoppins(
                        14.sp, 7.weight, themeController.isDarkMode),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
