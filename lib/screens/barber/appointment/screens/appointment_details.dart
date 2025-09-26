import 'package:animate_do/animate_do.dart';
import 'package:barber_select/models/appointment_model.dart';
import 'package:barber_select/screens/barber/appointment/controller/appointment_controller.dart';
import 'package:barber_select/screens/barber/appointment/screens/cancel_appointment.dart';
import 'package:barber_select/utils/app_colors.dart';
import 'package:barber_select/utils/app_text_styles.dart';
import 'package:barber_select/utils/gaps.dart';
import 'package:barber_select/widgets/custom_button.dart';
import 'package:barber_select/widgets/custom_drawer.dart';
import 'package:barber_select/widgets/custom_textform_field.dart';
import 'package:barcode/barcode.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../utils/responsive.dart';
import '../../../client/screens/bookings/controller/client_booking_controller.dart';

class AppointmentDetails extends StatelessWidget {
  const AppointmentDetails({super.key, this.appointmentModel, this.isClientSide=false});
  final AppointmentModel? appointmentModel;
  final isClientSide;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AppointmentController());
    final themeController = Get.find<CustomDrawerController>();
    final controller1 = Get.find<ClientBookingController>();
    final barcode = Barcode.code128(); // You can use other types too

    final svg = barcode.toSvg(
      '123456587 5698 3000',
      width: 300.w,
      height: 10.h,
      drawText: false, // Disable built-in text
    );
    return SafeArea(
      child: Scaffold(
        backgroundColor:
            Get.isDarkMode ? AppColors.darkScreenBg : AppColors.whiteColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            30.ph,
            SlideInRight(
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color:
                          Get.isDarkMode
                              ? AppColors.darkBgThree
                              : AppColors.iconContainerColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      children: [
                        Text(
                          "Schnell-Erinnerung".tr,
                          style: AppTextStyles.getPoppins(
                            12.sp,
                            4.weight,
                            themeController.isDarkMode,
                          ),
                        ),
                        10.pw,
                        Icon(Icons.notifications_active),
                      ],
                    ),
                  ),
                  10.pw,
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color:
                          Get.isDarkMode
                              ? AppColors.darkBgThree
                              : AppColors.iconContainerColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(child: Icon(Icons.upload_file_rounded)),
                  ),
                ],
              ),
            ).paddingSymmetric(horizontal: 20),
            20.ph,
            AppointmentDate(appointment: appointmentModel!),
            20.ph,
            Text(
             isClientSide?'BARBER'.tr: 'Kunde'.tr,
              style: AppTextStyles.getPoppins(
                14.sp,
                4.weight,
                themeController.isDarkMode,
              ),
            ).paddingOnly(left: 20),
            10.ph,
            CustomerDetails(appointment: appointmentModel!),
            10.ph,
            ServicesTile(appointment: appointmentModel!),
            10.ph,
            ProductTile(),
            10.ph,
            AppointmentPriceDetails(),
            10.ph,
            Row(
              children: [
                Container(
                  width: 10.w,
                  height: 20.h,
                  decoration: BoxDecoration(
                    color:
                        Get.isDarkMode
                            ? AppColors.whiteColor
                            : AppColors.blackColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                ),
                Flexible(
                  child: DottedLine(
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.center,
                    lineLength: double.infinity,
                    lineThickness: 1.0,
                    dashLength: 4.0,
                    dashColor:
                        Get.isDarkMode ? AppColors.whiteColor : Colors.black,

                    dashRadius: 0.0,
                    dashGapLength: 4.0,
                    dashGapColor: Colors.transparent,

                    dashGapRadius: 0.0,
                  ),
                ),
                Container(
                  width: 10.w,
                  height: 20.h,
                  decoration: BoxDecoration(
                    color:
                        Get.isDarkMode
                            ? AppColors.whiteColor
                            : AppColors.blackColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      bottomLeft: Radius.circular(50),
                    ),
                  ),
                ),
              ],
            ),
            10.ph,
            Center(
              child: SvgPicture.string(
                svg,
                color:
                    Get.isDarkMode
                        ? AppColors.whiteColor
                        : AppColors.blackColor,
              ),
            ),

            Center(
              child: Text(
                '123456587 5698 3000',
                style: AppTextStyles.getPoppins(
                  14.sp,
                  4.weight,
                  themeController.isDarkMode,
                ),
              ),
            ),
            10.ph,
            Center(
              child: SizedBox(
                width: 300.w,
                child: CustomButtonWidget(
                  btnLabel: 'Cancel  ${isClientSide?'Booking':'Appointment'}',
                  onTap: () {
                    controller.isBookingCancelled.value = false;
                    if(isClientSide){
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            backgroundColor: Colors.transparent,
                            child: Container(
                              width: 400.w,
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    Get.isDarkMode
                                        ? AppColors.darkBgThree
                                        : AppColors.whiteColor,

                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Obx(
                                    () => Text(
                                      "Sind Sie sicher, dass Sie die Buchung stornieren möchten?"
                                          .tr,
                                      textAlign: TextAlign.center,
                                      style: AppTextStyles.getPoppins(
                                        18.sp,
                                        6.weight,
                                        themeController.isDarkMode,
                                      ),
                                    ),
                                  ),
                                  10.ph,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 80.w,
                                        child: CustomButtonWidget(
                                          btnLabel: 'JA',
                                          bgColor: AppColors.primaryColor,
                                          borderRadius: 12,
                                          onTap: () {
                                            controller1.removeBooking(
                                              appointmentModel?.id??'1',
                                            );
                                            Get.back();
                                            Get.back();
                                          },
                                        ),
                                      ),
                                      20.pw,

                                      SizedBox(
                                        width: 80.w,
                                        child: Obx(
                                          () => CustomButtonWidget(
                                            borderRadius: 12,
                                            btnLabel: 'Zurück',
                                            bgColor: AppColors.blackColor.withOpacity(
                                              0.7,
                                            ),
                                            onTap: () {
                                              Get.back();
                                            },
                                            btnLabelStyle: AppTextStyles.getPoppins(
                                              Responsive.isMobile(context)
                                                  ? 16.sp
                                                  : 20.sp,
                                              7.weight,
                                              themeController.isDarkMode,
                                              AppColors.whiteColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ).paddingSymmetric(horizontal: 20),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }else {
                      Get.to(
                            () =>
                            CancelAppointment(appointment: appointmentModel!),
                      );
                    }
                  },
                ).paddingSymmetric(horizontal: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppointmentPriceDetails extends StatelessWidget {
  const AppointmentPriceDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AppointmentController>();
    final themeController = Get.find<CustomDrawerController>();
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dienstleistung:',
              style: AppTextStyles.getPoppins(
                16.sp,
                4.weight,
                themeController.isDarkMode,
              ),
            ),
            Row(
              children: [
                Text(
                  '\$ 30,00',
                  style: AppTextStyles.getPoppins(
                    20.sp,
                    6.weight,
                    themeController.isDarkMode,
                    AppColors.primaryColor,
                  ),
                ),
                10.pw,
                Text(
                  'Kreditkarte',
                  style: AppTextStyles.getPoppins(
                    16.sp,
                    4.weight,
                    themeController.isDarkMode,
                  ),
                ),
              ],
            ),
          ],
        ),
        Spacer(),
        InkWell(
          onTap: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              builder: (context) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      10.ph,
                      Text(
                        "Summe bearbeiten".tr,
                        style: AppTextStyles.getPoppins(
                          24.sp,
                          5.weight,
                          themeController.isDarkMode,
                        ),
                      ),
                      2.ph,
                      Text(
                        "Passen Sie den Betrag/die Zahlung bei Bedarf an".tr,
                        style: AppTextStyles.getPoppins(
                          16.sp,
                          4.weight,
                          themeController.isDarkMode,
                        ),
                      ),
                      10.ph,
                      Row(
                        children: [
                          Flexible(
                            child: CustomTextFormField(
                              fieldLabel: '',
                              focusNode: controller.fnName,
                              controller: controller.tecName,

                              hintText: 'Name'.tr,
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
                            child: CustomDropdownField(
                              fieldLabel: '',
                              items:
                                  [
                                    'Kreditkarte',
                                    'Debitkarte',
                                    'Bargeld',
                                    'Ungezahlt',
                                  ].obs,
                              selectedItem: controller.selectedPaymentMethod,
                              hintText: 'ZaHlungsmethode'.tr,
                              onChangedDropdown: (value) {
                                controller.updateSelectedPaymentMethod(value);
                              },
                              focusNode: FocusNode(),
                            ),
                          ),
                        ],
                      ),

                      10.ph,
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            Flexible(
                              child: SizedBox(
                                child: CustomButtonWidget(
                                  btnLabel: 'Zurück'.tr,
                                  borderRadius: 6,
                                  height: 45.h,

                                  bgColor: AppColors.primaryColor,
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
                                  bgColor: AppColors.primaryColor,
                                  onTap: () {},
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      40.ph,
                    ],
                  ),
                );
              },
            );
          },
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Icon(
                Icons.edit_square,
                size: 30,
                color:
                    Get.isDarkMode
                        ? AppColors.whiteColor
                        : AppColors.textBlackColor,
              ),
            ),
          ),
        ),
      ],
    ).paddingSymmetric(horizontal: 20);
  }
}

class ServicesTile extends StatelessWidget {
  const ServicesTile({super.key, required this.appointment});
  final AppointmentModel appointment;
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AppointmentController>();
    final themeController = Get.find<CustomDrawerController>();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'SERVICES'.tr,
              style: AppTextStyles.getPoppins(
                14.sp,
                4.weight,
                themeController.isDarkMode,
              ),
            ),
            InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (context) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
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
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          10.ph,
                          Text(
                            "Dienstleistung bearbeiten".tr,
                            style: AppTextStyles.getPoppins(
                              24.sp,
                              5.weight,
                              themeController.isDarkMode,
                            ),
                          ),
                          2.ph,
                          Text(
                            "Anpassung der Dienstleistung, falls erforderlich".tr,
                            style: AppTextStyles.getPoppins(
                              16.sp,
                              4.weight,
                              themeController.isDarkMode,
                            ),
                          ),
                          10.ph,
                          SizedBox(
                            height: 150.h,
                            child: Obx(
                              () => ListView.builder(
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.isSelectedList.length,
                                itemBuilder: (context, index) {
                                  final isSelected =
                                      controller.isSelectedList[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: Container(
                                      height: 150.h,
                                      width: 140.w,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        color:
                                            Get.isDarkMode
                                                ? AppColors.darkPrimaryColor
                                                : AppColors.primaryColor,
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 10,
                                            offset: Offset(4, 4),
                                            color: AppColors.blackColor
                                                .withOpacity(0.1),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.cut,
                                                color:
                                                    Get.isDarkMode
                                                        ? AppColors.whiteColor
                                                        : AppColors
                                                            .textBlackColor,
                                              ),
                                              Spacer(),
                                              Checkbox(
                                                visualDensity:
                                                    VisualDensity.compact,
                                                value: isSelected,
                                                side:
                                                    MaterialStateBorderSide.resolveWith(
                                                      (states) => BorderSide(
                                                        width: 1.0,
                                                        color:
                                                            AppColors
                                                                .blackColor,
                                                      ),
                                                    ),
                                                onChanged:
                                                    (_) => controller
                                                        .toggleSelection(index),
                                                activeColor: Colors.white,
                                                checkColor:
                                                    AppColors.blackColor,
                                              ),
                                            ],
                                          ),
                                          Text(
                                            'Haarschnitt mit Bart',
                                            style: AppTextStyles.getPoppins(
                                              13.sp,
                                              4.weight,
                                              themeController.isDarkMode,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '\$ 25',
                                                style: AppTextStyles.getPoppins(
                                                  12.sp,
                                                  4.weight,
                                                  themeController.isDarkMode,
                                                ),
                                              ),
                                              Text(
                                                '60 min',
                                                style: AppTextStyles.getPoppins(
                                                  12.sp,
                                                  4.weight,
                                                  themeController.isDarkMode,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          20.ph,
                          Row(
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
                                'Wischen Sie, um mehr zu sehen'.tr,
                                style: AppTextStyles.getPoppins(
                                  12.sp,
                                  4.weight,
                                  themeController.isDarkMode,
                                ),
                              ),
                            ],
                          ),
                          20.ph,
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,

                              children: [
                                Flexible(
                                  child: SizedBox(
                                    child: CustomButtonWidget(
                                      btnLabel: 'Zurück'.tr,
                                      borderRadius: 6,
                                      height: 45.h,

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

                                      onTap: () {},
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          20.ph,
                        ],
                      ),
                    );
                  },
                );
              },
              child: Text(
                'Bearbeiten'.tr,
                style: AppTextStyles.getPoppins(
                  14.sp,
                  6.weight,
                  themeController.isDarkMode,
                  AppColors.primaryColor,
                ),
              ),
            ),
          ],
        ),
        10.ph,
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color:
                    Get.isDarkMode
                        ? AppColors.darkBgThree
                        : AppColors.iconContainerColor,

                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.primaryColor),
              ),
              child: Center(
                child: Icon(
                  Icons.add,
                  color:
                      Get.isDarkMode
                          ? AppColors.darkModeTextColor
                          : AppColors.blackColor,
                  size: 40,
                ),
              ),
            ),
            10.pw,

            Flexible(
              child: SizedBox(
                height: 73.h,

                child: ListView.builder(
                  itemCount: appointment.haircuts.length,
                  physics: BouncingScrollPhysics(),

                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final services = appointment.haircuts[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        children: [
                          5.ph,

                          Container(
                            width: 100.w,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            height: 60.h,
                            decoration: BoxDecoration(
                              color:
                                  Get.isDarkMode
                                      ? AppColors.darkBgThree
                                      : AppColors.screenBg,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 5,
                                  color: AppColors.blackColor.withOpacity(0.2),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                services,
                                style: AppTextStyles.getPoppins(
                                  14.sp,
                                  4.weight,
                                  themeController.isDarkMode,
                                ),
                              ),
                            ),
                          ),
                          5.ph,
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        8.ph,
        Row(
          children: [
            Icon(
              Icons.arrow_right_alt_sharp,
              color:
                  Get.isDarkMode
                      ? AppColors.darkModeTextColor
                      : AppColors.blackColor,
              size: 30,
            ),
            Spacer(),
            Text(
              'Wischen Sie, um mehr zu sehen'.tr,
              style: AppTextStyles.getPoppins(
                12.sp,
                4.weight,
                themeController.isDarkMode,
              ),
            ),
          ],
        ),
      ],
    ).paddingSymmetric(horizontal: 20);
  }
}

class ProductTile extends StatelessWidget {
  const ProductTile({super.key});

  @override
  Widget build(BuildContext context) {

    final themeController = Get.find<CustomDrawerController>();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'PRODUCTS'.tr,
              style: AppTextStyles.getPoppins(
                14.sp,
                4.weight,
                themeController.isDarkMode,
              ),
            ),
          ],
        ),
        10.ph,
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color:
                    Get.isDarkMode
                        ? AppColors.darkBgThree
                        : AppColors.iconContainerColor,

                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.primaryColor),
              ),
              child: Center(
                child: Icon(
                  Icons.add,
                  color:
                      Get.isDarkMode
                          ? AppColors.darkModeTextColor
                          : AppColors.blackColor,
                  size: 40,
                ),
              ),
            ),
            10.pw,

            Flexible(
              child: SizedBox(
                height: 73.h,

                child: ListView.builder(
                  itemCount: 4,
                  physics: BouncingScrollPhysics(),

                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        children: [
                          5.ph,

                          Container(
                            width: 100.w,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            height: 60.h,
                            decoration: BoxDecoration(
                              color:
                                  Get.isDarkMode
                                      ? AppColors.darkBgThree
                                      : AppColors.screenBg,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 5,
                                  color: AppColors.blackColor.withOpacity(0.2),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                'Rasierschaum',
                                style: AppTextStyles.getPoppins(
                                  14.sp,
                                  4.weight,
                                  themeController.isDarkMode,
                                ),
                              ),
                            ),
                          ),
                          5.ph,
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        8.ph,
        Row(
          children: [
            Icon(
              Icons.arrow_right_alt_sharp,
              color:
                  Get.isDarkMode
                      ? AppColors.darkModeTextColor
                      : AppColors.blackColor,
              size: 30,
            ),
            Spacer(),
            Text(
              'Wischen Sie, um mehr zu sehen'.tr,
              style: AppTextStyles.getPoppins(
                12.sp,
                4.weight,
                themeController.isDarkMode,
              ),
            ),
          ],
        ),
      ],
    ).paddingSymmetric(horizontal: 20);
  }
}

class CustomerDetails extends StatelessWidget {
  const CustomerDetails({super.key, required this.appointment});
  final AppointmentModel appointment;
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AppointmentController>();
    final themeController = Get.find<CustomDrawerController>();
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              appointment.clientName,
              style: AppTextStyles.getPoppins(
                20.sp,
                6.weight,
                themeController.isDarkMode,
                AppColors.primaryColor,
              ),
            ),
            Text(
              appointment.phoneNumber,
              style: AppTextStyles.getPoppins(
                14.sp,
                4.weight,
                themeController.isDarkMode,
              ),
            ),
          ],
        ),
        Spacer(),
        InkWell(
          onTap: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              builder: (context) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      10.ph,
                      Text(
                        "Kunde bearbeiten".tr,
                        style: AppTextStyles.getPoppins(
                          24.sp,
                          5.weight,

                          themeController.isDarkMode,
                        ),
                      ),
                      2.ph,
                      Text(
                        "Bearbeiten Sie den Namen oder die Telefonnummer, falls erforderlich.".tr,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.getPoppins(
                          16.sp,
                          4.weight,

                          themeController.isDarkMode,
                        ),
                      ),
                      10.ph,
                      CustomTextFormField(
                        fieldLabel: '',
                        focusNode: controller.fnName,
                        controller: controller.tecName,

                        hintText: 'Name'.tr,
                        borderColor: AppColors.whiteColor,
                        borderRadius: 8,
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

                        hintText: 'Phone'.tr,
                        borderColor: AppColors.whiteColor,
                        borderRadius: 8,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 12,
                        ),
                      ),

                      10.ph,
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            Flexible(
                              child: SizedBox(
                                child: CustomButtonWidget(
                                  btnLabel: 'Zurück'.tr,
                                  borderRadius: 6,
                                  height: 45.h,

                                  bgColor: AppColors.primaryColor,
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
                                  bgColor: AppColors.primaryColor,
                                  onTap: () {},
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      20.ph,
                    ],
                  ),
                );
              },
            );
          },
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Icon(
                Icons.edit_square,
                size: 30,
                color:
                    Get.isDarkMode
                        ? AppColors.whiteColor
                        : AppColors.textBlackColor,
              ),
            ),
          ),
        ),
      ],
    ).paddingSymmetric(horizontal: 20);
  }
}

class AppointmentDate extends StatelessWidget {
  const AppointmentDate({super.key, required this.appointment});
  final AppointmentModel appointment;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AppointmentController>();
    final themeController = Get.find<CustomDrawerController>();
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat('EEEE, MMMM d, y').format(appointment.date),
              style: AppTextStyles.getPoppins(
                18.sp,
                5.weight,
                themeController.isDarkMode,
              ),
            ),
            Text(
              'My',
              style: AppTextStyles.getPoppins(
                14.sp,
                5.weight,
                themeController.isDarkMode,
              ),
            ),
            Text(
              '${DateFormat('hh:mm a').format(appointment.startTime)} to ${DateFormat('hh:mm a').format(appointment.endTime)}',
              style: AppTextStyles.getPoppins(
                14.sp,
                5.weight,
                themeController.isDarkMode,
              ),
            ),
          ],
        ),
        Spacer(),
        InkWell(
          onTap: () {
            
            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              builder: (context) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      10.ph,
                      Text(
                        "Datum bearbeiten".tr,
                        style: AppTextStyles.getPoppins(
                          24.sp,
                          5.weight,
                          themeController.isDarkMode,
                        ),
                      ),
                      2.ph,
                      Text(
                        "Bearbeiten Sie das Datum, falls erforderlich.".tr,
                        style: AppTextStyles.getPoppins(
                          16.sp,
                          4.weight,
                          themeController.isDarkMode,
                        ),
                      ),
                      10.ph,
                      CustomTextFormField(
                        fieldLabel: '',
                        focusNode: controller.fnAppointmentDate,
                        controller: controller.tecAppointmentDate,
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
                        hintText: 'Stunden',
                        selectedItem: controller.selectedAppointmentTime,
                        onChangedDropdown: (value) {
                          controller.updateSelectedAppointmentTime(value);
                        },
                        focusNode: FocusNode(),
                      ),
                      10.ph,
                      CustomButtonWidget(
                        btnLabel: 'Frei'.tr,
                        borderRadius: 6,
                        height: 45.h,
                        onTap: () {
                          Get.back();
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (context) {
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
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
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    10.ph,
                                    Text(
                                      "Frei Mode".tr,
                                      style: AppTextStyles.getPoppins(
                                        24.sp,
                                        5.weight,
                                        themeController.isDarkMode,
                                      ),
                                    ),
                                    2.ph,
                                    Text(
                                      "Termin mit verfügbarer Zeit".tr,
                                      style: AppTextStyles.getPoppins(
                                        16.sp,
                                        4.weight,
                                        themeController.isDarkMode,
                                      ),
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
                                      hintText: 'Stunden',
                                      selectedItem:
                                          controller.selectedAppointmentTime,
                                      onChangedDropdown: (value) {
                                        controller
                                            .updateSelectedAppointmentTime(
                                              value,
                                            );
                                      },
                                      focusNode: FocusNode(),
                                    ),
                                    10.ph,
                                    Text(
                                      'Dienstleistung von:'.tr,
                                      style: AppTextStyles.getPoppins(
                                        12.sp,
                                        4.weight,
                                        themeController.isDarkMode,
                                      ),
                                    ),
                                    10.ph,
                                    Obx(() {
                                      final start = controller.formatTime(
                                        controller.serviceTimeRange.value.start,
                                      );
                                      final end = controller.formatTime(
                                        controller.serviceTimeRange.value.end,
                                      );
                                      return Text(
                                        '$start - $end',
                                        style: AppTextStyles.getPoppins(
                                          16.sp,
                                          5.weight,
                                          themeController.isDarkMode,
                                        ),
                                      );
                                    }),
                                    10.ph,
                                    Text(
                                      'Bewegen Sie den Schieberegler, um den Beginn und das Ende des Dienstes auszuwählen'
                                          .tr,
                                      style: AppTextStyles.getPoppins(
                                        12.sp,
                                        5.weight,
                                        themeController.isDarkMode,
                                      ),
                                    ),
                                    10.ph,
                                    Obx(
                                      () => RangeSlider(
                                        activeColor: AppColors.primaryColor,
                                        values:
                                            controller.serviceTimeRange.value,
                                        min: 9.0,
                                        max: 12.0,
                                        divisions:
                                            6, // e.g., 30-minute intervals
                                        labels: RangeLabels(
                                          controller.formatTime(
                                            controller
                                                .serviceTimeRange
                                                .value
                                                .start,
                                          ),
                                          controller.formatTime(
                                            controller
                                                .serviceTimeRange
                                                .value
                                                .end,
                                          ),
                                        ),
                                        onChanged: (RangeValues values) {
                                          controller.serviceTimeRange.value =
                                              values;
                                        },
                                      ),
                                    ),
                                    10.ph,
                                    Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,

                                        children: [
                                          Flexible(
                                            child: SizedBox(
                                              child: CustomButtonWidget(
                                                btnLabel: 'Zurück'.tr,
                                                borderRadius: 6,
                                                height: 45.h,

                                                bgColor: AppColors.primaryColor,
                                                onTap: () {
                                                  Get.back();
                                                },
                                              ),
                                            ),
                                          ),
                                          10.pw,

                                          Flexible(
                                            child: SizedBox(
                                              child: CustomButtonWidget(
                                                btnLabel: 'Ok'.tr,
                                                borderRadius: 6,
                                                height: 45.h,
                                                bgColor: AppColors.primaryColor,
                                                onTap: () {
                                                  Get.back();
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    20.ph,
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                      10.ph,
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            Flexible(
                              child: SizedBox(
                                child: CustomButtonWidget(
                                  btnLabel: 'Zurück'.tr,
                                  borderRadius: 6,
                                  height: 45.h,

                                  bgColor: AppColors.primaryColor,
                                  onTap: () {
                                    Get.back();
                                  },
                                ),
                              ),
                            ),
                            10.pw,

                            Flexible(
                              child: SizedBox(
                                child: CustomButtonWidget(
                                  btnLabel: 'Ok'.tr,
                                  borderRadius: 6,
                                  height: 45.h,
                                  bgColor: AppColors.primaryColor,
                                  onTap: () {
                                    Get.back();
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      20.ph,
                    ],
                  ),
                );
              },
            );
          },
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Icon(
                Icons.edit_square,
                size: 30,
                color:
                    Get.isDarkMode
                        ? AppColors.whiteColor
                        : AppColors.textBlackColor,
              ),
            ),
          ),
        ),
      ],
    ).paddingSymmetric(horizontal: 20);
  }
}
