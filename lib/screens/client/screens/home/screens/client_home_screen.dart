import 'package:barber_select/generated/assets.dart';
import 'package:barber_select/models/service_model.dart';
import 'package:barber_select/screens/client/screens/find_barbers/screens/barber_details_screen.dart';
import 'package:barber_select/screens/client/screens/find_barbers/screens/find_barbers_screen.dart';
import 'package:barber_select/screens/client/screens/home/components/barber_widget.dart';
import 'package:barber_select/widgets/custom_drawer.dart';
import 'package:barber_select/screens/client/screens/home/components/portfolio_widget.dart';
import 'package:barber_select/screens/client/screens/home/components/service_widget.dart';
import 'package:barber_select/screens/client/screens/home/controller/client_home_controller.dart';
import 'package:barber_select/utils/app_colors.dart';
import 'package:barber_select/utils/app_text_styles.dart';
import 'package:barber_select/utils/gaps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';

class ClientHomeScreen extends StatelessWidget {
  const ClientHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ClientHomeController());
    final themeController = Get.find<CustomDrawerController>();
    return SafeArea(
      child: Scaffold(
        key: controller.scaffoldKey,
        drawer: CustomDrawer(isBarber: false),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        themeController.isDarkMode.value
                            ? AppColors.darkPrimaryColor
                            : AppColors.primaryColor.withOpacity(0.8),
                        themeController.isDarkMode.value
                            ? AppColors.darkScreenBg
                            : AppColors.whiteColor,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Column(
                    children: [
                      40.ph,
                      HomeHeader(controller: controller),
                      20.ph,
                    ],
                  ),
                ),
              ),
              20.ph,
              FlutterCarousel(
                options: FlutterCarouselOptions(
                  height: 160.0.h,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  showIndicator: false,
                  viewportFraction: 0.95,
                  slideIndicator: CircularSlideIndicator(),
                ),
                items:
                    [
                      Assets.barberImage1,
                      Assets.barberImage2,
                      Assets.barberImage3,
                    ].map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: Get.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: AssetImage(i),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
              ),
              20.ph,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => Text(
                      "Services".tr,
                      style: AppTextStyles.getPoppins(
                        16.sp,
                        5.weight,
                        themeController.isDarkMode,

                        themeController.isDarkMode.value
                            ? AppColors.darkModeTextColor
                            : AppColors.textBlackColor,
                      ),
                    ),
                  ),
                  10.ph,
                  Obx(
                    () => SizedBox(
                      height: 100.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),

                        itemCount: controller.services.length,
                        itemBuilder: (context, index) {
                          final service = controller.services[index];
                          return Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: InkWell(
                              onTap: () {
                                Get.to(() => FindBarbersScreen());
                              },
                              child: ServicesWidget(service: service),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  // 20.ph,
                  // Obx(
                  //   () => Text(
                  //     "Our Portfolios".tr,
                  //     style: AppTextStyles.getPoppins(
                  //       16.sp,
                  //       5.weight,
                  //       themeController.isDarkMode,

                  //       themeController.isDarkMode.value
                  //           ? AppColors.darkModeTextColor
                  //           : AppColors.textBlackColor,
                  //     ),
                  //   ),
                  // ),
                  // 10.ph,
                  // Obx(
                  //   () => SizedBox(
                  //     height: 120.h,
                  //     child: ListView.builder(
                  //       scrollDirection: Axis.horizontal,
                  //       physics: BouncingScrollPhysics(),

                  //       itemCount: controller.portfolios.length,

                  //       itemBuilder: (context, index) {
                  //         final portfolio = controller.portfolios[index];
                  //         return Padding(
                  //           padding: const EdgeInsets.only(right: 15.0),
                  //           child: PortfolioWidget(portfolio: portfolio),
                  //         );
                  //       },
                  //     ),
                  //   ),
                  // ),
                  15.ph,
                  Obx(
                    () => Text(
                      "Barbers".tr,
                      style: AppTextStyles.getPoppins(
                        16.sp,
                        5.weight,
                        themeController.isDarkMode,

                        themeController.isDarkMode.value
                            ? AppColors.darkModeTextColor
                            : AppColors.textBlackColor,
                      ),
                    ),
                  ),
                  10.ph,
                  Obx(
                    () => SizedBox(
                      height: 120.h,
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,

                        itemCount: controller.barbers.length,
                        itemBuilder: (context, index) {
                          final barber = controller.barbers[index];
                          return Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: InkWell(
                              onTap: () {
                                Get.to(
                                  () => BarberDetailsScreen(barber: barber),
                                );
                              },
                              child: BarberWidget(user: barber),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ).paddingSymmetric(horizontal: 20),
              30.ph,
            ],
          ),
        ),
      ),
    );
  }
}

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key, required this.controller});

  final ClientHomeController controller;

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<CustomDrawerController>();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            controller.scaffoldKey.currentState!.openDrawer();
          },
          child: Obx(
            () => Icon(
              Icons.menu,
              color:
                  themeController.isDarkMode.value
                      ? AppColors.whiteColor
                      : AppColors.textBlackColor,
              size: 30,
            ),
          ),
        ),
        Spacer(),
        Obx(
          () => Image.asset(
            Assets.appLogo,
            width: 90.w,
            color:
                themeController.isDarkMode.value
                    ? AppColors.whiteColor
                    : AppColors.blackColor,
          ),
        ),
        Spacer(),
      ],
    ).paddingSymmetric(horizontal: 20);
  }
}
