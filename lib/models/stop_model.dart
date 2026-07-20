class StopModel {
  int? id;

  int routeId;

  int order;

  String address;

  double? latitude;

  double? longitude;

  String? customerName;

  String? phone;

  String? notes;

  String status;

  StopModel({
    this.id,
    required this.routeId,
    required this.order,
    required this.address,
    this.latitude,
    this.longitude,
    this.customerName,
    this.phone,
    this.notes,
    this.status = 'Pendente',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'routeId': routeId,
      'stopOrder': order,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'customerName': customerName,
      'phone': phone,
      'notes': notes,
      'status': status,
    };
  }

  factory StopModel.fromMap(Map<String, dynamic> map) {
    return StopModel(
      id: map['id'] as int?,
      routeId: map['routeId'] as int,
      order: map['stopOrder'] as int,
      address: map['address'] as String,
      latitude: map['latitude'] != null
          ? (map['latitude'] as num).toDouble()
          : null,
      longitude: map['longitude'] != null
          ? (map['longitude'] as num).toDouble()
          : null,
      customerName: map['customerName'] as String?,
      phone: map['phone'] as String?,
      notes: map['notes'] as String?,
      status: map['status'] as String,
    );
  }
}