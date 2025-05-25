class ServiceModel {
  final String id;
  final String name;
  final int quantity;

  ServiceModel ( {required this.id, required this.name, required this.quantity});

  // Convert model to JSON
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'quantity' : quantity};
  }

  // Create model from JSON
  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(id: json['id'] ?? '', name: json['name'] ?? '',quantity: json['quantity']);
  }
}
