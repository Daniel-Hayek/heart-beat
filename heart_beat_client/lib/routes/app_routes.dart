import 'package:flutter/material.dart';
import 'package:heart_beat_client/screens/auth/login_screen.dart';
import 'package:heart_beat_client/screens/auth/register_screen.dart';
import 'package:heart_beat_client/screens/home/home_screen.dart';
import 'package:heart_beat_client/screens/journal/base_journal_screen.dart';
import 'package:heart_beat_client/screens/journal/list_journal_screen.dart';
import 'package:heart_beat_client/screens/journal/view_journal_screen.dart';
import 'package:heart_beat_client/screens/journal/write_journal_screen.dart';
import 'package:heart_beat_client/screens/landing/landing_screen.dart';
import 'package:heart_beat_client/screens/playlist/playlist_home_screen.dart';

class AppRoutes {
  static const String landing = '/landing';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';

  static const String journal = '/journal';
  static const String writeJournal = '/journal/write';
  static const String listJournal = '/journal/list';
  static const String viewJournal = '/journal/view';

  static const String playlist = '/playlist';

  static Map<String, WidgetBuilder> routes = {
    landing: (context) => const LandingScreen(),
    login: (context) => const LoginScreen(),
    register: (context) => const RegisterScreen(),
    home: (context) => const HomeScreen(),
    journal: (context) => const BaseJournalScreen(),
    writeJournal: (context) => const WriteJournalScreen(),
    listJournal: (context) => const ListJournalScreen(),
    playlist: (context) => PlaylistHomeScreen(),
  };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case viewJournal:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => ViewJournalScreen(
            title: args['title'],
            date: args['date'],
            text: args['text'],
          ),
        );
    }
    return null;
  }
}
