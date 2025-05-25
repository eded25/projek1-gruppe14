import 'package:barber_select/models/appointment_model.dart';
import 'package:barber_select/screens/barber/home/screens/booking_completed_screen.dart';
import 'package:barber_select/services/prefs.dart';
import 'package:barber_select/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class BarberHomeController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final fnClientName = FocusNode();
  final fnPhone = FocusNode();
  final fnDate = FocusNode();
  final fnCloseFrom = FocusNode();
  final fnCloseTo = FocusNode();
  final fnDescription = FocusNode();
  final tecClientName = TextEditingController();
  final tecPhone = TextEditingController();
  final tecDate = TextEditingController();
  final tecCloseFrom = TextEditingController();
  final tecCloseTo = TextEditingController();
  final tecDescription = TextEditingController();
  var selectedStartAppointmentTime = RxnString();
  var selectedEndAppointmentTime = RxnString();
  var selectedEvery = RxnString();
  var selectedFor = RxnString();
  RxBool showBalance = false.obs;
  Rx<DateTime> selectedAppointmentDate = DateTime.now().obs;

  Rx<DateTime> selectedDate = DateTime.now().obs;
  RxInt selectedIndex = 0.obs;
  RxList<DateTime> weekDates = <DateTime>[].obs;

  RxList<AppointmentModel> appointments = <AppointmentModel>[].obs;
  DateTime now = DateTime.now();
  RxList<AppointmentModel> loadAppointments = <AppointmentModel>[].obs;
  MeetingDataSource get dataSource => MeetingDataSource(appointments);
  void initializeAppointments() {
    DateTime now = DateTime.now();
    loadAppointments.assignAll([
      AppointmentModel(
        id: '1',
        clientName: 'John',
        phoneNumber: '923191-00001',
        startTime: DateTime(now.year, now.month, now.day, 1, 0),
        endTime: DateTime(now.year, now.month, now.day, 2, 0),
        date: now,
        haircuts: ['Fade Cut'],
        isRepeat: false,
      ),
      AppointmentModel(
        id: '2',
        clientName: 'Noah',
        phoneNumber: '923191-00002',
        startTime: DateTime(now.year, now.month, now.day, 9, 30),
        endTime: DateTime(now.year, now.month, now.day, 10, 30),
        date: now,
        haircuts: ['Crew Cut'],
        isRepeat: true,
        repeatAfter: 7,
        repeatFor: 4,
      ),
    ]);
  }

  void addUserAndSave() async {
    final appointment = AppointmentModel(
      id: DateTime.now().toIso8601String(),
      clientName: tecClientName.text,
      phoneNumber: tecPhone.text,
      startTime: DateTime(
        selectedAppointmentDate.value.year,
        selectedAppointmentDate.value.month,
        selectedAppointmentDate.value.day,
        int.parse(selectedStartAppointmentTime.value!.split(':').first),
        int.parse(selectedStartAppointmentTime.value!.split(':').last),
      ),
      endTime: DateTime(
        selectedAppointmentDate.value.year,
        selectedAppointmentDate.value.month,
        selectedAppointmentDate.value.day,
        int.parse(selectedEndAppointmentTime.value!.split(':').first),
        int.parse(selectedEndAppointmentTime.value!.split(':').last),
      ),
      date: selectedDate.value,
      haircuts: selectedItems,
      isRepeat: isRepeat.value,
    );
    appointments.add(appointment);
    Get.to(() => BookingCompletedScreen(appointment: appointment));

    await Prefs.saveAppointments(appointments);
    tecClientName.clear();
    tecPhone.clear();
    tecDate.clear();
    selectedEndAppointmentTime.value = null;
    selectedStartAppointmentTime.value = null;
    selectedItems.clear();
    isRepeat.value = false;
  }

  Future<void> removeAppointmentById(String id) async {
    appointments.removeWhere((element) => element.id == id);
    await Prefs.saveAppointments(appointments);
  }

  @override
  void onInit() async {
    super.onInit();
    generateCurrentWeek();
    initializeAppointments();

    List<AppointmentModel> loaded = await Prefs.loadAppointments();

    appointments.assignAll(loaded);
  }

  void generateCurrentWeek() {
    final now = selectedDate.value; // Use selected date, not DateTime.now()
    final startOfWeek = now.subtract(Duration(days: now.weekday % 7));
    weekDates.value = List.generate(
      7,
      (i) => startOfWeek.add(Duration(days: i)),
    );

    // Update selectedIndex based on selectedDate
    final todayIndex = weekDates.indexWhere(
      (date) =>
          date.day == selectedDate.value.day &&
          date.month == selectedDate.value.month &&
          date.year == selectedDate.value.year,
    );

    selectedIndex.value = todayIndex != -1 ? todayIndex : 0;
  }

  void goToPreviousWeek() {
    selectedDate.value = selectedDate.value.subtract(Duration(days: 7));
    generateCurrentWeek();
  }

  void goToNextWeek() {
    selectedDate.value = selectedDate.value.add(Duration(days: 7));
    generateCurrentWeek();
  }

  void selectDay(int index) {
    selectedIndex.value = index;
    selectedDate.value = weekDates[index];
  }

  String formatDate(DateTime date) => DateFormat('d/M/yyyy').format(date);

  RxList<String> allItems =
      [
        'Pixie cut',
        'Layered cut',
        'Crew cut',
        'Fade cut',
        'Under cut',
        'Mohawk',
        'Blunt Cut',
      ].obs;
  RxList<String> selectedItems = <String>[].obs;
  void onDropdownChanged(List<String> selected) {
    selectedItems.value = List.from(selected);
  }

  RxBool isRepeat = false.obs;

  void toggleRepeat() => isRepeat.value = !isRepeat.value;

  void updateSelectedStartAppointmentTime(String? value) {
    if (value != null) {
      selectedStartAppointmentTime.value = value;
    }
  }

  void updateSelectedEndAppointmentTime(String? value) {
    if (value != null) {
      selectedEndAppointmentTime.value = value;
    }
  }

  void updateSelectedEvery(String? value) {
    if (value != null) {
      selectedEvery.value = value;
    }
  }

  void updateSelectedFor(String? value) {
    if (value != null) {
      selectedFor.value = value;
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
      selectedAppointmentDate.value = picked;

      tecDate.text =
          "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
    }
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<AppointmentModel> source) {
    appointments = source;
  }
}
