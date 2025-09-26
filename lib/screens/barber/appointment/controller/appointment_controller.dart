import 'package:barber_select/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppointmentController extends GetxController {
  final fnSearch = FocusNode();
  final tecSearch = TextEditingController();
  final fnName = FocusNode();
  final fnPhone = FocusNode();
  final fnObservation = FocusNode();
  final fnValue = FocusNode();
  final fnNeighborhood = FocusNode();
  final fnNumber = FocusNode();
  final fnExtra = FocusNode();
  final fnCity = FocusNode();
  final fnState = FocusNode();
  final fnAppointmentDate = FocusNode();
  final tecName = TextEditingController();
  final tecPhone = TextEditingController();
  final tecObservation = TextEditingController();
  final tecValue = TextEditingController();
  final tecNeighborhood = TextEditingController();
  final tecNumber = TextEditingController();
  final tecExtra = TextEditingController();
  final tecCity = TextEditingController();
  final tecState = TextEditingController();
  final tecAppointmentDate = TextEditingController();
  RxBool isBookingCancelled = false.obs;

  var selectedDropdownMonth = 'January'.obs;
var selectedAppointmentTime = RxnString();
var selectedPaymentMethod = RxnString();

  Rx<RangeValues> serviceTimeRange = RangeValues(9.0, 10.0).obs;

  String formatTime(double hour) {
    final int hrs = hour.floor();
    final int mins = ((hour - hrs) * 60).round();
    final String formattedHour = hrs.toString().padLeft(2, '0');
    final String formattedMinute = mins.toString().padLeft(2, '0');
    return '$formattedHour:$formattedMinute';
  }

  RxList<bool> isSelectedList = List.generate(4, (_) => false).obs;

  void toggleSelection(int index) {
    isSelectedList[index] = !isSelectedList[index];
  }

  void updateSelectedMonth(String? value) {
    if (value != null) {
      selectedDropdownMonth.value = value;
    }
  }

  void updateSelectedPaymentMethod(String? value) {
    if (value != null) {
      selectedPaymentMethod.value = value;
    }
  }

  void updateSelectedAppointmentTime(String? value) {
    if (value != null) {
      selectedAppointmentTime.value = value;
    }
  }

  void pickAppointmentDate(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),

      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primaryColor,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      tecAppointmentDate.text =
          "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
    }
  }
}
