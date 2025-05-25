class PortfolioModel {
  final String id;
  final String name;

  PortfolioModel({required this.id, required this.name});

  // Convert model to JSON
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }

  // Create model from JSON
  factory PortfolioModel.fromJson(Map<String, dynamic> json) {
    return PortfolioModel(id: json['id'] ?? '', name: json['name'] ?? '');
  }
}
