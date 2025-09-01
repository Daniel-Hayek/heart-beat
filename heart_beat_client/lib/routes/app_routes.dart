import 'package:flutter/material.dart';
import 'package:heart_beat_client/screens/auth/login_screen.dart';
import 'package:heart_beat_client/screens/auth/register_screen.dart';
import 'package:heart_beat_client/screens/chatbot/chatbot_screen.dart';
import 'package:heart_beat_client/screens/home/home_screen.dart';
import 'package:heart_beat_client/screens/journal/base_journal_screen.dart';
import 'package:heart_beat_client/screens/journal/list_journal_screen.dart';
import 'package:heart_beat_client/screens/journal/view_journal_screen.dart';
import 'package:heart_beat_client/screens/journal/write_journal_screen.dart';
import 'package:heart_beat_client/screens/landing/landing_screen.dart';
import 'package:heart_beat_client/screens/playlist/music_track_screen.dart';
import 'package:heart_beat_client/screens/playlist/playlist_home_screen.dart';
import 'package:heart_beat_client/screens/playlist/view_playlist_screen.dart';
import 'package:heart_beat_client/screens/profile/profile_screen.dart';
import 'package:heart_beat_client/screens/quiz/quiz_base_screen.dart';
import 'package:heart_beat_client/screens/quiz/quiz_question_screen.dart';
import 'package:heart_beat_client/screens/stats/feedback_screen.dart';
import 'package:heart_beat_client/screens/stats/stats_screen.dart';

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
  static const String viewPlaylist = '/playlist/view';
  static const String musicTrack = '/playlist/track';

  static const String quiz = '/quiz';
  static const String quizQuestion = '/quiz/question';

  static const String stats = '/stats';
  static const String feedback = '/stats/feedback';

  static const String chatbot = '/chatbot';

  static const String profile = '/profile';

  static Map<String, WidgetBuilder> routes = {
    landing: (context) => const LandingScreen(),
    login: (context) => const LoginScreen(),
    register: (context) => const RegisterScreen(),
    home: (context) => const HomeScreen(),
    journal: (context) => const BaseJournalScreen(),
    writeJournal: (context) => const WriteJournalScreen(),
    listJournal: (context) => const ListJournalScreen(),
    playlist: (context) => PlaylistHomeScreen(),
    viewPlaylist: (context) => const ViewPlaylistScreen(),
    musicTrack: (context) => const MusicTrackScreen(),
    quiz: (context) => const QuizBaseScreen(),
    quizQuestion: (context) => const QuizQuestionScreen(),
    stats: (context) => const StatsScreen(),
    feedback: (context) => const FeedbackScreen(),
    chatbot: (context) => const ChatbotScreen(),
    profile: (context) => const ProfileScreen(),
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
