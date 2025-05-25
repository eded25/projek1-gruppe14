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
                          borderColor:
                              Get.isDarkMode
                                  ? AppColors.primaryColor
                                  : AppColors.whiteColor,
                          suffix: Icon(Icons.search, size: 20),
                        ),
                      ),
                      20.ph,

                      SlideInUp(
                        duration: const Duration(milliseconds: 600),
                        child: ListView.builder(
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
                                  Get.to(() => BarberDetailsScreen(barber: barber,));
                                },
                                child: FindBarbersTile(barbers: barber),
                              ),
                            );
                          },
                        ),
                      ),
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
