import 'package:barber_select/generated/assets.dart';
import 'package:barber_select/screens/auth/controller/auth_controller.dart';
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
import 'package:barber_select/services/api_service.dart';
import 'package:barber_select/screens/barber/home/screens/barber_home_screen.dart';
import 'package:barber_select/screens/client/screens/home/screens/client_home_screen.dart';
import 'package:barber_select/screens/barber/home/controller/barber_home_controller.dart';

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
                  color: Get.isDarkMode
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
                    'Willkommen zurück'.tr,
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
                      Obx(
                        () => CustomTextFormField(
                          fieldLabel: 'Passwort'.tr,
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
                  onTap: () async {
                    if (controller.loginForm.currentState!.validate()) {
                      // Loading Indicator anzeigen
                      Get.snackbar(
                        "Login",
                        " Anmeldung läuft...",
                        backgroundColor: Colors.blue,
                        colorText: Colors.white,
                        duration: Duration(seconds: 2),
                      );

                      final result = await ApiService.loginUser(
                        email: controller.tecEmail.text.trim(),
                        password: controller.tecPassword.text,
                      );

                      if (result['status'] == 'success') {
                        // User-Daten speichern
                        await controller.setUser(
                          id: result['user_id'],
                          email: result['email'],
                          role: result['role'],
                          name: result['name'] ?? '',
                        );

                        // Benutzername für BarberHomeController speichern
                        try {
                          final barberController =
                              Get.find<BarberHomeController>();
                          await barberController
                              .setUserName(result['name'] ?? 'Benutzer');
                        } catch (e) {
                          // Controller existiert noch nicht, wird beim ersten Laden gesetzt
                        }

                        Get.snackbar(
                          "Erfolg",
                          "Willkommen, ${result['name'] ?? 'Benutzer'}!",
                          backgroundColor: Colors.green,
                          colorText: Colors.white,
                          duration: Duration(seconds: 2),
                        );

                        // AUTOMATISCHES ROUTING BASIEREND AUF ROLLE
                        if (result['role'] == 'barber') {
                          Get.offAll(() => BarberHomeScreen());
                        } else {
                          Get.offAll(() => ClientHomeScreen());
                        }
                      } else {
                        // Login fehlgeschlagen
                        Get.snackbar(
                          "Login Fehler",
                          "${result['message'] ?? 'Login fehlgeschlagen'}",
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                          duration: Duration(seconds: 3),
                        );
                      }
                    } else {
                      // Formvalidierung fehlgeschlagen
                      Get.snackbar(
                        "Eingabefehler",
                        "⚠️ Bitte überprüfen Sie Ihre Eingaben",
                        backgroundColor: Colors.orange,
                        colorText: Colors.white,
                        duration: Duration(seconds: 2),
                      );
                    }
                  },
                ),
                40.ph,
                InkWell(
                  onTap: () {
                    // TODO: Passwort vergessen Funktionalität implementieren
                    Get.snackbar(
                      "Info",
                      "Passwort zurücksetzen wird bald verfügbar sein",
                      backgroundColor: Colors.blue,
                      colorText: Colors.white,
                    );
                  },
                  child: Text(
                    "Passwort vergessen?".tr,
                    style: AppTextStyles.getPoppins(
                      16.sp,
                      6.weight,
                      themeController.isDarkMode,
                      AppColors.primaryColor,
                    ),
                  ),
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
                        "Sie haben noch kein Konto?".tr,
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
                          "ANMELDEN",
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
                20.ph,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
