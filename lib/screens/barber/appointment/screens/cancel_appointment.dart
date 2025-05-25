import 'package:barber_select/generated/assets.dart';
import 'package:barber_select/models/appointment_model.dart';
import 'package:barber_select/screens/barber/appointment/controller/appointment_controller.dart';
import 'package:barber_select/screens/barber/home/controller/barber_home_controller.dart';
import 'package:barber_select/screens/barber/home/screens/barber_home_screen.dart';
import 'package:barber_select/utils/app_colors.dart';
import 'package:barber_select/utils/app_text_styles.dart';
import 'package:barber_select/utils/gaps.dart';
import 'package:barber_select/utils/responsive.dart';
import 'package:barber_select/widgets/custom_button.dart';
import 'package:barber_select/widgets/custom_drawer.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CancelAppointment extends StatelessWidget {
  final AppointmentModel appointment;
  const CancelAppointment({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AppointmentController>();
    final homeController = Get.find<BarberHomeController>();
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
            Obx(
              () => Container(
                width: Get.width,
                height: Get.height * 0.2,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors:
                        controller.isBookingCancelled.value
                            ? [
                              AppColors.greenColor.withOpacity(0.9),
                              AppColors.greenColor.withOpacity(0.9),
                            ]
                            : [
                              AppColors.redColor.withOpacity(0.9),
                              AppColors.redColor.withOpacity(0.9),
                            ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  20.ph,
                  InkWell(
                    onTap: () async {
                      if (controller.isBookingCancelled.value) {
                        final idToRemove = appointment.id;
                        await homeController.removeAppointmentById(idToRemove);
                        Get.offAll(() => BarberHomeScreen());
                      } else {
                        Get.back();
                      }
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  20.ph,
                  Obx(
                    () =>
                        !controller.isBookingCancelled.value
                            ? Column(
                              children: [
                                Center(
                                  child: Text(
                                    "Cancellation".tr,
                                    style: AppTextStyles.getPoppins(
                                      22.sp,
                                      6.weight,
                                      themeController.isDarkMode,
                                      AppColors.primaryColor,
                                    ),
                                  ).animate().moveY(
                                    begin:
                                        100, // start 100 pixels lower (you can increase for more bounce)
                                    end: 0,
                                    duration: 600.ms,
                                    curve: Curves.bounceOut,
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    "You are about to cancel this appointment"
                                        .tr,
                                    style: AppTextStyles.getPoppins(
                                      14.sp,
                                      5.weight,
                                      themeController.isDarkMode,

                                      AppColors.primaryColor,
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
                            )
                            : Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                  ),
                                ),
                                10.ph,
                                Center(
                                  child: Text(
                                      'Booking Cancelled'.tr,
                                      style: AppTextStyles.getPoppins(
                                        18.sp,
                                        6.weight,
                                        themeController.isDarkMode,

                                        AppColors.primaryColor,
                                      ),
                                    )
                                    ..animate().moveY(
                                      begin:
                                          100, // start 100 pixels lower (you can increase for more bounce)
                                      end: 0,
                                      duration: 600.ms,
                                      curve: Curves.bounceOut,
                                    ),
                                ),
                              ],
                            ),
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
                    Obx(
                      () => Text(
                        DateFormat('EEEE, MMMM d, y').format(appointment.date),
                        style: AppTextStyles.getPoppins(
                          14.sp,
                          4.weight,
                          themeController.isDarkMode,
                        ).copyWith(
                          decoration:
                              controller.isBookingCancelled.value
                                  ? TextDecoration.lineThrough
                                  : null,
                        ),
                      ).animate().moveY(
                        begin:
                            100, // start 100 pixels lower (you can increase for more bounce)
                        end: 0,
                        duration: 600.ms,
                        curve: Curves.bounceOut,
                      ),
                    ),
                    5.ph,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx(
                          () => Text(
                            '${DateFormat('hh:mm a').format(appointment.startTime)}',
                            style: AppTextStyles.getPoppins(
                              16.sp,
                              6.weight,
                              themeController.isDarkMode,
                            ).copyWith(
                              decoration:
                                  controller.isBookingCancelled.value
                                      ? TextDecoration.lineThrough
                                      : null,
                            ),
                          ).animate().moveY(
                            begin:
                                100, // start 100 pixels lower (you can increase for more bounce)
                            end: 0,
                            duration: 600.ms,
                            curve: Curves.bounceOut,
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
                                Get.isDarkMode
                                    ? AppColors.whiteColor
                                    : AppColors.blackColor,

                            dashRadius: 0.0,
                            dashGapLength: 4.0,
                            dashGapColor: Colors.transparent,

                            dashGapRadius: 0.0,
                          ),
                        ).animate().moveY(
                          begin:
                              100, // start 100 pixels lower (you can increase for more bounce)
                          end: 0,
                          duration: 600.ms,
                          curve: Curves.bounceOut,
                        ),
                        Obx(
                          () => Text(
                            '${DateFormat('hh:mm a').format(appointment.endTime)}',
                            style: AppTextStyles.getPoppins(
                              16.sp,
                              6.weight,
                              themeController.isDarkMode,
                            ).copyWith(
                              decoration:
                                  controller.isBookingCancelled.value
                                      ? TextDecoration.lineThrough
                                      : null,
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
                    5.ph,
                    Obx(
                      () => Text(
                        appointment.clientName,
                        style: AppTextStyles.getPoppins(
                          20.sp,
                          6.weight,
                          themeController.isDarkMode,

                          AppColors.primaryColor,
                        ).copyWith(
                          decoration:
                              controller.isBookingCancelled.value
                                  ? TextDecoration.lineThrough
                                  : null,
                        ),
                      ).animate().moveY(
                        begin:
                            100, // start 100 pixels lower (you can increase for more bounce)
                        end: 0,
                        duration: 600.ms,
                        curve: Curves.bounceOut,
                      ),
                    ),
                    5.ph,
                    Obx(
                      () => Text(
                        "${appointment.haircuts.join(', ')} - \$ 25,00",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.getPoppins(
                          14.sp,
                          4.weight,
                          themeController.isDarkMode,
                        ).copyWith(
                          decoration:
                              controller.isBookingCancelled.value
                                  ? TextDecoration.lineThrough
                                  : null,
                        ),
                      ).animate().moveY(
                        begin:
                            100, // start 100 pixels lower (you can increase for more bounce)
                        end: 0,
                        duration: 600.ms,
                        curve: Curves.bounceOut,
                      ),
                    ),
                    20.ph,
                    CustomButtonWidget(
                      btnLabel: 'OK',
                      borderRadius: 12,
                      onTap: () async {
                        if (controller.isBookingCancelled.value) {
                          final idToRemove = appointment.id;
                          await homeController.removeAppointmentById(
                            idToRemove,
                          );
                          Get.offAll(() => BarberHomeScreen());
                        } else {
                          controller.isBookingCancelled.value = true;
                        }
                      },
                    ).animate().moveY(
                      begin:
                          100, // start 100 pixels lower (you can increase for more bounce)
                      end: 0,
                      duration: 600.ms,
                      curve: Curves.bounceOut,
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
