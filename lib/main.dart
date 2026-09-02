import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:instant_mechanic/features/home/home_screen.dart';
import 'package:instant_mechanic/features/mechanic_details/mechanic_details_screen.dart';
import 'package:instant_mechanic/core/theme/app_theme.dart';
import 'package:instant_mechanic/features/request_service/request_service_screen.dart';
import 'package:instant_mechanic/features/confirmation/confirmation_screen.dart';
import 'package:instant_mechanic/features/empty/no_mechanics_screen.dart';

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
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/mechanic-details/:id',
      builder: (context, state) {
        final mechanicId = state.pathParameters['id'] ?? '0';
        return MechanicDetailsScreen(mechanicId: mechanicId);
      },
    ),
    GoRoute(
      path: '/request-service/:id',
      builder: (context, state) {
        final mechanicId = state.pathParameters['id'] ?? '0';
        return RequestServiceScreen(mechanicId: mechanicId);
      },
    ),
    GoRoute(
      path: '/confirmation',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>? ?? {};
        return ConfirmationScreen(bookingDetails: extra);
      },
    ),
    GoRoute(
      path: '/no-mechanics',
      builder: (context, state) => const NoMechanicsScreen(),
    ),
  ],
);