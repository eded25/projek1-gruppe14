import 'package:barber_select/generated/assets.dart';
import 'package:barber_select/screens/barber/appointment/controller/appointment_controller.dart';
import 'package:barber_select/screens/barber/home/controller/barber_home_controller.dart';
import 'package:barber_select/screens/barber/home/screens/barber_home_screen.dart';
import 'package:barber_select/screens/client/screens/find_barbers/components/service_registration_tile.dart';
import 'package:barber_select/utils/app_colors.dart';
import 'package:barber_select/utils/app_text_styles.dart';
import 'package:barber_select/utils/gaps.dart';
import 'package:barber_select/utils/responsive.dart';
import 'package:barber_select/widgets/custom_button.dart';
import 'package:barber_select/widgets/custom_drawer.dart';
import 'package:barber_select/widgets/custom_textform_field.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ScheduleCloseScreen extends StatelessWidget {
  const ScheduleCloseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BarberHomeController>();
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
              decoration: BoxDecoration(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  20.ph,
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  20.ph,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'Schedule Close'.tr,
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
                          : AppColors.screenBg,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                child: Column(
                  children: [
                    20.ph,
                    CustomTextFormField(
                      fieldLabel: '',
                      focusNode: controller.fnDate,
                      controller: controller.tecDate,
                      isViewMode: true,
                      hintText: 'dd/mm/yy',
                      borderColor: AppColors.whiteColor,
                      borderRadius: 8,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 12,
                      ),
                      onTap: () => controller.pickAppointmentDate(context),
                    ),
                    10.ph,
                    CustomDropdownField(
                      fieldLabel: '',
                      items:
                          [
                            '9:30',
                            '10:00',
                            '10:30',
                            '11:00',
                            '11:30',
                            '12:00',
                          ].obs,
                      selectedItem: controller.selectedStartAppointmentTime,
                      onChangedDropdown: (value) {
                        controller.updateSelectedStartAppointmentTime(value);
                      },
                      focusNode: FocusNode(),
                    ),
                    10.ph,
                    Center(
                      child: Text(
                        'Closes from:'.tr,
                        style: AppTextStyles.getPoppins(
                          14.sp,
                          4.weight,
                          themeController.isDarkMode,
                        ),
                      ),
                    ).animate().moveY(
                      begin:
                          100, // start 100 pixels lower (you can increase for more bounce)
                      end: 0,
                      duration: 600.ms,
                      curve: Curves.bounceOut,
                    ),
                    10.ph,
                    Row(
                      children: [
                        Flexible(
                          child: CustomTextFormField(
                            fieldLabel: '',
                            focusNode: controller.fnCloseFrom,
                            controller: controller.tecCloseTo,

                            hintText: '00:00',
                            borderColor: AppColors.whiteColor,
                            borderRadius: 8,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 12,
                            ),
                          ),
                        ),
                        20.pw,
                        Flexible(
                          child: CustomTextFormField(
                            fieldLabel: '',
                            focusNode: controller.fnCloseTo,
                            controller: controller.tecCloseTo,

                            hintText: '00:00',
                            borderColor: AppColors.whiteColor,
                            borderRadius: 8,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    10.ph,
                    Center(
                      child: Text(
                        '09:00 - 12:00',
                        style: AppTextStyles.getPoppins(
                          20.sp,
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
                    10.ph,
                    CustomTextFormField(
                      fieldLabel: '',
                      focusNode: controller.fnDescription,
                      controller: controller.tecDescription,

                      hintText: 'Description'.tr,
                      borderColor: AppColors.whiteColor,
                      borderRadius: 8,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 12,
                      ),
                    ),
                    10.ph,
                    Container(
                      width: Get.width,
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color:
                            Get.isDarkMode
                                ? AppColors.darkScreenBg
                                : AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Repeat this closure'.tr,
                                style: AppTextStyles.getPoppins(
                                  14.sp,
                                  5.weight,
                                  themeController.isDarkMode,
                                ),
                              ),
                              Spacer(),
                              SwitchWidget(
                                controller: controller,
                                onTap: controller.toggleRepeat,
                                isOn: controller.isRepeat,
                              ),
                            ],
                          ),
                          Obx(
                            () =>
                                controller.isRepeat.value
                                    ? Column(
                                      children: [
                                        10.ph,
                                        Row(
                                          children: [
                                            Text(
                                              'Every:'.tr,
                                              style: AppTextStyles.getPoppins(
                                                14.sp,
                                                5.weight,
                                                themeController.isDarkMode,
                                              ),
                                            ),
                                            Spacer(),
                                            SizedBox(
                                              width: 220.w,
                                              child: CustomDropdownField(
                                                backgroundColor:
                                                    Get.isDarkMode
                                                        ? AppColors.darkBgThree
                                                        : AppColors.screenBg,
                                                fieldLabel: '',
                                                items:
                                                    [
                                                      'One week (7 days)',
                                                      'Two weeks (14 days)',
                                                      'Three weeks (21 days)',
                                                      'One month (30 days)',
                                                    ].obs,
                                                hintText: 'Please select',
                                                selectedItem:
                                                    controller.selectedEvery,
                                                onChangedDropdown: (value) {
                                                  controller
                                                      .updateSelectedEvery(
                                                        value,
                                                      );
                                                },
                                                focusNode: FocusNode(),
                                              ),
                                            ),
                                          ],
                                        ),
                                        10.ph,
                                        Row(
                                          children: [
                                            Text(
                                              'For:'.tr,
                                              style: AppTextStyles.getPoppins(
                                                14.sp,
                                                5.weight,
                                                themeController.isDarkMode,
                                              ),
                                            ),
                                            Spacer(),
                                            SizedBox(
                                              width: 220.w,
                                              child: CustomDropdownField(
                                                backgroundColor:
                                                    Get.isDarkMode
                                                        ? AppColors.darkBgThree
                                                        : AppColors.screenBg,
                                                fieldLabel: '',
                                                items:
                                                    [
                                                      '1 month',
                                                      '3 months',
                                                      '6 months',
                                                      '12 months',
                                                      '24 months',
                                                    ].obs,
                                                hintText: 'Please select',
                                                selectedItem:
                                                    controller.selectedFor,
                                                onChangedDropdown: (value) {
                                                  controller.updateSelectedFor(
                                                    value,
                                                  );
                                                },
                                                focusNode: FocusNode(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                    : SizedBox(),
                          ),
                        ],
                      ),
                    ),
                    20.ph,
                    CustomButtonWidget(
                      btnLabel: 'CLOSE SCHEDULE'.tr,
                      borderRadius: 12,
                      onTap: () {
                        Get.back();
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
