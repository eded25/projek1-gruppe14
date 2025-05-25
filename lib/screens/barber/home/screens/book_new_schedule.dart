import 'package:animate_do/animate_do.dart';
import 'package:barber_select/generated/assets.dart';
import 'package:barber_select/screens/barber/home/controller/barber_home_controller.dart';
import 'package:barber_select/screens/barber/home/screens/booking_completed_screen.dart';
import 'package:barber_select/screens/client/screens/find_barbers/components/service_registration_tile.dart';
import 'package:barber_select/utils/app_colors.dart';
import 'package:barber_select/utils/app_text_styles.dart';
import 'package:barber_select/utils/gaps.dart';
import 'package:barber_select/utils/responsive.dart';
import 'package:barber_select/widgets/custom_button.dart';
import 'package:barber_select/widgets/custom_drawer.dart';
import 'package:barber_select/widgets/custom_textform_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BookNewSchedule extends StatelessWidget {
  const BookNewSchedule({super.key});

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
                  20.ph,
                  Column(
                    children: [
                      SlideInRight(
                        child: Center(
                          child: Text(
                            "New Booking".tr,
                            style: AppTextStyles.getPoppins(
                              22.sp,
                              6.weight,
                              themeController.isDarkMode,
                              AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ),
                      SlideInRight(
                        child: Center(
                          child: Text(
                            "Fill in all fields to schedule a new booking".tr,
                            style: AppTextStyles.getPoppins(
                              14.sp,
                              4.weight,
                              themeController.isDarkMode,
                            ),
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
                          : AppColors.screenBg,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      20.ph,
                      CustomTextFormField(
                        fieldLabel: '',
                        focusNode: controller.fnClientName,
                        controller: controller.tecClientName,
                        borderColor: AppColors.whiteColor,
                        borderRadius: 8,
                        hintText: 'Name Client'.tr,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 12,
                        ),
                      ),
                      10.ph,
                      CustomTextFormField(
                        fieldLabel: '',
                        focusNode: controller.fnPhone,
                        controller: controller.tecPhone,
                        borderColor: AppColors.whiteColor,
                        borderRadius: 8,
                        textInputType: TextInputType.number,
                        hintText: 'Phone Number'.tr,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 12,
                        ),
                      ),
                      10.ph,
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
                      CustomCheckBoxDropdownField(
                        fieldLabel: '',
                        items: controller.allItems,
                        selectedItems: controller.selectedItems,
                        onChangedDropdown: controller.onDropdownChanged,
                        focusNode: FocusNode(),
                      ),
                      10.ph,

                      CustomDropdownField(
                        fieldLabel: '',
                        hintText: 'Start',
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

                      CustomDropdownField(
                        fieldLabel: '',
                        hintText: 'End time',
                        items:
                            [
                              '9:30',
                              '10:00',
                              '10:30',
                              '11:00',
                              '11:30',
                              '12:00',
                            ].obs,
                        selectedItem: controller.selectedEndAppointmentTime,
                        onChangedDropdown: (value) {
                          controller.updateSelectedEndAppointmentTime(value);
                        },
                        focusNode: FocusNode(),
                      ),
                      10.ph,
                      CustomButtonWidget(btnLabel: 'Free', borderRadius: 12),
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
                                  'Repeat this appointment'.tr,
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
                                                  hintText: 'Please select',
                                                  backgroundColor:
                                                      Get.isDarkMode
                                                          ? AppColors
                                                              .darkBgThree
                                                          : AppColors.screenBg,
                                                  fieldLabel: '',
                                                  items:
                                                      [
                                                        'One week (7 days)',
                                                        'Two weeks (14 days)',
                                                        'Three weeks (21 days)',
                                                        'One month (30 days)',
                                                      ].obs,
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
                                                'For:',
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
                                                  hintText: 'Please select',
                                                  backgroundColor:
                                                      Get.isDarkMode
                                                          ? AppColors
                                                              .darkBgThree
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
                                                  selectedItem:
                                                      controller.selectedFor,
                                                  onChangedDropdown: (value) {
                                                    controller
                                                        .updateSelectedFor(
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
                      10.ph,

                      CustomButtonWidget(
                        btnLabel: 'SCHEDULE'.tr,
                        borderRadius: 12,
                        onTap: () {
                          print(controller.selectedAppointmentDate.value.year);
                          print(controller.selectedAppointmentDate.value.month);
                          print(controller.selectedAppointmentDate.value.day);
                          controller.addUserAndSave();
                        },
                      ),
                    ],
                  ).animate().moveY(
                    begin:
                        100, // start 100 pixels lower (you can increase for more bounce)
                    end: 0,
                    duration: 600.ms,
                    curve: Curves.bounceOut,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
