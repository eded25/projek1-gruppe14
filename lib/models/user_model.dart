class UserModel {
  final String userId;
  final String name;
  final List<String> availableTimes;
  final double rating;
  final String number;
  final String birthdayMonth;
  final String observation;
  final double value;
  final String extraInformation;
  final String neighborhood;
  final String city;
  final String state;

  UserModel({
    required this.userId,
    required this.name,
    required this.availableTimes,
    required this.rating,
    required this.number,
    required this.birthdayMonth,
    required this.observation,
    required this.value,
    required this.extraInformation,
    required this.neighborhood,
    required this.city,
    required this.state,
  });

  // Convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'availableTimes': availableTimes,
      'rating': rating,
      'number': number,
      'birthdayMonth': birthdayMonth,
      'observation': observation,
      'value': value,
      'extraInformation': extraInformation,
      'neighborhood': neighborhood,
      'city': city,
      'state': state,
    };
  }

  // Create model from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'] ?? '',
      name: json['name'] ?? '',
      availableTimes: List<String>.from(json['availableTimes'] ?? []),
      rating: (json['rating'] != null) ? (json['rating'] as num).toDouble() : 0.0,
      number: json['number'] ?? '',
      birthdayMonth: json['birthdayMonth'] ?? '',
      observation: json['observation'] ?? '',
      value: (json['value'] != null) ? (json['value'] as num).toDouble() : 0.0,
      extraInformation: json['extraInformation'] ?? '',
      neighborhood: json['neighborhood'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
    );
  }
}