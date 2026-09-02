import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:instant_mechanic/features/home/home_screen.dart';
import 'package:instant_mechanic/features/bookings/bookings_screen.dart';
import 'package:instant_mechanic/features/messages/messages_screen.dart';
import 'package:instant_mechanic/features/profile/profile_screen.dart';
import 'package:instant_mechanic/features/mechanic_details/mechanic_details_screen.dart';
import 'package:instant_mechanic/features/request_service/request_service_screen.dart';
import 'package:instant_mechanic/features/confirmation/confirmation_screen.dart';
import 'package:instant_mechanic/features/empty/no_mechanics_screen.dart';
import 'package:instant_mechanic/core/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Instant Mechanic',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    // HOME
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    // BOOKINGS
    GoRoute(
      path: '/bookings',
      builder: (context, state) => const BookingsScreen(),
    ),
    // MESSAGES
    GoRoute(
      path: '/messages',
      builder: (context, state) => const MessagesScreen(),
    ),
    // PROFILE
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
    // MECHANIC DETAILS
    GoRoute(
      path: '/mechanic-details/:id',
      builder: (context, state) {
        final mechanicId = state.pathParameters['id'] ?? '0';
        return MechanicDetailsScreen(mechanicId: mechanicId);
      },
    ),
    // REQUEST SERVICE
    GoRoute(
      path: '/request-service/:id',
      builder: (context, state) {
        final mechanicId = state.pathParameters['id'] ?? '0';
        return RequestServiceScreen(mechanicId: mechanicId);
      },
    ),
    // CONFIRMATION
    GoRoute(
      path: '/confirmation',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>? ?? {};
        return ConfirmationScreen(bookingDetails: extra);
      },
    ),
    // NO MECHANICS
    GoRoute(
      path: '/no-mechanics',
      builder: (context, state) => const NoMechanicsScreen(),
    ),
  ],
);