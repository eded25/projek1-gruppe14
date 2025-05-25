import 'package:animate_do/animate_do.dart';
import 'package:barber_select/screens/barber/my_clients/controller/my_clients_controller.dart';
import 'package:barber_select/screens/barber/my_clients/screens/add_new_client.dart';
import 'package:barber_select/screens/barber/my_clients/screens/client_analysis_screen.dart';
import 'package:barber_select/utils/app_colors.dart';
import 'package:barber_select/utils/app_text_styles.dart';
import 'package:barber_select/utils/gaps.dart';
import 'package:barber_select/utils/responsive.dart';
import 'package:barber_select/widgets/custom_button.dart';
import 'package:barber_select/widgets/custom_textform_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class MyClientsScreen extends StatelessWidget {
  const MyClientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyClientsController());
    return SafeArea(
      child: Scaffold(
        backgroundColor:
            Get.isDarkMode ? AppColors.darkBgThree : AppColors.screenBg,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                  "List".tr,
                  style: AppTextStyles.getPoppins(12.sp, 4.weight),
                ),
              ),
              SlideInRight(
                child: Text(
                  "Clients".tr,
                  style: AppTextStyles.getPoppins(30.sp, 5.weight),
                ),
              ),
              20.ph,
              SlideInRight(
                child: CustomTextFormField(
                  fieldLabel: '',
                  focusNode: controller.fnSearch,
                  controller: controller.tecSearch,
                  borderColor:
                      Get.isDarkMode
                          ? AppColors.darkScreenBg
                          : AppColors.whiteColor,
                  fillColor:
                      Get.isDarkMode
                          ? AppColors.darkScreenBg
                          : AppColors.whiteColor,
                  borderRadius: 0,
                  hintText: 'Search...'.tr,
                  suffix: Icon(Icons.person_search_rounded, size: 25),
                ),
              ),
              20.ph,
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: controller.clients.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final clients = controller.clients[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Container(
                          width: Get.width,
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color:
                                Get.isDarkMode
                                    ? AppColors.darkScreenBg
                                    : AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    clients.name,
                                    style: AppTextStyles.getPoppins(
                                      14.sp,
                                      6.weight,
                                    ),
                                  ),
                                  Text(
                                    clients.number,
                                    style: AppTextStyles.getPoppins(
                                      14.sp,
                                      4.weight,
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              ClientTileActions(
                                icon: FontAwesomeIcons.whatsapp,
                                onTap: () {},
                              ),
                              10.pw,
                              ClientTileActions(
                                icon: Icons.bar_chart_sharp,
                                onTap: () {
                                  Get.to(() => ClientAnalysisScreen());
                                },
                              ),
                              10.pw,
                              ClientTileActions(
                                icon: Icons.edit_square,
                                onTap: () {
                                  showModalBottomSheet(
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          color:
                                              Get.isDarkMode
                                                  ? AppColors.darkBgThree
                                                  : AppColors.screenBg,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(12),
                                            topRight: Radius.circular(12),
                                          ),
                                        ),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              10.ph,
                                              Text(
                                                "Edit Client".tr,
                                                style: AppTextStyles.getPoppins(
                                                  24.sp,
                                                  5.weight,
                                                ),
                                              ),
                                              2.ph,
                                              Text(
                                                "Edit customer data if necessary."
                                                    .tr,
                                                style: AppTextStyles.getPoppins(
                                                  16.sp,
                                                  4.weight,
                                                ),
                                              ),
                                              10.ph,
                                              CustomTextFormField(
                                                fieldLabel: '',
                                                focusNode: controller.fnName,
                                                controller: controller.tecName,
                                                borderColor:
                                                    AppColors.whiteColor,
                                                borderRadius: 8,
                                                hintText: 'Name'.tr,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 12,
                                                    ),
                                              ),
                                              10.ph,
                                              CustomTextFormField(
                                                fieldLabel: '',
                                                focusNode: controller.fnPhone,
                                                controller: controller.tecPhone,
                                                borderColor:
                                                    AppColors.whiteColor,
                                                borderRadius: 8,
                                                hintText: 'Phone Number'.tr,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 12,
                                                    ),
                                              ),
                                              10.ph,
                                              CustomDropdownField(
                                                fieldLabel: '',
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
                                                hintText: 'Birthday Month',
                                                selectedItem:
                                                    controller
                                                        .selectedDropdownMonth,
                                                onChangedDropdown: (value) {
                                                  controller
                                                      .updateSelectedMonth(
                                                        value,
                                                      );
                                                },
                                                focusNode: FocusNode(),
                                              ),
                                              10.ph,
                                              CustomTextFormField(
                                                fieldLabel: '',
                                                focusNode:
                                                    controller.fnObservation,
                                                controller:
                                                    controller.tecObservation,
                                                borderColor:
                                                    AppColors.whiteColor,
                                                borderRadius: 8,
                                                hintText: 'Observation'.tr,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 12,
                                                    ),
                                              ),
                                              10.ph,
                                              CustomTextFormField(
                                                fieldLabel: '',
                                                focusNode: controller.fnValue,
                                                controller: controller.tecValue,
                                                borderColor:
                                                    AppColors.whiteColor,
                                                borderRadius: 8,
                                                hintText: 'Value'.tr,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
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
                                                ),
                                              ),
                                              15.ph,
                                              Row(
                                                children: [
                                                  Flexible(
                                                    child: CustomTextFormField(
                                                      fieldLabel: '',
                                                      focusNode:
                                                          controller.fnNumber,
                                                      controller:
                                                          controller.tecNumber,
                                                      borderColor:
                                                          AppColors.whiteColor,
                                                      borderRadius: 8,
                                                      hintText: 'Number'.tr,
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                            horizontal: 10,
                                                            vertical: 12,
                                                          ),
                                                    ),
                                                  ),
                                                  10.pw,
                                                  Flexible(
                                                    child: CustomTextFormField(
                                                      fieldLabel: '',
                                                      focusNode:
                                                          controller.fnExtra,
                                                      controller:
                                                          controller.tecExtra,
                                                      borderColor:
                                                          AppColors.whiteColor,
                                                      borderRadius: 8,
                                                      hintText:
                                                          'Extra Information'
                                                              .tr,
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
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
                                                focusNode:
                                                    controller.fnNeighborhood,
                                                controller:
                                                    controller.tecNeighborhood,
                                                borderColor:
                                                    AppColors.whiteColor,
                                                borderRadius: 8,
                                                hintText: 'Neighborhood',
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 12,
                                                    ),
                                              ),
                                              10.ph,
                                              CustomTextFormField(
                                                fieldLabel: '',
                                                focusNode: controller.fnCity,
                                                controller: controller.tecCity,
                                                borderColor:
                                                    AppColors.whiteColor,
                                                borderRadius: 8,
                                                hintText: 'City',
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 12,
                                                    ),
                                              ),
                                              10.ph,
                                              CustomTextFormField(
                                                fieldLabel: '',
                                                focusNode: controller.fnState,
                                                controller: controller.tecState,
                                                borderColor:
                                                    AppColors.whiteColor,
                                                borderRadius: 8,
                                                hintText: 'State',
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 12,
                                                    ),
                                              ),
                                              20.ph,
                                              Center(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,

                                                  children: [
                                                    Flexible(
                                                      child: SizedBox(
                                                        child: CustomButtonWidget(
                                                          btnLabel: 'Back',
                                                          borderRadius: 6,
                                                          height: 45.h,

                                                          bgColor:
                                                              AppColors
                                                                  .primaryColor,
                                                          onTap: () {},
                                                        ),
                                                      ),
                                                    ),
                                                    10.pw,

                                                    Flexible(
                                                      child: SizedBox(
                                                        child: CustomButtonWidget(
                                                          btnLabel: 'Ok',
                                                          borderRadius: 6,
                                                          height: 45.h,
                                                          bgColor:
                                                              AppColors
                                                                  .primaryColor,
                                                          onTap: () {},
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              2.ph,
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ).animate().moveY(
                    begin:
                        100, // start 100 pixels lower (you can increase for more bounce)
                    end: 0,
                    duration: 600.ms,
                    curve: Curves.bounceOut,
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor:
              Get.isDarkMode ? Color(0xff9B783F) : Color(0xffE2BB80),
          onPressed: () {
            Get.to(() => AddNewClient());
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class ClientTileActions extends StatelessWidget {
  const ClientTileActions({super.key, required this.icon, required this.onTap});
  final IconData icon;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 40.w,
        height: 60.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color:
              Get.isDarkMode
                  ? AppColors.darkPrimaryColor
                  : AppColors.primaryColor,
        ),
        child: Center(
          child: FaIcon(
            icon,
            color:
                Get.isDarkMode ? AppColors.darkBgThree : AppColors.whiteColor,
          ),
        ),
      ),
    );
  }
}
