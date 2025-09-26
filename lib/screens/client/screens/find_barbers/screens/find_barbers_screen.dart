import 'package:animate_do/animate_do.dart';
import 'package:barber_select/generated/assets.dart';
import 'package:barber_select/screens/client/screens/find_barbers/components/find_barbers_tile.dart';
import 'package:barber_select/screens/client/screens/find_barbers/controller/find_barber_controller.dart';
import 'package:barber_select/screens/client/screens/find_barbers/screens/barber_details_screen.dart';
import 'package:barber_select/utils/app_colors.dart';
import 'package:barber_select/utils/gaps.dart';
import 'package:barber_select/widgets/custom_textform_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FindBarbersScreen extends StatelessWidget {
  const FindBarbersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FindBarberController());
    return SafeArea(
      child: Scaffold(
        backgroundColor:
            Get.isDarkMode ? AppColors.darkBgThree : AppColors.whiteColor,
        body: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: Get.width,
                  height: Get.height * 0.3,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(Assets.barberImage2),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: Get.width,
                  height: Get.height * 0.3,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.transparent, AppColors.whiteColor],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      20.ph,
                      SlideInRight(
                        child: InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                      10.ph,
                      SlideInRight(
                        duration: const Duration(milliseconds: 700),
                        child: CustomTextFormField(
                          fieldLabel: '',
                          focusNode: controller.fnSearch,
                          controller: controller.tecSearch,
                          borderRadius: 12,
                          hintText: 'Search here...'.tr,
                          borderColor: Get.isDarkMode
                              ? AppColors.primaryColor
                              : AppColors.whiteColor,
                          suffix: Icon(Icons.search, size: 20),
                        ),
                      ),
                      20.ph,
                      Obx(() {
                        if (controller.isLoadingBarbers.value) {
                          return SlideInUp(
                            duration: const Duration(milliseconds: 600),
                            child: Container(
                              height: 200,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircularProgressIndicator(
                                      color: AppColors.primaryColor,
                                    ),
                                    10.ph,
                                    Text(
                                      'Loading barbers...'.tr,
                                      style: TextStyle(
                                        color: Get.isDarkMode
                                            ? AppColors.whiteColor
                                            : AppColors.textBlackColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }

                        if (controller.barbers.isEmpty) {
                          return SlideInUp(
                            duration: const Duration(milliseconds: 600),
                            child: Container(
                              height: 200,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.error_outline,
                                      size: 48,
                                      color: AppColors.primaryColor,
                                    ),
                                    10.ph,
                                    Text(
                                      'No barbers found'.tr,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Get.isDarkMode
                                            ? AppColors.whiteColor
                                            : AppColors.textBlackColor,
                                      ),
                                    ),
                                    5.ph,
                                    Text(
                                      'Please try again later'.tr,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Get.isDarkMode
                                            ? AppColors.whiteColor
                                                .withOpacity(0.7)
                                            : AppColors.textBlackColor
                                                .withOpacity(0.7),
                                      ),
                                    ),
                                    15.ph,
                                    ElevatedButton(
                                      onPressed: () =>
                                          controller.loadBarbersFromDatabase(),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.primaryColor,
                                        foregroundColor: AppColors.whiteColor,
                                      ),
                                      child: Text('Retry'.tr),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }

                        return SlideInUp(
                          duration: const Duration(milliseconds: 600),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 🔥 NEU: Debug Info (kann später entfernt werden)
                              Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  '✅ ${controller.barbers.length} Barber(s) loaded',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              10.ph,

                              ListView.builder(
                                physics: BouncingScrollPhysics(),
                                itemCount: controller.barbers.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  final barber = controller.barbers[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 7.0,
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        Get.to(() => BarberDetailsScreen(
                                            barber: barber));
                                      },
                                      child: FindBarbersTile(barbers: barber),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
