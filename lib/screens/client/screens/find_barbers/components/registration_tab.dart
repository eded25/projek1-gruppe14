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
import 'package:barber_select/services/api_service.dart';
import 'package:barber_select/screens/auth/controller/auth_controller.dart';

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
                          color:
                              controller.selectedPaymentMethod.value == 'Cash'
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
                            (controller.selectedPaymentMethod.value == 'Cash')
                                .obs,
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
                        _showCardPaymentSheet(
                            context); // show bottom sheet immediately
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color:
                              controller.selectedPaymentMethod.value == 'Card'
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
                            (controller.selectedPaymentMethod.value == 'Card')
                                .obs,
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

                  // 0) Auswahl prüfen
                  if (findController.selectedTimes.isEmpty) {
                    Get.snackbar('Hinweis', 'Bitte Uhrzeit wählen');
                    return;
                  }
                  if (controller.tecDate.text.isEmpty) {
                    Get.snackbar('Hinweis', 'Bitte Datum wählen');
                    return;
                  }

                  // 1) ausgewählte Services + Preis
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

                  if (selectedServices.isEmpty) {
                    Get.snackbar('Hinweis',
                        'Bitte mindestens eine Dienstleistung auswählen');
                    return;
                  }

                  // 2) Date + Time -> MySQL-Format
                  final dateStr = controller.tecDate.text; // z.B. '25/09/2025'
                  final timeStr =
                      findController.selectedTimes.first; // z.B. '11:00'
                  final dt = _combineDateTime(dateStr, timeStr);
                  final mysql = DateFormat('yyyy-MM-dd HH:mm:ss').format(dt);

                  try {
                    // 3) Slot sicherstellen (erstellt oder findet slot_id)
                    // Barber-ID (String) in int umwandeln
                    final parsedBarberId = int.tryParse(user.userId);
                    if (parsedBarberId == null || parsedBarberId <= 0) {
                      Get.snackbar(
                          'Fehler', 'Ungültige Barber-ID: ${user.userId}');
                      return;
                    }

// Slot anlegen/holen – ACHTUNG: Semikolon am Ende!
                    final ensure = await ApiService.ensureSlot(
                      barberId: parsedBarberId,
                      dateTimeIso: mysql,
                      durationMin: 30,
                    );

                    if (ensure['status'] != 'success') {
                      Get.snackbar(
                          'Fehler',
                          ensure['message']?.toString() ??
                              'Slot nicht verfügbar');
                      return;
                    }

                    final slotId = int.parse(ensure['slot_id'].toString());

                    // 4) Reservation anlegen
                    // Todo: die aktuelle eingeloggte userId aus deinem Auth-State holen

                    final auth = Get.find<AuthController>();

                    final int currentUserId = auth.currentUserId.value is int
                        ? auth.currentUserId.value!
                        : int.parse(auth.currentUserId.value.toString());

                    final res = await ApiService.createReservation(
                      userId: currentUserId,
                      slotId: slotId,
                      paymentMethod: controller.selectedPaymentMethod.value
                          .toLowerCase(), // 'cash' | 'card'
                    );

                    if (res['status'] == 'success') {
                      // (optional) lokal in deinem bestehenden Mock-Store weiterführen
                      final booking = BookingRequest(
                        requestId: res['reservation_id'].toString(),
                        barberName: user.name,
                        selectedTimes: findController.selectedTimes,
                        services: selectedServices,
                        barberRating: user.rating,
                        price: totalPrice,
                        date: controller.tecDate.text,
                      );
                      await bookingController.saveBooking(booking);

                      // UI-Feedback/Bestätigung
                      final formatted =
                          DateFormat("MMMM d, yyyy 'at' HH:mm").format(dt);
                      Get.snackbar(
                          'OK', 'Termin angefragt ${res['reservation_id']}');
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (_) => Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.check_circle_rounded,
                                    color: AppColors.primaryColor, size: 36),
                                12.ph,
                                Text("Registration Completed!",
                                    style: AppTextStyles.getPoppins(
                                        16.sp, 6.weight)),
                                8.ph,
                                Text(
                                  'You have an appointment with ${booking.barberName} on $formatted.',
                                  textAlign: TextAlign.center,
                                  style:
                                      AppTextStyles.getPoppins(12.sp, 4.weight),
                                ),
                                12.ph,
                                CustomButtonWidget(
                                    btnLabel: 'OK', onTap: () => Get.back()),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      Get.snackbar('Fehler',
                          res['message']?.toString() ?? 'Unbekannter Fehler');
                    }

                    if (controller.selectedPaymentMethod.value == 'Card') {
                      Get.snackbar(
                          'Payment', 'Your payment has been processed.');
                    }
                  } catch (e) {
                    Get.snackbar('Exception', e.toString());
                  }
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
            color: controller.selectedTimes.contains(time)
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
      backgroundColor:
          Get.isDarkMode ? AppColors.darkScreenBg : AppColors.whiteColor,
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

TimeOfDay _parseTime(String hhmm) {
  final p = hhmm.split(':');
  return TimeOfDay(hour: int.parse(p[0]), minute: int.parse(p[1]));
}

DateTime _combineDateTime(String ddMMyyyy, String hhmm) {
  // dd/MM/yyyy + HH:mm -> DateTime
  final dt = DateFormat('dd/MM/yyyy HH:mm').parse('$ddMMyyyy $hhmm');
  return dt;
}
