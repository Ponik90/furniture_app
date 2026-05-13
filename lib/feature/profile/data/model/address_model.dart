class AddressModel {
  final String? id;
  final String name; // e.g. Home, Office
  final String addressDetails;
  final double latitude;
  final double longitude;

  AddressModel({
    this.id,
    required this.name,
    required this.addressDetails,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'addressDetails': addressDetails,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map, String id) {
    return AddressModel(
      id: id,
      name: map['name'] ?? '',
      addressDetails: map['addressDetails'] ?? '',
      latitude: (map['latitude'] as num).toDouble(),
      longitude: (map['longitude'] as num).toDouble(),
    );
  }
}
