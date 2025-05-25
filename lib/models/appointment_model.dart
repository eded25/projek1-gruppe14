class AppointmentModel {
  final String id;
  final String clientName;
  final String phoneNumber;
  final DateTime startTime;
  final DateTime endTime;
  final DateTime date;
  final List<String> haircuts;
  final bool isRepeat;
  final int? repeatAfter; // e.g., repeat every X days or weeks
  final int? repeatFor; // total number of times to repeat

  AppointmentModel({
    required this.id,
    required this.clientName,
    required this.phoneNumber,
    required this.startTime,
    required this.endTime,
    required this.date,
    required this.haircuts,
    required this.isRepeat,
    this.repeatAfter,
    this.repeatFor,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
    'id' : id,
      'clientName': clientName,
      'phoneNumber': phoneNumber,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'date': date.toIso8601String(),
      'haircuts': haircuts,
      'isRepeat': isRepeat,
      'repeatAfter': repeatAfter,
      'repeatFor': repeatFor,
    };
  }

  // Create from JSON
  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['id'] ?? '',
      clientName: json['clientName'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      startTime: DateTime.tryParse(json['startTime'] ?? '') ?? DateTime.now(),
      endTime: DateTime.tryParse(json['endTime'] ?? '') ?? DateTime.now(),
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
      haircuts: List<String>.from(json['haircuts'] ?? []),
      isRepeat: json['isRepeat'] ?? false,
      repeatAfter: json['repeatAfter'], // nullable
      repeatFor: json['repeatFor'], // nullable
    );
  }
}
