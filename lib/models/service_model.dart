import 'package:flutter/material.dart';

class ServiceModel {
  final String id;
  final String name;
  final IconData icon;
  final String description;
  final double estimatedCost;
  final int estimatedTimeInMinutes;

  ServiceModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.description,
    required this.estimatedCost,
    required this.estimatedTimeInMinutes,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      icon: json['icon'] as IconData? ?? Icons.build,
      description: json['description'] as String? ?? '',
      estimatedCost: (json['estimatedCost'] as num?)?.toDouble() ?? 0.0,
      estimatedTimeInMinutes: json['estimatedTimeInMinutes'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'description': description,
      'estimatedCost': estimatedCost,
      'estimatedTimeInMinutes': estimatedTimeInMinutes,
    };
  }

  @override
  String toString() => 'ServiceModel(id: $id, name: $name)';
}