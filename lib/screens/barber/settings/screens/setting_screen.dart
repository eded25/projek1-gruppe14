import 'package:barber_select/dialog/logout_dialog.dart';
import 'package:barber_select/screens/barber/settings/components/professionals_container.dart';
import 'package:barber_select/screens/barber/settings/components/setting_service_container.dart';
import 'package:barber_select/screens/barber/settings/controller/barber_settings_controller.dart';
import 'package:barber_select/screens/client/screens/home/components/service_widget.dart';
import 'package:barber_select/utils/app_colors.dart';
import 'package:barber_select/utils/app_text_styles.dart';
import 'package:barber_select/utils/gaps.dart';
import 'package:barber_select/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BarberSettingsScreen extends StatelessWidget {
  const BarberSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BarberSettingsController());
    final themeController = Get.find<CustomDrawerController>();
    return SafeArea(
      child: Scaffold(
        backgroundColor:
            Get.isDarkMode ? AppColors.darkScreenBg : AppColors.whiteColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              40.ph,
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Icon(Icons.arrow_back, color: AppColors.primaryColor),
              ),
              30.ph,
              Text("My".tr, style: AppTextStyles.getPoppins(12.sp, 4.weight)),
              Text(
                "Settings".tr,
                style: AppTextStyles.getPoppins(30.sp, 5.weight),
              ),
              20.ph,
              Text(
                "Company Data".tr,
                style: AppTextStyles.getPoppins(14.sp, 4.weight),
              ),
              Text(
                "Barber MM".tr,
                style: AppTextStyles.getPoppins(26.sp, 5.weight),
              ),
              Text(
                "+1 (555) 123-4567",
                style: AppTextStyles.getPoppins(14.sp, 4.weight),
              ),
              20.ph,
              Text(
                "Services".tr,
                style: AppTextStyles.getPoppins(
                  16.sp,
                  6.weight,
                  themeController.isDarkMode,

                  Get.isDarkMode
                      ? AppColors.darkModeTextColor
                      : AppColors.textBlackColor,
                ),
              ),
              10.ph,
              Obx(
                () => SizedBox(
                  height: 105.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                                physics: BouncingScrollPhysics(),

                    itemCount: controller.services.length,
                    itemBuilder: (context, index) {
                      final service = controller.services[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 15.0, left: 2),
                        child: InkWell(
                          onTap: () {},
                          child: SettingServiceContainer(service: service),
                        ),
                      );
                    },
                  ),
                ),
              ),
              5.ph,

              Row(
                children: [
                  Icon(
                    Icons.arrow_right_alt_sharp,
                    color:
                        Get.isDarkMode
                            ? AppColors.darkModeTextColor
                            : AppColors.blackColor,
                    size: 20,
                  ),
                  Spacer(),
                  Text(
                    'Swipe to see more'.tr,
                    style: AppTextStyles.getPoppins(12.sp, 4.weight),
                  ),
                ],
              ),
              20.ph,
              Text(
                "Professionals".tr,
                style: AppTextStyles.getPoppins(
                  16.sp,
                  4.weight,
                  themeController.isDarkMode,

                  Get.isDarkMode
                      ? AppColors.darkModeTextColor
                      : AppColors.textBlackColor,
                ),
              ),
              10.ph,
              Obx(
                () => SizedBox(
                  height: 45.h,
                  child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,

                    itemCount: controller.services.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 15.0, left: 2),
                        child: InkWell(
                          onTap: () {},
                          child: ProfessionalsContainer(title: 'Adam'),
                        ),
                      );
                    },
                  ),
                ),
              ),
              5.ph,
              Row(
                children: [
                  Icon(
                    Icons.arrow_right_alt_sharp,
                    color:
                        Get.isDarkMode
                            ? AppColors.darkModeTextColor
                            : AppColors.blackColor,
                    size: 20,
                  ),
                  Spacer(),
                  Text(
                    'Swipe to see more'.tr,
                    style: AppTextStyles.getPoppins(12.sp, 4.weight),
                  ),
                ],
              ),
              40.ph,
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Robert Davis",
                        style: AppTextStyles.getPoppins(14.sp, 4.weight),
                      ),
                      Text(
                        "robertdavis@gmail.com",
                        style: AppTextStyles.getPoppins(12.sp, 4.weight),
                      ),
                    ],
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      Get.dialog(LogoutDialog());
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "Logout".tr,
                            style: AppTextStyles.getPoppins(14.sp, 5.weight),
                          ),
                          20.pw,
                          Icon(Icons.logout),
                        ],
                      ),
                    ),
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
