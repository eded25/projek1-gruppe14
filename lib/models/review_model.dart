class ReviewModel {
  final String userId;
  final String name;
  final String desc;
  final double rating;
  final String time;

  ReviewModel({
    required this.userId,
    required this.name,
    required this.desc,
    required this.rating,
    required this.time,
  });

  // Convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'desc': desc,
      'rating': rating,
      'time': time,
    };
  }

  // Create model from JSON
  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      userId: json['userId'] ?? '',
      name: json['name'] ?? '',
      desc: json['desc'] ?? '',
      time: json['time'] ?? '',
      rating:
          (json['rating'] != null) ? (json['rating'] as num).toDouble() : 0.0,
    );
  }
}
