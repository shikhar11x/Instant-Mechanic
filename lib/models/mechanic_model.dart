import 'package:instant_mechanic/models/service_model.dart';

class MechanicModel {
  final String id;
  final String garageName;
  final String ownerName;
  final String phoneNumber;
  final double rating;
  final int reviewCount;
  final double distanceKm;
  final String location;
  final String fullAddress;
  final String imageUrl;
  final bool isOpen;
  final List<ServiceModel> services;
  final String workingHoursStart;
  final String workingHoursEnd;
  final String workingDays;
  final String description;
  final String latitude;
  final String longitude;

  MechanicModel({
    required this.id,
    required this.garageName,
    required this.ownerName,
    required this.phoneNumber,
    required this.rating,
    required this.reviewCount,
    required this.distanceKm,
    required this.location,
    required this.fullAddress,
    required this.imageUrl,
    required this.isOpen,
    required this.services,
    required this.workingHoursStart,
    required this.workingHoursEnd,
    required this.workingDays,
    required this.description,
    required this.latitude,
    required this.longitude,
  });

  factory MechanicModel.fromJson(Map<String, dynamic> json) {
    return MechanicModel(
      id: json['id'] as String? ?? '',
      garageName: json['garageName'] as String? ?? '',
      ownerName: json['ownerName'] as String? ?? '',
      phoneNumber: json['phoneNumber'] as String? ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewCount: json['reviewCount'] as int? ?? 0,
      distanceKm: (json['distanceKm'] as num?)?.toDouble() ?? 0.0,
      location: json['location'] as String? ?? '',
      fullAddress: json['fullAddress'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
      isOpen: json['isOpen'] as bool? ?? true,
      services: (json['services'] as List<dynamic>?)
              ?.map((s) => ServiceModel.fromJson(s as Map<String, dynamic>))
              .toList() ??
          [],
      workingHoursStart: json['workingHoursStart'] as String? ?? '9:00 AM',
      workingHoursEnd: json['workingHoursEnd'] as String? ?? '8:00 PM',
      workingDays: json['workingDays'] as String? ?? 'Monday - Saturday',
      description: json['description'] as String? ?? '',
      latitude: json['latitude'] as String? ?? '',
      longitude: json['longitude'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'garageName': garageName,
      'ownerName': ownerName,
      'phoneNumber': phoneNumber,
      'rating': rating,
      'reviewCount': reviewCount,
      'distanceKm': distanceKm,
      'location': location,
      'fullAddress': fullAddress,
      'imageUrl': imageUrl,
      'isOpen': isOpen,
      'services': services.map((s) => s.toJson()).toList(),
      'workingHoursStart': workingHoursStart,
      'workingHoursEnd': workingHoursEnd,
      'workingDays': workingDays,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  @override
  String toString() => 'MechanicModel(id: $id, garageName: $garageName)';
}