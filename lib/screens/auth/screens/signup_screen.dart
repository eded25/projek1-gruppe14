import 'package:barber_select/generated/assets.dart';
import 'package:barber_select/screens/auth/screens/login_screen.dart';
import 'package:barber_select/screens/auth/screens/verification_code.dart';
import 'package:barber_select/utils/app_colors.dart';
import 'package:barber_select/utils/app_text_styles.dart';
import 'package:barber_select/utils/gaps.dart';
import 'package:barber_select/utils/validators.dart';
import 'package:barber_select/widgets/custom_button.dart';
import 'package:barber_select/widgets/custom_drawer.dart';
import 'package:barber_select/widgets/custom_textform_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controller/auth_controller.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());
    final themeController = Get.find<CustomDrawerController>();

    return SafeArea(
      child: Scaffold(
        backgroundColor:
            Get.isDarkMode ? AppColors.darkScreenBg : AppColors.whiteColor,

        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                40.ph,
                Image.asset(
                  Assets.appLogo,
                  width: 120.w,
                  color:
                      Get.isDarkMode
                          ? AppColors.whiteColor
                          : AppColors.blackColor,
                ),
                30.ph,
                Obx(
                  () => Text(
                    'SIGN UP'.tr,
                    style: AppTextStyles.getPoppins(
                      18.sp,
                      6.weight,
                      themeController.isDarkMode,
                    ),
                  ),
                ),

                20.ph,
                Form(
                  key: controller.signUpForm,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        fieldLabel: 'Email'.tr,
                        focusNode: controller.fnEmailS,
                        controller: controller.tecEmailS,
                        hintText: 'demouser@gmail.com',
                        darkBorderColor: AppColors.darkBorderColor,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field is required'.tr;
                          }
                          return Validators.validateEmail(value);
                        },
                      ),
                      20.ph,
                      CustomTextFormField(
                        fieldLabel: 'Phone number'.tr,
                        focusNode: controller.fnPhone,
                        hintText: '1234567',
                        controller: controller.tecPhone,
                        darkBorderColor: AppColors.darkBorderColor,
                        validator: (value) {
                          return Validators.validateField(
                            value,
                            'Phone number',
                          );
                        },
                      ),
                      20.ph,
                      Obx(
                        () => CustomTextFormField(
                          fieldLabel: 'Password'.tr,
                          focusNode: controller.fnPasswordS,
                          controller: controller.tecPasswordS,
                          obscureText: controller.togglePasswordS.value,
                          darkBorderColor: AppColors.darkBorderColor,
                          validator: Validators.validatePassword,

                          hintText: '******',
                          suffix: InkWell(
                            onTap: () {
                              controller.togglePasswordS.value =
                                  !controller.togglePasswordS.value;
                            },

                            child: Icon(
                              !controller.togglePasswordS.value
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                20.ph,
                CustomButtonWidget(
                  btnLabel: 'Create One',
                  height: 50,
                  onTap: () {
                    if (controller.signUpForm.currentState!.validate()) {
                      Get.to(() => EnterVerificationCode());
                    }
                  },
                ),

                30.ph,
                Row(
                  children: [
                    Flexible(
                      child: Divider(
                        color:
                            Get.isDarkMode
                                ? AppColors.whiteColor.withOpacity(0.6)
                                : AppColors.blackColor.withOpacity(0.6),
                        thickness: 0.8,
                      ),
                    ),
                    20.pw,

                    Obx(
                      () => Text(
                        "OR".tr,
                        style: AppTextStyles.getPoppins(
                          14.sp,
                          4.weight,
                          themeController.isDarkMode,
                        ),
                      ),
                    ),
                    20.pw,

                    Flexible(
                      child: Divider(
                        color:
                            Get.isDarkMode
                                ? AppColors.whiteColor.withOpacity(0.6)
                                : AppColors.blackColor.withOpacity(0.6),
                        thickness: 0.8,
                      ),
                    ),
                  ],
                ),
                30.ph,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(
                      () => Text(
                        "Already have an account?".tr,
                        style: AppTextStyles.getPoppins(
                          14.sp,
                          5.weight,
                          themeController.isDarkMode,
                        ),
                      ),
                    ),
                    Text(
                      " ".tr,
                      style: AppTextStyles.getPoppins(
                        14.sp,
                        5.weight,
                        themeController.isDarkMode,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.offAll(() => LoginScreen());
                      },
                      child: Obx(
                        () => Text(
                          "LOG IN".tr,
                          style: AppTextStyles.getPoppins(
                            14.sp,
                            6.weight,
                            themeController.isDarkMode,
                            AppColors.primaryColor,
                          ).copyWith(
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
