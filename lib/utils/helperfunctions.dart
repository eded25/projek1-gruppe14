import 'package:intl/intl.dart';

Map<String, DateTime> getStartAndEndTime(String date, String time) {
  // Combine date and time into a single string
  final dateTimeString = '$date $time'; // e.g., "21/05/2025 12:00"

  // Parse using DateFormat
  final format = DateFormat("dd/MM/yyyy HH:mm");
  final startTime = format.parse(dateTimeString);

  // Add 30 minutes to startTime
  final endTime = startTime.add(Duration(minutes: 30));

  return {
    "startTime": startTime,
    "endTime": endTime,
  };
}