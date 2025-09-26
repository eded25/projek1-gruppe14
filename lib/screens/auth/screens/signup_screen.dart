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
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import '../controller/auth_controller.dart';
import 'package:barber_select/services/api_service.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());
    final themeController = Get.find<CustomDrawerController>();
    final fnName = FocusNode();
    final tecName = TextEditingController();

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
                  color: Get.isDarkMode
                      ? AppColors.whiteColor
                      : AppColors.blackColor,
                ),
                30.ph,
                Obx(
                  () => Text(
                    'ANMELDEN'.tr,
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
                        hintText: 'THMcut@gmail.com',
                        darkBorderColor: AppColors.darkBorderColor,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Dieses Feld ist erforderlich'.tr;
                          }
                          return Validators.validateEmail(value);
                        },
                      ),
                      20.ph,
                      CustomTextFormField(
                        fieldLabel: 'Name'.tr,
                        focusNode: fnName,
                        controller: tecName,
                        hintText: 'Vor- und Nachname',
                        darkBorderColor: AppColors.darkBorderColor,
                        validator: (value) {
                          return Validators.validateField(
                            value,
                            'Name ist erforderlich'.tr,
                          );
                        },
                      ),
                      CustomTextFormField(
                        fieldLabel: 'Rufnummer'.tr,
                        focusNode: controller.fnPhone,
                        hintText: '1234567',
                        controller: controller.tecPhone,
                        darkBorderColor: AppColors.darkBorderColor,
                        validator: (value) {
                          return Validators.validateField(
                            value,
                            'Rufnummer ist erforderlich'.tr,
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
                  btnLabel: 'Konto Erstellen',
                  height: 50,
                  onTap: () async {
                    if (controller.signUpForm.currentState!.validate()) {
                      final result = await ApiService.registerUser(
                        email: controller.tecEmailS.text.trim(),
                        phone: controller.tecPhone.text.trim(),
                        password: controller.tecPasswordS.text,
                        name: tecName.text.trim(),
                      );

                      if (result['status'] == 'success') {
                        Get.snackbar(
                          "Erfolg",
                          result['message'] ?? "Registrierung abgeschlossen",
                          backgroundColor: Colors.green,
                          colorText: Colors.white,
                        );
                        Get.to(() => EnterVerificationCode());
                      } else {
                        Get.snackbar(
                          "Fehler",
                          result['message'] ?? "Registrierung fehlgeschlagen",
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                      }
                    }
                  },
                ),
                30.ph,
                Row(
                  children: [
                    Flexible(
                      child: Divider(
                        color: Get.isDarkMode
                            ? AppColors.whiteColor.withOpacity(0.6)
                            : AppColors.blackColor.withOpacity(0.6),
                        thickness: 0.8,
                      ),
                    ),
                    20.pw,
                    Obx(
                      () => Text(
                        "Oder".tr,
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
                        color: Get.isDarkMode
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
                        "Sie haben bereits ein Konto?".tr,
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
