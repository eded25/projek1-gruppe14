import 'package:barber_select/models/appointment_model.dart';
import 'package:barber_select/screens/barber/appointment/screens/appointment_details.dart';
import 'package:barber_select/utils/app_colors.dart';
import 'package:barber_select/utils/app_text_styles.dart';
import 'package:barber_select/utils/gaps.dart';
import 'package:barber_select/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ClientAppointmentTile extends StatelessWidget {
  final AppointmentModel appointment;
  const ClientAppointmentTile({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<CustomDrawerController>();
    return Column(
      children: [
        5.ph,
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),

          width: 290.w,
          decoration: BoxDecoration(
            color:
                Get.isDarkMode ? AppColors.darkScreenBg : AppColors.whiteColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppColors.blackColor.withOpacity(0.2),

                blurRadius: 5,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "${DateFormat('hh:mm a').format(appointment.startTime)}- ${DateFormat('hh:mm a').format(appointment.endTime)}",
                    style: AppTextStyles.getPoppins(
                      12.sp,
                      4.weight,
                      themeController.isDarkMode,
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.notifications,
                    color:
                        Get.isDarkMode
                            ? AppColors.darkModeTextColor
                            : AppColors.textBlackColor,
                  ),
                  10.pw,
                  InkWell(
                    onTap: () {
                      Get.to(
                        () => AppointmentDetails(appointmentModel: appointment),
                        transition: Transition.downToUp,
                      );
                    },
                    child: Icon(
                      Icons.more_horiz_outlined,
                      color:
                          Get.isDarkMode
                              ? AppColors.darkModeTextColor
                              : AppColors.textBlackColor,
                    ),
                  ),
                ],
              ),

              5.ph,
              Text(
                appointment.clientName,
                style: AppTextStyles.getPoppins(
                  14.sp,
                  6.weight,
                  themeController.isDarkMode,
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 150.w,
                    child: Text(
                      appointment.haircuts.join(', '),
                      style: AppTextStyles.getPoppins(
                        12.sp,
                        4.weight,
                        themeController.isDarkMode,
                      ),
                      maxLines: 1,
                    ),
                  ),
                  Spacer(),
                  Text(
                    '\$25,00',
                    style: AppTextStyles.getPoppins(
                      12.sp,
                      6.weight,
                      themeController.isDarkMode,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        5.ph,
      ],
    );
  }
}
