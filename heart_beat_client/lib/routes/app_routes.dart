import 'package:flutter/material.dart';
import 'package:heart_beat_client/screens/auth/login_screen.dart';
import 'package:heart_beat_client/screens/landing/landing_page.dart';

class AppRoutes {
  static const String landing = '/landing';
  static const String login = '/login';

  static Map<String, WidgetBuilder> routes = {
    landing: (context) => const LandingPage(),
    login: (context) => const LoginScreen(),
  };
}
