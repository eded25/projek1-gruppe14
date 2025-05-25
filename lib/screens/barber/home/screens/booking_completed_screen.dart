import 'package:barber_select/generated/assets.dart';
import 'package:barber_select/models/appointment_model.dart';
import 'package:barber_select/screens/barber/appointment/controller/appointment_controller.dart';
import 'package:barber_select/screens/barber/home/screens/barber_home_screen.dart';
import 'package:barber_select/utils/app_colors.dart';
import 'package:barber_select/utils/app_text_styles.dart';
import 'package:barber_select/utils/gaps.dart';
import 'package:barber_select/utils/responsive.dart';
import 'package:barber_select/widgets/custom_button.dart';
import 'package:barber_select/widgets/custom_drawer.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BookingCompletedScreen extends StatelessWidget {
  final AppointmentModel appointment;
  const BookingCompletedScreen({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<CustomDrawerController>();
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: Get.width,
              height: Get.height * 0.2,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Assets.barberImage2),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: Get.width,
              height: Get.height * 0.2,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.greenColor.withOpacity(0.9),
                    AppColors.greenColor.withOpacity(0.9),
                  ],
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

                  20.ph,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Icon(Icons.check_circle, color: Colors.green),
                      ),
                      10.ph,
                      Center(
                        child: Text(
                          'Booking Completed'.tr,
                          style: AppTextStyles.getPoppins(
                            22.sp,
                            6.weight,
                            themeController.isDarkMode,

                            AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned.fill(
              top:
                  Responsive.isMobile(context)
                      ? 130.h
                      : Responsive.isDesktop(context)
                      ? 155.h
                      : 155.h,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),

                decoration: BoxDecoration(
                  color:
                      Get.isDarkMode
                          ? AppColors.darkBgThree
                          : AppColors.whiteColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                child: Column(
                  children: [
                    20.ph,
                    Text(
                      DateFormat('EEEE, MMMM d, y').format(appointment.date),
                      style: AppTextStyles.getPoppins(
                        14.sp,
                        4.weight,
                        themeController.isDarkMode,
                      ),
                    ),
                    5.ph,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${DateFormat('hh:mm a').format(appointment.startTime)}",
                          style: AppTextStyles.getPoppins(
                            16.sp,
                            6.weight,
                            themeController.isDarkMode,
                          ),
                        ),
                        SizedBox(
                          width: 100.w,
                          child: DottedLine(
                            direction: Axis.horizontal,
                            alignment: WrapAlignment.center,
                            lineLength: double.infinity,
                            lineThickness: 2.0,
                            dashLength: 4.0,
                            dashColor:
                                Get.isDarkMode ? Colors.white : Colors.black,

                            dashRadius: 0.0,
                            dashGapLength: 4.0,
                            dashGapColor: Colors.transparent,

                            dashGapRadius: 0.0,
                          ),
                        ),
                        Text(
                          "${DateFormat('hh:mm a').format(appointment.endTime)}",
                          style: AppTextStyles.getPoppins(
                            18.sp,
                            6.weight,
                            themeController.isDarkMode,
                          ),
                        ),
                      ],
                    ),
                    5.ph,
                    Text(
                      appointment.clientName,
                      style: AppTextStyles.getPoppins(
                        20.sp,
                        6.weight,
                        themeController.isDarkMode,

                        AppColors.primaryColor,
                      ),
                    ),
                    5.ph,
                    Text(
                      "${appointment.haircuts.join(', ')} - \$ 25,00",
                      style: AppTextStyles.getPoppins(
                        14.sp,
                        4.weight,
                        themeController.isDarkMode,
                      ),
                    ),
                    20.ph,
                    CustomButtonWidget(
                      btnLabel: 'OK'.tr,
                      borderRadius: 12,
                      onTap: () {
                        Get.offAll(
                          () => BarberHomeScreen(),
                          transition: Transition.upToDown,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
