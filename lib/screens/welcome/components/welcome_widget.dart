import 'package:barber_select/generated/assets.dart';
import 'package:barber_select/screens/auth/screens/login_screen.dart';
import 'package:barber_select/screens/auth/screens/signup_screen.dart';
import 'package:barber_select/screens/welcome/controller/welcome_controller.dart';
import 'package:barber_select/utils/app_colors.dart';
import 'package:barber_select/utils/app_text_styles.dart';
import 'package:barber_select/utils/gaps.dart';
import 'package:barber_select/widgets/custom_button.dart';
import 'package:barber_select/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../utils/responsive.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WelcomeController());
    final PageController pageController = PageController();
    final themeController = Get.find<CustomDrawerController>();
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              controller.pages[controller.currentPage.value]["background"]!,
            ),

            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.whiteColor.withOpacity(0.4),
                AppColors.primaryColor.withOpacity(0.4),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: PageView.builder(
                  controller: pageController,
                  onPageChanged: (index) {
                    controller.currentPage.value = index;
                  },
                  itemCount: controller.pages.length,
                  itemBuilder: (context, index) {
                    final page = controller.pages[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        40.ph,

                        Text(
                          "Willkommen bei".tr,
                          style: AppTextStyles.getPoppins(22.sp, 6.weight),
                        ),
                        40.ph,
                        Image.asset(Assets.appLogo, width: 150.w),
                        Spacer(),
                        Text(
                          page["title"]!.tr,
                          style: AppTextStyles.getPoppins(24.sp, 6.weight),
                        ),
                        10.ph,
                        Text(
                          page["description"]!.tr,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.getPoppins(
                            Responsive.isMobile(context) ? 14.sp : 18.sp,

                            5.weight,
                          ),
                        ).paddingSymmetric(
                          horizontal:
                              Responsive.isMobile(context)
                                  ? 50
                                  : Responsive.isLargeDesktop(context)
                                  ? 150
                                  : 100,
                        ),
                        40.ph,
                        Obx(
                          () => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ...List.generate(controller.pages.length, (
                                index,
                              ) {
                                bool isSelected =
                                    index == controller.currentPage.value;
                                return AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 5,
                                  ),
                                  height: 10,
                                  width: isSelected ? 10 : 10,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color:
                                        isSelected
                                            ? AppColors.blackColor
                                            : AppColors.lightGreyColor,
                                  ),
                                );
                              }),
                            ],
                          ),
                        ).paddingSymmetric(horizontal: 20),
                      ],
                    );
                  },
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
                        btnLabel: 'LOG IN',
                        bgColor: AppColors.blackColor,
                        onTap: () {
                          Get.to(() => LoginScreen());
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
                        btnLabel: 'REGISTRIEREN',
                        bgColor: AppColors.whiteColor,
                        onTap: () {
                          Get.to(() => SignupScreen());
                        },
                        btnLabelStyle: AppTextStyles.getPoppins(
                          Responsive.isMobile(context) ? 16.sp : 20.sp,
                          7.weight,
                          themeController.isDarkMode,

                          AppColors.blackColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ).paddingSymmetric(horizontal: 40),
              50.ph,

              20.ph,
            ],
          ),
        ),
      ),
    );
  }
}
