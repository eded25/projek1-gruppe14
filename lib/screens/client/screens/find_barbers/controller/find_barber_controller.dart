import 'package:barber_select/generated/assets.dart';
import 'package:barber_select/models/review_model.dart';
import 'package:barber_select/models/user_model.dart';
import 'package:barber_select/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FindBarberController extends GetxController {
  final RxString selectedPaymentMethod = 'Cash'.obs;

  final fnSearch = FocusNode();
  final tecSearch = TextEditingController();
  final fnDate = FocusNode();
  final tecDate = TextEditingController();

  final selectedTimes = <String>[].obs;

  void toggleTimeSelection(String time) {
    if (selectedTimes.contains(time)) {
      selectedTimes.remove(time); // Deselect if already selected
    } else {
      selectedTimes.add(time); // Select if not selected
    }
  }

  RxBool isCut = false.obs;
  RxBool isBeard = false.obs;
  RxBool isCutBeard = false.obs;
  RxBool isDyeHair = false.obs;
  Rx<DateTime> selectedAppointmentDate = DateTime.now().obs;

  void toggleCut() => isCut.value = !isCut.value;
  void toggleBeard() => isBeard.value = !isBeard.value;
  void toggleCutBeard() => isCutBeard.value = !isCutBeard.value;
  void toggleDyeHair() => isDyeHair.value = !isDyeHair.value;
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

  RxList<UserModel> barbers =
      <UserModel>[
        UserModel(
          userId: '1',
          name: 'Sufian',
          availableTimes: ['10:00 AM - 6:00 PM'],
          rating: 4.5,
          number: '923191-98867',
          birthdayMonth: 'January',
          observation: 'Punctual and skilled',
          value: 25.0,
          extraInformation: 'Speaks English and Spanish',
          neighborhood: 'Downtown',
          city: 'Frankfurt',
          state: 'Frankfurt',
        ),
        UserModel(
          userId: '2',
          name: 'Osama',
          availableTimes: ['11:00 AM - 7:00 PM'],
          rating: 4.2,
          number: '923191-98867',
          birthdayMonth: 'February',
          observation: 'Prefers walk-ins',
          value: 22.0,
          extraInformation: 'Has 5 years experience',
          neighborhood: 'Chamberí',
          city: 'Frankfurt',
          state: 'Frankfurt',
        ),
        UserModel(
          userId: '3',
          name: 'Parker',
          availableTimes: ['09:00 AM - 5:00 PM'],
          rating: 4.8,
          number: '923191-98867',
          birthdayMonth: 'March',
          observation: 'Great with kids',
          value: 30.0,
          extraInformation: 'Certified barber',
          neighborhood: 'Salamanca',
          city: 'Madrid',
          state: 'Madrid',
        ),
        UserModel(
          userId: '4',
          name: 'Taha',
          availableTimes: ['12:00 PM - 8:00 PM'],
          rating: 4.6,
          number: '923191-98867',
          birthdayMonth: 'April',
          observation: 'Specializes in fades',
          value: 28.0,
          extraInformation: 'Available on weekends',
          neighborhood: 'Lavapiés',
          city: 'Frankfurt',
          state: 'Frankfurt',
        ),
      ].obs;

  RxList<ReviewModel> reviews =
      <ReviewModel>[
        ReviewModel(
          userId: '1',
          name: 'Sufian',
          time: 'April 30, 2023',
          desc: "I'm so glad I have a new beard, I recommend it to everyone!",
          rating: 4.5,
        ),
        ReviewModel(
          userId: '2',
          name: 'Osama',
          time: 'May 23, 2023',
          desc: "I'm so glad I have a new beard, I recommend it to everyone!",
          rating: 4.2,
        ),
        ReviewModel(
          userId: '3',
          name: 'Parker',
          time: 'June 22, 2023',
          desc: "I'm so glad I have a new beard, I recommend it to everyone!",
          rating: 4.8,
        ),
        ReviewModel(
          userId: '4',
          name: 'Arther M.',
          time: 'April 30, 2023',
          desc: "I'm so glad I have a new beard, I recommend it to everyone!",

          rating: 4.6,
        ),
      ].obs;

  final List imageList = [
    Assets.barberImage1,
    Assets.barberImage2,
    Assets.barberImage3,
    Assets.barberImage1,
    Assets.barberImage2,
    Assets.barberImage3,
    Assets.barberImage1,
    Assets.barberImage2,
    Assets.barberImage3,
    Assets.barberImage1,
    Assets.barberImage2,
    Assets.barberImage3,
    Assets.barberImage1,
    Assets.barberImage2,

    Assets.barberImage3,
    Assets.barberImage1,
    Assets.barberImage2,
    Assets.barberImage3,
  ];
}
