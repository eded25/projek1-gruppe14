import 'package:barber_select/models/appointment_model.dart';
import 'package:barber_select/models/service_model.dart';
import 'package:barber_select/models/user_model.dart';
import 'package:barber_select/services/prefs.dart';
import 'package:barber_select/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyClientsController extends GetxController {
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

  var selectedDropdownMonth = RxnString();
  var selectedAppointmentTime = '9:30'.obs;
  var selectedPaymentMethod = 'Credit Card'.obs;

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

  RxList<UserModel> clients = <UserModel>[].obs;
  RxList<UserModel> loadUsers =
      <UserModel>[
        UserModel(
          userId: '1',
          name: 'Noah',
          availableTimes: ['10:00 AM - 6:00 PM'],
          rating: 4.5,
          number: '923191-98353',
          birthdayMonth: 'May',
          observation: 'Prefers afternoon appointments',
          value: 20.0,
          extraInformation: 'Allergic to certain products',
          neighborhood: 'Centro',
          city: 'Barcelona',
          state: 'Catalonia',
        ),
        UserModel(
          userId: '2',
          name: 'Elijah',
          availableTimes: ['11:00 AM - 7:00 PM'],
          rating: 4.2,
          number: '923191-98867',
          birthdayMonth: 'June',
          observation: 'Talkative client',
          value: 18.0,
          extraInformation: 'Likes clean fades',
          neighborhood: 'Eixample',
          city: 'Barcelona',
          state: 'Catalonia',
        ),
        UserModel(
          userId: '3',
          name: 'Andrew',
          availableTimes: ['09:00 AM - 5:00 PM'],
          number: '923191-98867',
          rating: 4.8,
          birthdayMonth: 'July',
          observation: 'Comes every 2 weeks',
          value: 22.0,
          extraInformation: 'Very punctual',
          neighborhood: 'Gràcia',
          city: 'Barcelona',
          state: 'Catalonia',
        ),
        UserModel(
          userId: '4',
          name: 'Henry.',
          availableTimes: ['12:00 PM - 8:00 PM'],
          rating: 4.6,
          number: '923191-98875',
          birthdayMonth: 'August',
          observation: 'Prefers quick haircuts',
          value: 19.0,
          extraInformation: 'Usually in a rush',
          neighborhood: 'Sants',
          city: 'Barcelona',
          state: 'Catalonia',
        ),
      ].obs;
  RxList<ServiceModel> services =
      <ServiceModel>[
        ServiceModel(id: '1', name: 'Side Part', quantity: 2),
        ServiceModel(id: '2', name: 'Pampadour', quantity: 3),
        ServiceModel(id: '3', name: 'Fade Cut', quantity: 5),
        ServiceModel(id: '3', name: 'Fade Cut', quantity: 8),
        ServiceModel(id: '4', name: 'Gaotee', quantity: 9),
        ServiceModel(id: '5', name: 'Extended Goatee', quantity: 12),
        ServiceModel(id: '6', name: 'Crew Cut', quantity: 1),
      ].obs;

  void addUserAndSave() async {
    final user = UserModel(
      userId: DateTime.now().toString(),
      name: tecName.text,
      availableTimes: [],
      rating: 0.0,
      number: tecNumber.text,
      birthdayMonth: selectedDropdownMonth.value!,
      observation: tecObservation.text,
      value: double.parse(tecValue.text),
      extraInformation: tecExtra.text,
      neighborhood: tecNeighborhood.text,
      city: tecCity.text,
      state: tecState.text,
    );
    clients.add(user);

    await Prefs.saveClients(clients);
    Get.back();
  }

  RxList<AppointmentModel> loadAppointments = <AppointmentModel>[].obs;

  void initializeAppointments() {
    DateTime now = DateTime.now();
    loadAppointments.assignAll([
      AppointmentModel(
        id: '1',
        clientName: 'Ethan Baker',
        phoneNumber: '923191-00001',
        startTime: DateTime(now.year, now.month, now.day, 1, 0),
        endTime: DateTime(now.year, now.month, now.day, 2, 0),
        date: now,
        haircuts: ['Fade Cut', 'Comb Over', 'High and Tight'],
        isRepeat: false,
      ),
      AppointmentModel(
        id: '2',
        clientName: 'Noah',
        phoneNumber: '923191-00002',
        startTime: DateTime(now.year, now.month, now.day, 9, 30),
        endTime: DateTime(now.year, now.month, now.day, 10, 30),
        date: now,
        haircuts: ['Fade Cut', 'Comb Over', 'High and Tight'],

        isRepeat: true,
        repeatAfter: 7,
        repeatFor: 4,
      ),
    ]);
  }

  @override
  void onInit() async {
    super.onInit();
    initializeAppointments();
    List<UserModel> loaded = await Prefs.loadClients();

    // If empty, save the default list
    if (loaded.isEmpty) {
      await Prefs.saveClients(loadUsers);
      clients.assignAll(loadUsers);
    } else {
      clients.assignAll(loaded);
    }
  }
}
