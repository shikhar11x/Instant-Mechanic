import 'package:flutter/material.dart';
import 'package:instant_mechanic/models/mechanic_model.dart';
import 'package:instant_mechanic/models/service_model.dart';

class MockData {
  // Mock Services
  static List<ServiceModel> get allServices => [
    ServiceModel(
      id: 'srv_1',
      name: 'General Service',
      icon: Icons.build_rounded,
      description: 'Regular maintenance and checkup',
      estimatedCost: 1500,
      estimatedTimeInMinutes: 120,
    ),
    ServiceModel(
      id: 'srv_2',
      name: 'Engine Repair',
      icon:Icons.car_repair_rounded,
      description: 'Engine diagnostics and repair',
      estimatedCost: 5000,
      estimatedTimeInMinutes: 180,
    ),
    ServiceModel(
      id: 'srv_3',
      name: 'Battery Service',
      icon: Icons.battery_charging_full,
      description: 'Battery replacement and testing',
      estimatedCost: 2000,
      estimatedTimeInMinutes: 45,
    ),
    ServiceModel(
      id: 'srv_4',
      name: 'Oil Change',
      icon: Icons.oil_barrel_rounded,
      description: 'Oil and filter replacement',
      estimatedCost: 800,
      estimatedTimeInMinutes: 60,
    ),
    ServiceModel(
      id: 'srv_5',
      name: 'Tyre Service',
      icon: Icons.tire_repair_rounded,
      description: 'Tyre repair, replacement, and balancing',
      estimatedCost: 1200,
      estimatedTimeInMinutes: 90,
    ),
    ServiceModel(
      id: 'srv_6',
      name: 'Brakes Service',
      icon: Icons.car_repair_rounded,
      description: 'Brake pad replacement and servicing',
      estimatedCost: 2500,
      estimatedTimeInMinutes: 120,
    ),
    ServiceModel(
      id: 'srv_7',
      name: 'AC Service',
      icon: Icons.ac_unit_rounded,
      description: 'Air conditioning repair and maintenance',
      estimatedCost: 1800,
      estimatedTimeInMinutes: 90,
    ),
    ServiceModel(
      id: 'srv_8',
      name: 'Electrical Work',
      icon: Icons.bolt_rounded,
      description: 'Electrical system repair',
      estimatedCost: 3000,
      estimatedTimeInMinutes: 150,
    ),
  ];

  // Popular Services (subset for home screen)
  static List<ServiceModel> get popularServices => allServices.take(5).toList();

  // Mock Mechanics
  static List<MechanicModel> get allMechanics => [
    MechanicModel(
      id: 'mech_1',
      garageName: 'Sharma Auto Garage',
      ownerName: 'Rajesh Sharma',
      phoneNumber: '+91 98123 45678',
      rating: 4.8,
      reviewCount: 245,
      distanceKm: 1.2,
      location: 'Sector 14, Rohtak, Haryana',
      fullAddress: 'Plot No. 45, Sector 14, Rohtak, Haryana 124001',
      imageUrl: 'https://images.pexels.com/photos/34337558/pexels-photo-34337558.jpeg?_gl=1*171t0vv*_ga*NTE3MjA2NjAxLjE3ODgzMjA5ODI.*_ga_8JE65Q40S6*czE3ODgzMjA5ODIkbzEkZzEkdDE3ODgzMjEwMDMkajM5JGwwJGgw',
      isOpen: true,
      services: [
        allServices[0],
        allServices[1],
        allServices[2],
        allServices[3],
        allServices[4],
      ],
      workingHoursStart: '9:00 AM',
      workingHoursEnd: '8:00 PM',
      workingDays: 'Monday - Saturday',
      description: 'Professional car repair and maintenance services with experienced technicians and genuine spare parts.',
      latitude: '29.1912',
      longitude: '76.6147',
    ),
    MechanicModel(
      id: 'mech_2',
      garageName: 'Speedy Wheels',
      ownerName: 'Amit Patel',
      phoneNumber: '+91 98456 78901',
      rating: 4.6,
      reviewCount: 189,
      distanceKm: 2.5,
      location: 'Sector 7, Rohtak, Haryana',
      fullAddress: 'Plot No. 23, Sector 7, Rohtak, Haryana 124001',
      imageUrl: 'https://images.pexels.com/photos/8985923/pexels-photo-8985923.jpeg?_gl=1*1cb0l49*_ga*NTE3MjA2NjAxLjE3ODgzMjA5ODI.*_ga_8JE65Q40S6*czE3ODgzMjA5ODIkbzEkZzEkdDE3ODgzMjEwNzUkajYwJGwwJGgw',
      isOpen: true,
      services: [
        allServices[2],
        allServices[3],
        allServices[4],
        allServices[5],
        allServices[6],
      ],
      workingHoursStart: '8:00 AM',
      workingHoursEnd: '9:00 PM',
      workingDays: 'Monday - Sunday',
      description: 'Fast and reliable car servicing with modern equipment and skilled mechanics.',
      latitude: '29.1850',
      longitude: '76.5987',
    ),
    MechanicModel(
      id: 'mech_3',
      garageName: 'Auto Care Point',
      ownerName: 'Priya Singh',
      phoneNumber: '+91 98789 01234',
      rating: 4.4,
      reviewCount: 156,
      distanceKm: 3.8,
      location: 'Sector 21, Rohtak, Haryana',
      fullAddress: 'Plot No. 67, Sector 21, Rohtak, Haryana 124001',
      imageUrl: 'https://images.pexels.com/photos/20872010/pexels-photo-20872010.jpeg?_gl=1*1cb0l49*_ga*NTE3MjA2NjAxLjE3ODgzMjA5ODI.*_ga_8JE65Q40S6*czE3ODgzMjA5ODIkbzEkZzEkdDE3ODgzMjEwNzUkajYwJGwwJGgw',
      isOpen: false,
      services: [
        allServices[0],
        allServices[1],
        allServices[5],
        allServices[6],
        allServices[7],
      ],
      workingHoursStart: '10:00 AM',
      workingHoursEnd: '7:00 PM',
      workingDays: 'Monday - Friday',
      description: 'Complete auto care solutions with affordable pricing and genuine parts guarantee.',
      latitude: '29.1700',
      longitude: '76.5800',
    ),
    MechanicModel(
      id: 'mech_4',
      garageName: 'Royal Motors',
      ownerName: 'Vikram Verma',
      phoneNumber: '+91 98234 56789',
      rating: 4.7,
      reviewCount: 312,
      distanceKm: 0.8,
      location: 'Sector 9, Rohtak, Haryana',
      fullAddress: 'Plot No. 12, Sector 9, Rohtak, Haryana 124001',
      imageUrl: 'https://images.pexels.com/photos/4480505/pexels-photo-4480505.jpeg?_gl=1*1cd7fy7*_ga*NTE3MjA2NjAxLjE3ODgzMjA5ODI.*_ga_8JE65Q40S6*czE3ODgzMjA5ODIkbzEkZzEkdDE3ODgzMjEwNzUkajYwJGwwJGgw',
      isOpen: true,
      services: [
        allServices[0],
        allServices[2],
        allServices[3],
        allServices[4],
        allServices[6],
      ],
      workingHoursStart: '9:30 AM',
      workingHoursEnd: '8:30 PM',
      workingDays: 'Monday - Saturday',
      description: 'Premium car servicing with latest diagnostic tools and certified technicians.',
      latitude: '29.1980',
      longitude: '76.6050',
    ),
    MechanicModel(
      id: 'mech_5',
      garageName: 'Quick Fix Garage',
      ownerName: 'Suresh Kumar',
      phoneNumber: '+91 98567 89012',
      rating: 4.3,
      reviewCount: 127,
      distanceKm: 4.2,
      location: 'Sector 25, Rohtak, Haryana',
      fullAddress: 'Plot No. 89, Sector 25, Rohtak, Haryana 124001',
      imageUrl: 'https://images.pexels.com/photos/21831854/pexels-photo-21831854.jpeg?_gl=1*14a0zqo*_ga*NTE3MjA2NjAxLjE3ODgzMjA5ODI.*_ga_8JE65Q40S6*czE3ODgzMjA5ODIkbzEkZzEkdDE3ODgzMjExODYkajU5JGwwJGgw',
      isOpen: true,
      services: [
        allServices[1],
        allServices[2],
        allServices[4],
        allServices[5],
        allServices[7],
      ],
      workingHoursStart: '8:00 AM',
      workingHoursEnd: '8:00 PM',
      workingDays: 'Monday - Sunday',
      description: 'Quick turnaround time for urgent repairs with transparent pricing policy.',
      latitude: '29.1650',
      longitude: '76.5750',
    ),
    MechanicModel(
      id: 'mech_6',
      garageName: 'Prime Auto Works',
      ownerName: 'Deepak Gupta',
      phoneNumber: '+91 98901 23456',
      rating: 4.5,
      reviewCount: 198,
      distanceKm: 2.1,
      location: 'Sector 15, Rohtak, Haryana',
      fullAddress: 'Plot No. 34, Sector 15, Rohtak, Haryana 124001',
      imageUrl: 'https://images.pexels.com/photos/4116232/pexels-photo-4116232.jpeg?_gl=1*1cd7fy7*_ga*NTE3MjA2NjAxLjE3ODgzMjA5ODI.*_ga_8JE65Q40S6*czE3ODgzMjA5ODIkbzEkZzEkdDE3ODgzMjEwNzUkajYwJGwwJGgw',
      isOpen: true,
      services: [
        allServices[0],
        allServices[3],
        allServices[5],
        allServices[6],
        allServices[7],
      ],
      workingHoursStart: '9:00 AM',
      workingHoursEnd: '7:30 PM',
      workingDays: 'Monday - Saturday',
      description: 'Quality auto repairs with warranty and customer satisfaction guarantee.',
      latitude: '29.1870',
      longitude: '76.5900',
    ),
  ];

  // Get mechanic by ID
  static MechanicModel? getMechanicById(String id) {
    for (var mechanic in allMechanics) {
      if (mechanic.id == id) {
        return mechanic;
      }
    }
    return null;
  }

  // Get service by ID
  static ServiceModel? getServiceById(String id) {
    try {
      return allServices.firstWhere((s) => s.id == id);
    } catch (e) {
      return null;
    }
  }

  // Get open mechanics
  static List<MechanicModel> get openMechanics =>
      allMechanics.where((m) => m.isOpen).toList();

  // Get closed mechanics
  static List<MechanicModel> get closedMechanics =>
      allMechanics.where((m) => !m.isOpen).toList();

  // Sort mechanics by rating
  static List<MechanicModel> getMechanicsSortedByRating() {
    final sorted = [...allMechanics];
    sorted.sort((a, b) => b.rating.compareTo(a.rating));
    return sorted;
  }

  // Sort mechanics by distance
  static List<MechanicModel> getMechanicsSortedByDistance() {
    final sorted = [...allMechanics];
    sorted.sort((a, b) => a.distanceKm.compareTo(b.distanceKm));
    return sorted;
  }

  // Search mechanics by name
  static List<MechanicModel> searchMechanics(String query) {
    final lowerQuery = query.toLowerCase();
    return allMechanics
        .where(
          (m) =>
              m.garageName.toLowerCase().contains(lowerQuery) ||
              m.location.toLowerCase().contains(lowerQuery),
        )
        .toList();
  }

  // Search services by name
  static List<ServiceModel> searchServices(String query) {
    final lowerQuery = query.toLowerCase();
    return allServices
        .where((s) => s.name.toLowerCase().contains(lowerQuery))
        .toList();
  }

  // Get mechanics that offer a specific service
  static List<MechanicModel> getMechanicsWithService(String serviceId) {
    return allMechanics
        .where((m) => m.services.any((s) => s.id == serviceId))
        .toList();
  }
}
