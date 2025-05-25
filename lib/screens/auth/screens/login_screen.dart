import 'package:barber_select/generated/assets.dart';
import 'package:barber_select/screens/auth/controller/auth_controller.dart';
import 'package:barber_select/screens/auth/screens/choose_profile.dart';
import 'package:barber_select/screens/auth/screens/signup_screen.dart';
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

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                    'LOGIN'.tr,
                    style: AppTextStyles.getPoppins(
                      18.sp,
                      6.weight,
                      themeController.isDarkMode,
                    ),
                  ),
                ),
                Obx(
                  () => Text(
                    'Welcome Back 👋'.tr,
                    style: AppTextStyles.getPoppins(
                      14.sp,
                      4.weight,
                      themeController.isDarkMode,
                    ),
                  ),
                ),
                20.ph,
                Form(
                  key: controller.loginForm,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        fieldLabel: 'Email'.tr,
                        focusNode: controller.fnEmail,
                        controller: controller.tecEmail,
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
                      Obx(
                        () => CustomTextFormField(
                          fieldLabel: 'Password'.tr,
                          focusNode: controller.fnPassword,
                          controller: controller.tecPassword,
                          obscureText: controller.togglePasswordL.value,
                          darkBorderColor: AppColors.darkBorderColor,

                          hintText: '******',
                          suffix: InkWell(
                            onTap: () {
                              controller.togglePasswordL.value =
                                  !controller.togglePasswordL.value;
                            },
                            child: Icon(
                              !controller.togglePasswordL.value
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                            ),
                          ),
                          validator: Validators.validatePassword,
                        ),
                      ),
                    ],
                  ),
                ),

                20.ph,
                CustomButtonWidget(
                  btnLabel: 'Login'.tr,
                  height: 50,
                  onTap: () {
                    if (controller.loginForm.currentState!.validate()) {
                      Get.to(() => ChooseProfile());
                    }
                  },
                ),
                40.ph,
                Text(
                  "Forgot Password?".tr,
                  style: AppTextStyles.getPoppins(
                    16.sp,
                    6.weight,
                    themeController.isDarkMode,
                    AppColors.primaryColor,
                  ),
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
                        "Don't have an account?".tr,
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
                        Get.to(() => SignupScreen());
                      },
                      child: Obx(
                        () => Text(
                          "SIGN UP",
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
