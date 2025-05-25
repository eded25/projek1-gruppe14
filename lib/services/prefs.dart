import 'dart:convert';

import 'package:barber_select/models/appointment_model.dart';
import 'package:barber_select/models/booking_request_model.dart';
import 'package:barber_select/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Prefs {
  static const String _key = 'clients';
  static const String _appointments = '_appointments';
  static const String _clientBookings = '_clientBookings';
  Future<void> saveLanguage(String languageCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', languageCode);
  }

  Future loadSavedLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedLanguage = prefs.getString('savedLanguage');
    if (savedLanguage != null) {
      return savedLanguage;
    }
    return 'en';
  }

  static Future<void> saveClients(List<UserModel> clients) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> clientJsonList =
        clients.map((client) => jsonEncode(client.toJson())).toList();
    await prefs.setStringList(_key, clientJsonList);
  }

  static Future<List<UserModel>> loadClients() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? clientJsonList = prefs.getStringList(_key);

    if (clientJsonList == null) return [];

    return clientJsonList
        .map((jsonStr) => UserModel.fromJson(jsonDecode(jsonStr)))
        .toList();
  }

  static Future<void> saveAppointments(
    List<AppointmentModel> appointments,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> appointmentJsonList =
        appointments.map((client) => jsonEncode(client.toJson())).toList();
    await prefs.setStringList(_appointments, appointmentJsonList);
  }

  static Future<List<AppointmentModel>> loadAppointments() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? appointmentJsonList = prefs.getStringList(
      _appointments,
    );

    if (appointmentJsonList == null) return [];

    return appointmentJsonList
        .map((jsonStr) => AppointmentModel.fromJson(jsonDecode(jsonStr)))
        .toList();
  }

  static Future<void> saveClientBookings(
    List<BookingRequest> bookingRequests,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> bookingRequestsJsonList =
        bookingRequests.map((request) => jsonEncode(request.toMap())).toList();
    await prefs.setStringList(_clientBookings, bookingRequestsJsonList);
  }

  static Future<List<BookingRequest>> loadClientBookings() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? bookingRequestsJsonList = prefs.getStringList(
      _clientBookings,
    );

    if (bookingRequestsJsonList == null) return [];

    return bookingRequestsJsonList
        .map((jsonStr) => BookingRequest.fromMap(jsonDecode(jsonStr)))
        .toList();
  }
}
