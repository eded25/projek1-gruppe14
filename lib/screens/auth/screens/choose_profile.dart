import 'package:barber_select/screens/barber/home/screens/barber_home_screen.dart';
import 'package:barber_select/screens/client/screens/home/screens/client_home_screen.dart';
import 'package:barber_select/utils/app_colors.dart';
import 'package:barber_select/utils/app_text_styles.dart';
import 'package:barber_select/utils/gaps.dart';
import 'package:barber_select/utils/responsive.dart';
import 'package:barber_select/widgets/custom_button.dart';
import 'package:barber_select/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChooseProfile extends StatelessWidget {
  const ChooseProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CustomDrawerController>();
    return SafeArea(
      child: Scaffold(
        backgroundColor:
            Get.isDarkMode
                ? AppColors.darkPrimaryColor
                : AppColors.primaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.person, color: AppColors.blackColor, size: 200),

              Obx(
                () => Text(
                  'Choose a Profile'.tr,
                  style: AppTextStyles.getPoppins(
                    18.sp,
                    7.weight,
                    controller.isDarkMode,
                  ),
                ),
              ),
              30.ph,
              Obx(
                () => Text(
                  'You can choose one of two available profile: Barber or Client. You also have the option to change your selection later to try the other profile. Make your choice below.',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.getPoppins(
                    14.sp,
                    5.weight,
                    controller.isDarkMode,
                  ),
                ),
              ),
              40.ph,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: SizedBox(
                      width:
                          Responsive.isLargeDesktop(context)
                              ? 200
                              : Responsive.isDesktop(context)
                              ? 150
                              : Responsive.isTablet(context)
                              ? 150
                              : null,
                      child: CustomButtonWidget(
                        btnLabel: 'BARBER',
                        bgColor: AppColors.blackColor,
                        onTap: () {
                          Get.to(() => BarberHomeScreen());
                        },
                      ),
                    ),
                  ),
                  20.pw,

                  Flexible(
                    child: SizedBox(
                      width:
                          Responsive.isLargeDesktop(context)
                              ? 200
                              : Responsive.isDesktop(context)
                              ? 150
                              : Responsive.isTablet(context)
                              ? 150
                              : null,
                      child: CustomButtonWidget(
                        btnLabel: 'CLIENT',
                        bgColor: Color(0xff9D660E),
                        onTap: () {
                          Get.to(() => ClientHomeScreen());
                        },
                      ),
                    ),
                  ),
                ],
              ).paddingSymmetric(horizontal: 30),
            ],
          ),
        ),
      ),
    );
  }
}
