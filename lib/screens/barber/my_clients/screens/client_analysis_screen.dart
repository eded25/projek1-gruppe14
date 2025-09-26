import 'package:animate_do/animate_do.dart';
import 'package:barber_select/screens/barber/my_clients/components/client_appointment_tile.dart';
import 'package:barber_select/screens/barber/my_clients/components/services_rendered.dart';
import 'package:barber_select/screens/barber/my_clients/controller/my_clients_controller.dart';
import 'package:barber_select/utils/app_colors.dart';
import 'package:barber_select/utils/app_text_styles.dart';
import 'package:barber_select/utils/gaps.dart';
import 'package:barber_select/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ClientAnalysisScreen extends StatelessWidget {
  const ClientAnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MyClientsController>();
    return SafeArea(
      child: Scaffold(
        backgroundColor:
            Get.isDarkMode ? AppColors.darkScreenBg : AppColors.whiteColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              40.ph,
              SlideInRight(
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(Icons.arrow_back, color: AppColors.primaryColor),
                ),
              ),
              30.ph,
              SlideInRight(
                child: Text(
                  "Analyze".tr,
                  style: AppTextStyles.getPoppins(12.sp, 4.weight),
                ),
              ),
              SlideInRight(
                child: Text(
                  "Ethan Baker",
                  style: AppTextStyles.getPoppins(30.sp, 5.weight),
                ),
              ),
              5.ph,
              SlideInRight(
                child: Text(
                  "+1 (555) 123-4567",
                  style: AppTextStyles.getPoppins(14.sp, 4.weight),
                ),
              ),
              20.ph,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Container(
                      width: Responsive.isMobile(context) ? Get.width : 300.w,
                      padding: EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.blackColor.withOpacity(0.2),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '\$ 25',
                            style: AppTextStyles.getPoppins(34.sp, 6.weight),
                          ),
                          10.ph,
                          Text(
                            "Average Ticket".tr,
                            style: AppTextStyles.getPoppins(14.sp, 4.weight),
                          ),
                        ],
                      ),
                    ).animate().moveY(
                      begin:
                          100, // start 100 pixels lower (you can increase for more bounce)
                      end: 0,
                      duration: 600.ms,
                      curve: Curves.bounceOut,
                    ),
                  ),
                  30.pw,
                  Flexible(
                    child: Container(
                      width: Responsive.isMobile(context) ? Get.width : 300.w,

                      padding: EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.blackColor.withOpacity(0.2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '0 hrs',
                            style: AppTextStyles.getPoppins(34.sp, 6.weight),
                          ),
                          10.ph,
                          Text(
                            "in Operation".tr,
                            style: AppTextStyles.getPoppins(14.sp, 4.weight),
                          ),
                        ],
                      ),
                    ).animate().moveY(
                      begin:
                          100, // start 100 pixels lower (you can increase for more bounce)
                      end: 0,
                      duration: 600.ms,
                      curve: Curves.bounceOut,
                    ),
                  ),
                ],
              ),
              20.ph,
              SlideInRight(
                child: Text(
                  "SERVICES RENDERED".tr,
                  style: AppTextStyles.getPoppins(14.sp, 4.weight),
                ),
              ),
              10.ph,
              SlideInRight(
                child: SizedBox(
                  height: 118.h,
                  child: ListView.builder(
                    itemCount: 5,
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final service = controller.services[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 15.0),

                        child: ServicesRendered(service: service),
                      );
                    },
                  ),
                ),
              ),
              20.ph,
              SlideInLeft(
                child: Row(
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
              ),
              10.ph,
              SlideInRight(
                child: SizedBox(
                  height: 115.h,
                  child: ListView.builder(
                    itemCount: controller.loadAppointments.length,
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 15.0, left: 3),

                        child: ClientAppointmentTile(
                          appointment: controller.loadAppointments[index],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
