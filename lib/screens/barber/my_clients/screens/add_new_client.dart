import 'package:animate_do/animate_do.dart';
import 'package:barber_select/screens/barber/my_clients/controller/my_clients_controller.dart';
import 'package:barber_select/utils/app_colors.dart';
import 'package:barber_select/utils/app_text_styles.dart';
import 'package:barber_select/utils/gaps.dart';
import 'package:barber_select/widgets/custom_button.dart';
import 'package:barber_select/widgets/custom_drawer.dart';
import 'package:barber_select/widgets/custom_textform_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddNewClient extends StatelessWidget {
  const AddNewClient({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MyClientsController>();
    final themeController = Get.find<CustomDrawerController>();
    return SafeArea(
      child: Scaffold(
        backgroundColor:
            Get.isDarkMode ? AppColors.darkBgThree : AppColors.screenBg,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                40.ph,
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
                30.ph,
                SlideInRight(
                  child: Text(
                    "Add a".tr,
                    style: AppTextStyles.getPoppins(
                      14.sp,
                      4.weight,
                      themeController.isDarkMode,
                    ),
                  ),
                ),
                SlideInRight(
                  child: Text(
                    "New Client".tr,
                    style: AppTextStyles.getPoppins(
                      24.sp,
                      5.weight,
                      themeController.isDarkMode,
                    ),
                  ),
                ),
                20.ph,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextFormField(
                      fieldLabel: '',
                      focusNode: controller.fnName,
                      controller: controller.tecName,
                      borderColor: AppColors.whiteColor,
                      borderRadius: 8,
                      hintText: 'Name'.tr,
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
                      hintText: 'Phone Number'.tr,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 12,
                      ),
                    ),
                    10.ph,
                    CustomDropdownField(
                      fieldLabel: '',
                      hintText: 'Birthday Month',
                      items:
                          [
                            'January',
                            'February',
                            'March',
                            'April',
                            'May',
                            'June',
                            'July',
                            'August',
                            'September',
                            'October',
                            'November',
                            'December',
                          ].obs,
                      selectedItem: controller.selectedDropdownMonth,

                      onChangedDropdown: (value) {
                        controller.updateSelectedMonth(value);
                      },
                      focusNode: FocusNode(),
                    ),
                    10.ph,
                    CustomTextFormField(
                      fieldLabel: '',
                      focusNode: controller.fnObservation,
                      controller: controller.tecObservation,
                      borderColor: AppColors.whiteColor,
                      borderRadius: 8,
                      hintText: 'Observation'.tr,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 12,
                      ),
                    ),
                    10.ph,
                    CustomTextFormField(
                      fieldLabel: '',
                      focusNode: controller.fnValue,
                      controller: controller.tecValue,
                      borderColor: AppColors.whiteColor,
                      borderRadius: 8,
                      hintText: 'Value'.tr,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 12,
                      ),
                    ),
                    10.ph,
                    Text(
                      "Address Client".tr,
                      style: AppTextStyles.getPoppins(
                        14.sp,
                        4.weight,
                        themeController.isDarkMode,
                      ),
                    ),
                    15.ph,
                    Row(
                      children: [
                        Flexible(
                          child: CustomTextFormField(
                            fieldLabel: '',
                            focusNode: controller.fnNumber,
                            controller: controller.tecNumber,
                            borderColor: AppColors.whiteColor,
                            borderRadius: 8,
                            hintText: 'Number'.tr,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 12,
                            ),
                          ),
                        ),
                        10.pw,
                        Flexible(
                          child: CustomTextFormField(
                            fieldLabel: '',
                            focusNode: controller.fnExtra,
                            controller: controller.tecExtra,
                            borderColor: AppColors.whiteColor,
                            borderRadius: 8,
                            hintText: 'Extra Information'.tr,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    10.ph,
                    CustomTextFormField(
                      fieldLabel: '',
                      focusNode: controller.fnNeighborhood,
                      controller: controller.tecNeighborhood,
                      borderColor: AppColors.whiteColor,
                      borderRadius: 8,
                      hintText: 'Neighborhood'.tr,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 12,
                      ),
                    ),
                    10.ph,
                    CustomTextFormField(
                      fieldLabel: '',
                      focusNode: controller.fnCity,
                      controller: controller.tecCity,
                      borderColor: AppColors.whiteColor,
                      borderRadius: 8,
                      hintText: 'City'.tr,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 12,
                      ),
                    ),
                    10.ph,
                    CustomTextFormField(
                      fieldLabel: '',
                      focusNode: controller.fnState,
                      controller: controller.tecState,
                      borderColor: AppColors.whiteColor,
                      borderRadius: 8,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 12,
                      ),
                      hintText: 'State'.tr,
                    ),
                    20.ph,
                    CustomButtonWidget(
                      btnLabel: 'SAVE'.tr,
                      onTap: () {
                        controller.addUserAndSave();
                      },
                      borderRadius: 6,
                      height: 50.h,
                    ),
                  ],
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
      ),
    );
  }
}
