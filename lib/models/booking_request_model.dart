class BookingRequest {
  final String requestId;
  final String barberName;
  final List<String> selectedTimes;
  final List<String> services;
  final double barberRating;
  final double price;
  final String date;

  BookingRequest({
    required this.requestId,
    required this.barberName,
    required this.selectedTimes,
    required this.services,
    required this.barberRating,
    required this.price,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'requestId': requestId,
      'barberName': barberName,
      'selectedTimes': selectedTimes,
      'services': services,
      'barberRating': barberRating,
      'price': price,
      'date': date,
    };
  }

  factory BookingRequest.fromMap(Map<String, dynamic> map) {
    return BookingRequest(
      requestId: map['requestId'] ?? '',
      barberName: map['barberName'] ?? '',
      selectedTimes: List<String>.from(map['selectedTimes'] ?? []),
      services: List<String>.from(map['services'] ?? []),
      barberRating: (map['barberRating'] ?? 0).toDouble(),
      price: (map['price'] ?? 0).toDouble(),
      date: map['date'] ?? '',
    );
  }
}
