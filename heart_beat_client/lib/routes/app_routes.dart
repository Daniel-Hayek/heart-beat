import 'package:flutter/material.dart';
import 'package:heart_beat_client/features/views/landing_page.dart';

class AppRoutes {
  static const String landing = '/landing';

  static Map<String, WidgetBuilder> routes = {
    landing: (context) => const LandingPage(),
  };
}
