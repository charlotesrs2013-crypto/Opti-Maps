class RouteModel {
  int? id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;
  String status;

  RouteModel({
    this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    this.status = 'Não iniciada',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'status': status,
    };
  }

  factory RouteModel.fromMap(Map<String, dynamic> map) {
    return RouteModel(
      id: map['id'] as int?,
      name: map['name'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
      updatedAt: DateTime.parse(map['updatedAt'] as String),
      status: map['status'] as String,
    );
  }
}