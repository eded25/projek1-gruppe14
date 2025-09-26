import 'package:barber_select/models/appointment_model.dart';
import 'package:barber_select/screens/barber/home/screens/booking_completed_screen.dart';
import 'package:barber_select/services/prefs.dart';
import 'package:barber_select/services/api_service.dart';
import 'package:barber_select/screens/auth/controller/auth_controller.dart';
import 'package:barber_select/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  // NEUE VARIABLE FÜR BENUTZERNAME
  var userName = 'Benutzer'.obs;

  Rx<DateTime> selectedDate = DateTime.now().obs;
  RxInt selectedIndex = 0.obs;
  RxList<DateTime> weekDates = <DateTime>[].obs;

  RxList<AppointmentModel> appointments = <AppointmentModel>[].obs;
  DateTime now = DateTime.now();
  RxList<AppointmentModel> loadAppointments = <AppointmentModel>[].obs;
  MeetingDataSource get dataSource => MeetingDataSource(appointments);

  // NEUE EIGENSCHAFTEN FÜR DATENBANK-INTEGRATION
  RxList<Map<String, dynamic>> pendingReservations =
      <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> approvedReservations =
      <Map<String, dynamic>>[].obs;
  RxInt todayCount = 0.obs;
  RxInt weekCount = 0.obs;
  RxBool loading = false.obs;

  // METHODEN FÜR BENUTZERNAME
  Future<void> loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    userName.value = prefs.getString('user_name') ?? 'Benutzer';
  }

  Future<void> setUserName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name', name);
    userName.value = name;
  }

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

  // DATENBANK-INTEGRATION METHODEN

  /// Lade alle Daten für das Dashboard
  Future<void> loadDashboardData() async {
    loading.value = true;
    try {
      final auth = Get.find<AuthController>();
      final barberId = auth.currentUserId.value;

      if (barberId == null) {
        Get.snackbar('Fehler', 'Nicht eingeloggt');
        return;
      }

      // Parallel alle Daten laden
      await Future.wait([
        loadStats(),
        loadPendingReservations(),
        loadApprovedReservations(),
      ]);
    } catch (e) {
      Get.snackbar('Fehler', 'Daten konnten nicht geladen werden: $e');
    } finally {
      loading.value = false;
    }
  }

  /// Lade Statistiken (heute/diese Woche)
  Future<void> loadStats() async {
    try {
      final auth = Get.find<AuthController>();
      final barberId = auth.currentUserId.value;

      final stats = await ApiService.getStats(barberId: barberId);

      if (stats['status'] == 'success') {
        todayCount.value = stats['today'] ?? 0;
        weekCount.value = stats['week'] ?? 0;
      }
    } catch (e) {
      print('Fehler beim Laden der Statistiken: $e');
    }
  }

  /// Lade pending Reservierungen
  Future<void> loadPendingReservations() async {
    try {
      final auth = Get.find<AuthController>();
      final barberId = auth.currentUserId.value;

      final pending = await ApiService.listReservationsAdvanced(
        barberId: barberId,
        status: 'pending',
      );

      pendingReservations.assignAll(pending.cast<Map<String, dynamic>>());
      print('📅 ${pending.length} pending Reservierungen geladen');
    } catch (e) {
      print('Fehler beim Laden pending Reservierungen: $e');
    }
  }

  /// Lade approved Reservierungen für Kalender
  Future<void> loadApprovedReservations() async {
    try {
      final auth = Get.find<AuthController>();
      final barberId = auth.currentUserId.value;

      // Lade approved Reservierungen für die nächsten 30 Tage
      final now = DateTime.now();
      final from = DateFormat('yyyy-MM-dd').format(now);
      final to = DateFormat('yyyy-MM-dd').format(now.add(Duration(days: 30)));

      final approved = await ApiService.listReservationsAdvanced(
        barberId: barberId,
        status: 'approved',
        from: from,
        to: to,
      );

      approvedReservations.assignAll(approved.cast<Map<String, dynamic>>());

      // Konvertiere zu AppointmentModel für den Kalender
      _convertToAppointments(approved);

      print('📅 ${approved.length} approved Reservierungen geladen');
    } catch (e) {
      print('Fehler beim Laden approved Reservierungen: $e');
    }
  }

  /// Konvertiere Datenbank-Daten zu AppointmentModel
  void _convertToAppointments(List<dynamic> reservations) {
    final dbAppointments = reservations
        .map((res) {
          try {
            final dateTime = DateTime.parse(res['date_time']);
            final duration = int.parse(res['duration_min'].toString());

            return AppointmentModel(
              id: res['reservation_id'].toString(),
              clientName: res['customer_name'] ?? 'Unbekannt',
              phoneNumber: res['phone'] ?? '',
              startTime: dateTime,
              endTime: dateTime.add(Duration(minutes: duration)),
              date: dateTime,
              haircuts: ['Service'], // TODO: Services aus DB laden
              isRepeat: false,
            );
          } catch (e) {
            print('Fehler bei Konvertierung: $e');
            return null;
          }
        })
        .whereType<AppointmentModel>()
        .toList();

    // Merge mit bestehenden Appointments (aus SharedPreferences)
    final allAppointments = <AppointmentModel>[];
    allAppointments.addAll(dbAppointments);
    allAppointments.addAll(loadAppointments); // Mock-Daten

    appointments.assignAll(allAppointments);
  }

  /// Reservierung genehmigen
  Future<void> approveReservation(Map<String, dynamic> reservation) async {
    loading.value = true;
    try {
      final auth = Get.find<AuthController>();
      final reservationId = int.parse(reservation['reservation_id'].toString());

      final result = await ApiService.approveReservation(
        id: reservationId,
        action: 'approve',
        approvedBy: auth.currentUserEmail.value,
      );

      if (result['status'] == 'success') {
        Get.snackbar(
          'Erfolg',
          'Reservierung #$reservationId genehmigt',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Aktualisiere Listen
        pendingReservations.removeWhere(
            (r) => r['reservation_id'].toString() == reservationId.toString());

        // Lade Daten neu
        await loadDashboardData();
      } else {
        Get.snackbar('Fehler', result['message'] ?? 'Unbekannter Fehler');
      }
    } catch (e) {
      Get.snackbar('Fehler', e.toString());
    } finally {
      loading.value = false;
    }
  }

  /// Reservierung ablehnen
  Future<void> rejectReservation(Map<String, dynamic> reservation) async {
    loading.value = true;
    try {
      final auth = Get.find<AuthController>();
      final reservationId = int.parse(reservation['reservation_id'].toString());

      final result = await ApiService.approveReservation(
        id: reservationId,
        action: 'reject',
        approvedBy: auth.currentUserEmail.value,
      );

      if (result['status'] == 'success') {
        Get.snackbar(
          'Erfolg',
          'Reservierung #$reservationId abgelehnt',
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );

        // Entferne aus pending Liste
        pendingReservations.removeWhere(
            (r) => r['reservation_id'].toString() == reservationId.toString());

        // Aktualisiere Statistiken
        await loadStats();
      } else {
        Get.snackbar('Fehler', result['message'] ?? 'Unbekannter Fehler');
      }
    } catch (e) {
      Get.snackbar('Fehler', e.toString());
    } finally {
      loading.value = false;
    }
  }

  // BESTEHENDE METHODEN (unverändert)
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
    loadAppointments.assignAll(loaded);

    // LADE BENUTZERNAME
    await loadUserName();

    // Lade Dashboard-Daten
    await loadDashboardData();
  }

  void generateCurrentWeek() {
    final now = selectedDate.value;
    final startOfWeek = now.subtract(Duration(days: now.weekday % 7));
    weekDates.value = List.generate(
      7,
      (i) => startOfWeek.add(Duration(days: i)),
    );

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

  RxList<String> allItems = [
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
