import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:heart_beat_client/screens/home/home_screen.dart';
import 'package:heart_beat_client/providers/auth_provider.dart';
import 'package:heart_beat_client/providers/nav_provider.dart';
import 'package:heart_beat_client/repositories/journal_repository.dart';

// Mock classes
class MockAuthProvider extends Mock implements AuthProvider {}

class MockJournalRepository extends Mock implements JournalRepository {}

Future<void> main() async {
  // Ensure WidgetsFlutterBinding is initialized
  TestWidgetsFlutterBinding.ensureInitialized();

  // Load dotenv env manually for tests
  await dotenv.load(fileName: 'test/.env.test');

  testWidgets('HomeScreen renders safely with mocked providers', (
    WidgetTester tester,
  ) async {
    // Create mocks
    final mockAuthProvider = MockAuthProvider();
    final mockRepo = MockJournalRepository();
    final navProvider = NavProvider();

    // Stub the values that HomeScreen expects
    when(() => mockAuthProvider.token).thenReturn('dummy_token');
    when(() => mockAuthProvider.email).thenReturn('test@example.com');

    // Wrap HomeScreen with mocked and dummy providers
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthProvider>.value(value: mockAuthProvider),
          ChangeNotifierProvider<NavProvider>.value(value: navProvider),
          Provider<JournalRepository>.value(value: mockRepo),
        ],
        child: const MaterialApp(home: HomeScreen()),
      ),
    );

    // Pump to process initState and builds
    await tester.pump();

    // Assert HomeScreen exists
    expect(find.byType(HomeScreen), findsOneWidget);
  });
}
