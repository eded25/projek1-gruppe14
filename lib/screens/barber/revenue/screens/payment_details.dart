import 'package:animate_do/animate_do.dart';
import 'package:barber_select/screens/barber/appointment/screens/appointment_details.dart';
import 'package:barber_select/utils/app_colors.dart';
import 'package:barber_select/utils/app_text_styles.dart';
import 'package:barber_select/utils/gaps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PaymentDetails extends StatelessWidget {
  const PaymentDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:
            Get.isDarkMode ? AppColors.darkBgThree : AppColors.screenBg,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              30.ph,
              SlideInRight(
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(Icons.arrow_back, color: AppColors.primaryColor),
                ),
              ),
              40.ph,
              SlideInRight(
                child: Text(
                  'Analyze'.tr,
                  style: AppTextStyles.getPoppins(14.sp, 4.weight),
                ),
              ),
              SlideInRight(
                child: Text(
                  'Cash'.tr,
                  style: AppTextStyles.getPoppins(32.sp, 5.weight),
                ),
              ),
              20.ph,
              SlideInUp(
                child: Container(
                  width: Get.width,
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color:
                        Get.isDarkMode
                            ? AppColors.darkScreenBg
                            : AppColors.whiteColor,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5,
                        color: AppColors.blackColor.withOpacity(0.3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '8:15-08:45 February 27, 2024',
                            style: AppTextStyles.getPoppins(14.sp, 4.weight),
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              // Get.to(
                              //   () => AppointmentDetails(),
                              //   transition: Transition.downToUp,
                              // );
                            },
                            child: Icon(
                              Icons.more_horiz_outlined,
                              color:
                                  Get.isDarkMode
                                      ? AppColors.whiteColor
                                      : AppColors.blackColor,
                            ),
                          ),
                        ],
                      ),
                      15.ph,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "San Tiago",
                            style: AppTextStyles.getPoppins(16.sp, 6.weight),
                          ),
                          Row(
                            children: [
                              Text(
                                'Full Beard',
                                style: AppTextStyles.getPoppins(
                                  12.sp,
                                  4.weight,
                                ),
                              ),
                              Spacer(),
                              Text(
                                '\$ 55',
                                style: AppTextStyles.getPoppins(
                                  12.sp,
                                  6.weight,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
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
