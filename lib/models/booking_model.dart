class BookingModel {
  final String id;
  final String barberName;
  final String barberId;
  final String date;
  final String time;
  final String status;
  final double price;
  final String services;
  final String createdAt;

  BookingModel({
    required this.id,
    required this.barberName,
    required this.barberId,
    required this.date,
    required this.time,
    required this.status,
    required this.price,
    required this.services,
    required this.createdAt,
  });

  // Angepasst an dein Backend-Format
  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id']?.toString() ?? '0',
      barberName: json['barber_name'] ?? json['name'] ?? 'Unknown Barber',
      barberId: json['barber_id']?.toString() ?? '0',
      date: json['appointment_date'] ?? json['date'] ?? '',
      time: json['appointment_time'] ?? json['time'] ?? '',
      status: json['status'] ?? 'pending',
      price: double.tryParse(json['total_price']?.toString() ?? '0') ?? 0.0,
      services: json['services'] ?? 'Haircut',
      createdAt: json['created_at'] ?? '',
    );
  }

  // Formatiere Datum für Anzeige
  String get formattedDate {
    try {
      final dateTime = DateTime.parse(date);
      return "${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year}";
    } catch (e) {
      return date;
    }
  }

  // Status Icon
  String get statusIcon {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return '✅';
      case 'pending':
        return '⏳';
      case 'cancelled':
        return '❌';
      case 'completed':
        return '🎉';
      default:
        return '📅';
    }
  }

  // Status Color
  String get statusColor {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return 'green';
      case 'pending':
        return 'orange';
      case 'cancelled':
        return 'red';
      case 'completed':
        return 'blue';
      default:
        return 'gray';
    }
  }
}
