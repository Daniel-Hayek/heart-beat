import 'package:flutter/material.dart';
import 'package:heart_beat_client/screens/auth/login_screen.dart';
import 'package:heart_beat_client/screens/auth/register_screen.dart';
import 'package:heart_beat_client/screens/landing/landing_screen.dart';

class AppRoutes {
  static const String landing = '/landing';
  static const String login = '/login';
  static const String register = '/register';

  static Map<String, WidgetBuilder> routes = {
    landing: (context) => const LandingScreen(),
    login: (context) => const LoginScreen(),
    register: (context) => const RegisterScreen(),
  };
}
