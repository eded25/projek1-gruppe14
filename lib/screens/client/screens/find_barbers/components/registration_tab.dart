import 'package:barber_select/models/booking_request_model.dart';
import 'package:barber_select/models/user_model.dart';
import 'package:barber_select/screens/client/screens/bookings/controller/client_booking_controller.dart';
import 'package:barber_select/screens/client/screens/find_barbers/components/service_registration_tile.dart';
import 'package:barber_select/screens/client/screens/find_barbers/controller/find_barber_controller.dart';
import 'package:barber_select/utils/app_colors.dart';
import 'package:barber_select/utils/app_text_styles.dart';
import 'package:barber_select/utils/gaps.dart';
import 'package:barber_select/widgets/custom_button.dart';
import 'package:barber_select/widgets/custom_drawer.dart';
import 'package:barber_select/widgets/custom_textform_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RegistrationTab extends StatelessWidget {
  const RegistrationTab({super.key, required this.user});
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FindBarberController>();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          20.ph,
          Text(
            'Available Times:'.tr,
            style: AppTextStyles.getPoppins(14.sp, 5.weight),
          ),
          15.ph,
          CustomTextFormField(
            fieldLabel: '',
            focusNode: controller.fnDate,
            controller: controller.tecDate,
            isViewMode: true,
            hintText: 'dd/mm/yy',
            backgroundColor: AppColors.greyColor,
            borderColor: AppColors.whiteColor,
            borderRadius: 8,
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            onTap: () => controller.pickAppointmentDate(context),
          ),
          15.ph,

          Wrap(
            spacing: 20,
            runSpacing: 15,
            children: [
              _buildTimeSlot("10:00"),
              _buildTimeSlot("11:00"),
              _buildTimeSlot("12:00"),
              _buildTimeSlot("13:00"),
              _buildTimeSlot("14:00"),
              _buildTimeSlot("15:00"),
              _buildTimeSlot("16:00"),
              _buildTimeSlot("17:00"),
              _buildTimeSlot("18:00"),
              _buildTimeSlot("19:00"),
              _buildTimeSlot("20:00"),
              _buildTimeSlot("21:00"),
            ],
          ).paddingOnly(left: 2),
          30.ph,
          ServiceRegistrationTile(
            title: 'Cut - 40',
            onTap: controller.toggleCut,
            isOn: controller.isCut,
          ),
          15.ph,
          ServiceRegistrationTile(
            title: 'Beard - 30',
            onTap: controller.toggleBeard,
            isOn: controller.isBeard,
          ),
          15.ph,
          ServiceRegistrationTile(
            title: 'Cut and Beard - 35',
            onTap: controller.toggleCutBeard,
            isOn: controller.isCutBeard,
          ),
          15.ph,
          ServiceRegistrationTile(
            title: 'Dye hair - 30',
            onTap: controller.toggleDyeHair,
            isOn: controller.isDyeHair,
          ),
          10.ph,
          Text(
            'Select Payment Method'.tr,
            style: AppTextStyles.getPoppins(14.sp, 5.weight),
          ),
          10.ph,
          Obx(() => Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    controller.selectedPaymentMethod.value = 'Cash';
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: controller.selectedPaymentMethod.value == 'Cash'
                          ? AppColors.primaryColor
                          : Get.isDarkMode
                          ? AppColors.darkScreenBg
                          : AppColors.greyColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Cash'.tr,
                      style: AppTextStyles.getPoppins(
                        13.sp,
                        5.weight,
                        (controller.selectedPaymentMethod.value == 'Cash').obs,
                        AppColors.textBlackColor,
                      ),
                    ),
                  ),
                ),
              ),
              15.pw,
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    controller.selectedPaymentMethod.value = 'Card';
                    _showCardPaymentSheet(context); // show bottom sheet immediately
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: controller.selectedPaymentMethod.value == 'Card'
                          ? AppColors.primaryColor
                          : Get.isDarkMode
                          ? AppColors.darkScreenBg
                          : AppColors.greyColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Card'.tr,
                      style: AppTextStyles.getPoppins(
                        13.sp,
                        5.weight,
                        (controller.selectedPaymentMethod.value == 'Card').obs,
                        AppColors.textBlackColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
          30.ph,

          Center(
            child: SizedBox(
              width: 200.w,
              child: CustomButtonWidget(
                btnLabel: 'FINISH'.tr,
                onTap: () async {

                  final findController = Get.find<FindBarberController>();
                  final bookingController = Get.find<ClientBookingController>();

                  final selectedServices = <String>[];
                  double totalPrice = 0;

                  if (findController.isCut.value) {
                    selectedServices.add('Cut');
                    totalPrice += 40;
                  }
                  if (findController.isBeard.value) {
                    selectedServices.add('Beard');
                    totalPrice += 30;
                  }
                  if (findController.isCutBeard.value) {
                    selectedServices.add('Cut and Beard');
                    totalPrice += 35;
                  }
                  if (findController.isDyeHair.value) {
                    selectedServices.add('Dye hair');
                    totalPrice += 30;
                  }

                  final booking = BookingRequest(
                    requestId: DateTime.now().millisecondsSinceEpoch.toString(),
                    barberName: user.name,
                    selectedTimes: findController.selectedTimes,
                    services: selectedServices,
                    barberRating: user.rating, // Replace with actual rating
                    price: totalPrice,
                    date: controller.tecDate.text,
                  );

                  if (selectedServices.isEmpty) {
                    return;
                  }
                  if (findController.selectedTimes.isEmpty) {
                    return;
                  }
                  if (findController.tecDate.text.isEmpty) {
                    return;
                  }

                  await bookingController.saveBooking(booking).then((_) {
                    if(controller.selectedPaymentMethod.value == 'Card')
                    Get.snackbar(
                      'Payment Success'.tr,
                      'Your payment has been processed.'.tr,
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: AppColors.primaryColor.withOpacity(0.2),
                      colorText: AppColors.blackColor,
                    );
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        final selectedDateStr =
                            controller.tecDate.text; // e.g., '19/05/2025'
                        final selectedTimeStr =
                            findController.selectedTimes.first; // e.g., '11:00'

                        final combined =
                            '$selectedDateStr $selectedTimeStr'; // '19/05/2025 11:00'

                        // Parse the combined string to DateTime
                        final selectedDateTime = DateFormat(
                          'dd/MM/yyyy HH:mm',
                        ).parse(combined);

                        // Format to desired output, e.g., 'May 19, 2025 at 11:00 AM'
                        final formattedDateTime = DateFormat(
                          'MMMM d, yyyy \'at\' HH:mm',
                        ).format(selectedDateTime);
                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Container(
                            width: 300.w,

                            padding: EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  Get.isDarkMode
                                      ? AppColors.darkScreenBg
                                      : AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: InkWell(
                                    onTap: () {
                                      // Get.close(3);
                                      Get.back();
                                      // Get.back();

                                    },
                                    child: Icon(
                                      Icons.close,
                                      color:
                                          Get.isDarkMode
                                              ? AppColors.whiteColor
                                              : AppColors.blackColor,
                                    ),
                                  ),
                                ),

                                Icon(
                                  Icons.check_circle_rounded,
                                  color: AppColors.primaryColor,
                                ),

                                Text(
                                  "Registration Completed!",
                                  style: AppTextStyles.getPoppins(
                                    14.sp,
                                    6.weight,
                                  ),
                                ),
                                20.ph,
                                Text(
                                  'Leonardo, You have an appointment scheduled with ${booking.barberName} on $formattedDateTime for a hair cutting service.',
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.getPoppins(
                                    12.sp,
                                    4.weight,
                                  ),
                                ),
                                10.ph,
                                Text(
                                  'Thank you for your choice! We will send you a reminder 1 hour before the appointment.'
                                      .tr,
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.getPoppins(
                                    12.sp,
                                    4.weight,
                                  ),
                                ),
                                10.ph,
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  });
                },
              ),
            ),
          ),
          60.ph,
        ],
      ),
    );
  }

  Widget _buildTimeSlot(String time) {
    final controller = Get.find<FindBarberController>();
    final themeController = Get.find<CustomDrawerController>();
    return Obx(
      () => GestureDetector(
        onTap: () => controller.toggleTimeSelection(time),
        child: Container(
          width: 60.w,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            color:
                controller.selectedTimes.contains(time)
                    ? AppColors.primaryColor
                    : Get.isDarkMode
                    ? AppColors.darkScreenBg
                    : AppColors.whiteColor,

            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                blurRadius: 5,
                color: AppColors.blackColor.withOpacity(0.2),
              ),
            ],
          ),
          child: Text(
            time,
            style: AppTextStyles.getPoppins(
              14.sp,
              5.weight,
              themeController.isDarkMode,

              AppColors.textBlackColor,
            ),
          ),
        ),
      ),
    );
  }



  void _showCardPaymentSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      backgroundColor: Get.isDarkMode ? AppColors.darkScreenBg : AppColors.whiteColor,
      builder: (context) {
        final TextEditingController cardNumber = TextEditingController();
        final TextEditingController expiry = TextEditingController();
        final TextEditingController cvv = TextEditingController();

        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20,
            right: 20,
            top: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Enter Card Details'.tr,
                style: AppTextStyles.getPoppins(16.sp, 6.weight),
              ),
              20.ph,
              CustomTextFormField(
                focusNode: FocusNode(),
                fieldLabel: 'Card Number',
                controller: cardNumber,
                hintText: 'Card Number',
                // keyboardType: TextInputType.number,
              ),
              10.ph,
              Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      focusNode: FocusNode(),
                      fieldLabel: 'Date',
                      controller: expiry,
                      hintText: 'MM/YY',
                      // keyboardType: TextInputType.datetime,
                    ),
                  ),
                  10.pw,
                  Expanded(
                    child: CustomTextFormField(
                      focusNode: FocusNode(),
                      fieldLabel: 'CVV',
                      controller: cvv,
                      hintText: 'CVV',
                      // keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              20.ph,
              CustomButtonWidget(
                btnLabel: 'PAY'.tr,
                onTap: () {
                  // Call payment processing here
                  Get.back();

                },
              ),
              20.ph,
            ],
          ),
        );
      },
    );
  }

}
