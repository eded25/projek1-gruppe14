
import 'package:barber_select/screens/barber/appointment/screens/appointment_details.dart';
import 'package:barber_select/screens/barber/home/components/barber_header.dart';
import 'package:barber_select/screens/barber/home/controller/barber_home_controller.dart';
import 'package:barber_select/screens/barber/home/screens/book_new_schedule.dart';
import 'package:barber_select/utils/responsive.dart';
import 'package:barber_select/widgets/custom_drawer.dart';
import 'package:barber_select/utils/app_colors.dart';
import 'package:barber_select/utils/app_text_styles.dart';
import 'package:barber_select/utils/gaps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';


class BarberHomeScreen extends StatelessWidget {
  const BarberHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BarberHomeController());
    final themeController = Get.find<CustomDrawerController>();
    final double hourHeight = 150.h; // Height for each hour row
    return Obx(
      () => SafeArea(
        child: Scaffold(
          key: controller.scaffoldKey,
          backgroundColor:
              themeController.isDarkMode.value
                  ? AppColors.darkBgSecondary
                  : Color(0xffEBEFF1),
          drawer: CustomDrawer(isBarber: true),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Obx(
                  () => Container(
                    width: 400.w,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color:
                          themeController.isDarkMode.value
                              ? AppColors.darkScreenBg
                              : AppColors.whiteColor,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 5,
                          color: AppColors.blackColor.withOpacity(0.3),
                        ),
                      ],
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      children: [
                        BarberHeader(),
                        30.ph,
                        Obx(
                          () => Column(
                            children: [
                              // Top date range and arrows
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.calendar_today, size: 20),
                                      SizedBox(width: 8),
                                      Obx(
                                        () => Text(
                                          '${controller.formatDate(controller.weekDates.first)} - ${controller.formatDate(controller.weekDates.last)}',
                                          style: AppTextStyles.getPoppins(
                                            14.sp,
                                            5.weight,
                                            themeController.isDarkMode,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          controller.goToPreviousWeek();
                                        },
                                        child: Obx(
                                          () => Icon(
                                            Icons.chevron_left,
                                            size: 40.w,
                                            color:
                                                themeController.isDarkMode.value
                                                    ? AppColors
                                                        .darkModeTextColor
                                                    : AppColors.blackColor,
                                          ),
                                        ),
                                      ),

                                      InkWell(
                                        onTap: () {
                                          controller.goToNextWeek();
                                        },
                                        child: Obx(
                                          () => Icon(
                                            Icons.chevron_right,
                                            size: 40.w,
                                            color:
                                                themeController.isDarkMode.value
                                                    ? AppColors
                                                        .darkModeTextColor
                                                    : AppColors.blackColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              3.ph,
                              // Days of the week
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: List.generate(
                                  controller.weekDates.length,
                                  (index) {
                                    final day = controller.weekDates[index];
                                    final isSelected =
                                        index == controller.selectedIndex.value;

                                    return GestureDetector(
                                      onTap: () => controller.selectDay(index),
                                      child: Container(
                                        width: 40.w,
                                        height: 60.h,
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 5,
                                              color: AppColors.blackColor
                                                  .withOpacity(0.3),
                                            ),
                                          ],
                                          color:
                                              isSelected
                                                  ? AppColors.primaryColor
                                                  : themeController
                                                      .isDarkMode
                                                      .value
                                                  ? AppColors.blackColor
                                                  : AppColors
                                                      .iconContainerColor,
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Obx(
                                              () => Text(
                                                DateFormat(
                                                  'EEE',
                                                ).format(day).toUpperCase(),
                                                style: AppTextStyles.getPoppins(
                                                  12.sp,
                                                  5.weight,
                                                  themeController.isDarkMode,
                                                ),
                                              ),
                                            ),
                                            3.ph,
                                            Obx(
                                              () => Text(
                                                '${day.day}',
                                                style: AppTextStyles.getPoppins(
                                                  14.sp,
                                                  5.weight,
                                                  themeController.isDarkMode,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ).paddingOnly(left: 2);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        20.ph,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Container(
                                width:
                                    Responsive.isMobile(context)
                                        ? Get.width
                                        : 300.w,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.blackColor.withOpacity(
                                        0.2,
                                      ),
                                      blurRadius: 10,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    5.ph,
                                    Obx(
                                      () => Text(
                                        'Today'.tr,
                                        style: AppTextStyles.getPoppins(
                                          12.sp,
                                          5.weight,
                                          themeController.isDarkMode,
                                        ),
                                      ),
                                    ),
                                    4.ph,

                                    Row(
                                      children: [
                                        Icon(
                                          Icons.monetization_on,
                                          color: AppColors.blackColor,
                                        ),
                                        10.pw,
                                        Obx(
                                          () => Text(
                                            controller.showBalance.value
                                                ? '\$ 150'
                                                : "****",
                                            style: AppTextStyles.getPoppins(
                                              14.sp,
                                              5.weight,
                                              themeController.isDarkMode,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Obx(
                                          () => Text(
                                            "8",
                                            style: AppTextStyles.getPoppins(
                                              34.sp,
                                              6.weight,
                                              themeController.isDarkMode,
                                            ),
                                          ),
                                        ),
                                        Icon(Icons.auto_graph_rounded),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            30.pw,
                            Flexible(
                              child: Obx(
                                () => Container(
                                  width:
                                      Responsive.isMobile(context)
                                          ? Get.width
                                          : 300.w,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        themeController.isDarkMode.value
                                            ? AppColors.blackColor
                                            : AppColors.screenBg,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.blackColor.withOpacity(
                                          0.3,
                                        ),
                                        blurRadius: 5,
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      5.ph,
                                      Obx(
                                        () => Text(
                                          'This Week'.tr,
                                          style: AppTextStyles.getPoppins(
                                            12.sp,
                                            5.weight,
                                            themeController.isDarkMode,
                                          ),
                                        ),
                                      ),
                                      4.ph,

                                      Row(
                                        children: [
                                          Icon(
                                            Icons.monetization_on,
                                            color:
                                                themeController.isDarkMode.value
                                                    ? AppColors
                                                        .darkModeTextColor
                                                    : AppColors.blackColor,
                                          ),
                                          10.pw,
                                          Obx(
                                            () => Text(
                                              controller.showBalance.value
                                                  ? '\$ 180'
                                                  : "****",
                                              style: AppTextStyles.getPoppins(
                                                14.sp,
                                                5.weight,
                                                themeController.isDarkMode,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Obx(
                                            () => Text(
                                              "6",
                                              style: AppTextStyles.getPoppins(
                                                34.sp,
                                                6.weight,
                                                themeController.isDarkMode,
                                              ),
                                            ),
                                          ),
                                          Icon(
                                            Icons.auto_graph_rounded,
                                            color:
                                                themeController.isDarkMode.value
                                                    ? AppColors
                                                        .darkModeTextColor
                                                    : AppColors.blackColor,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        20.ph,
                      ],
                    ),
                  ),
                ),
                20.ph,
                Obx(() {
                  final today = DateTime.now();
                  final totalHeight =
                      hourHeight * 24 + 80; // for full 24-hour height + padding

                  return SingleChildScrollView(
                    child: SizedBox(
                      height: totalHeight,
                      child: Stack(
                        children: [
                          // Time lines (background grid)
                          ListView.builder(
                            physics:
                                const NeverScrollableScrollPhysics(), // disable inner scroll
                            itemCount: 24,
                            itemBuilder: (_, index) {
                              final hour =
                                  '${index.toString().padLeft(2, '0')}:00';
                              return SizedBox(
                                height: hourHeight,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    10.pw,
                                    SizedBox(
                                      width: 70,
                                      child: Obx(
                                        () => Text(
                                          hour,
                                          style: AppTextStyles.getPoppins(
                                            16.sp,
                                            5.weight,
                                            themeController.isDarkMode,
                                          ),
                                        ),
                                      ),
                                    ),
                                    10.pw,
                                    Expanded(
                                      child: Divider(
                                        color: Colors.grey.shade400,
                                        thickness: 0.8,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          // Appointments
                          ...controller.appointments
                              .where(
                                (a) =>
                                    a.startTime.year ==
                                        controller.selectedDate.value.year &&
                                    a.startTime.month ==
                                        controller.selectedDate.value.month &&
                                    a.startTime.day ==
                                        controller.selectedDate.value.day,
                              )
                              .map((appointment) {
                                final start = appointment.startTime;
                                final end = appointment.endTime;
                                final startHour =
                                    start.hour + start.minute / 60;
                                final endHour = end.hour + end.minute / 60;
                                final top = startHour * hourHeight;
                                final height =
                                    (endHour - startHour) * hourHeight;

                                return Positioned(
                                  top: top + 70,
                                  right: 0,
                                  width: 280,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Obx(
                                      () => Container(
                                        height: height,
                                        decoration: BoxDecoration(
                                          color:
                                              themeController.isDarkMode.value
                                                  ? Color(0xff897B6A)
                                                  : Color(0xffD1B090),
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        padding: const EdgeInsets.all(12),
                                        child: Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Obx(
                                                  () => Text(
                                                    appointment.clientName ??
                                                        '',
                                                    style:
                                                        AppTextStyles.getPoppins(
                                                          14.sp,
                                                          5.weight,
                                                          themeController
                                                              .isDarkMode,
                                                        ),
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                Obx(
                                                  () => Text(
                                                    '${_formatTime(start)} - ${_formatTime(end)}',
                                                    style:
                                                        AppTextStyles.getPoppins(
                                                          14.sp,
                                                          5.weight,
                                                          themeController
                                                              .isDarkMode,
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Spacer(),
                                            InkWell(
                                              onTap: () {
                                                Get.to(
                                                  () => AppointmentDetails(
                                                    appointmentModel:
                                                        appointment,
                                                  ),
                                                );
                                              },
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: Icon(
                                                  Icons.more_vert,
                                                  size: 25,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              })
                              .toList(),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
          bottomSheet: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
            child: Row(
              children: [
                InkWell(
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.clear();
                    // Get.to(
                    //   () => ScheduleCloseScreen(),
                    //   transition: Transition.downToUp,
                    // );
                  },
                  child: Obx(
                    () => Container(
                      width: 60.w,
                      height: 60.h,
                      decoration: BoxDecoration(
                        color:
                            themeController.isDarkMode.value
                                ? AppColors.blackColor
                                : AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            color: AppColors.blackColor.withOpacity(0.2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Icon(
                          Icons.lock,
                          color:
                              themeController.isDarkMode.value
                                  ? AppColors.whiteColor
                                  : AppColors.blackColor,
                          size: 30.w,
                        ),
                      ),
                    ),
                  ),
                ),
                20.pw,
                Flexible(
                  child: InkWell(
                    onTap: () {
                      Get.to(() => BookNewSchedule());
                    },
                    child: Container(
                      height: 60.h,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      width: Get.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primaryColor,
                            AppColors.primaryColor2,
                          ],
                        ),
                      ),
                      child: Row(
                        children: [
                          Obx(
                            () => Text(
                              "New Schedule".tr,
                              style: AppTextStyles.getPoppins(
                                15.sp,
                                6.weight,
                                themeController.isDarkMode,
                                AppColors.whiteColor,
                              ),
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_right_alt_sharp,
                            color: AppColors.whiteColor,
                            size: 40,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
