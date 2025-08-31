import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:heart_beat_client/screens/home/home_screen.dart';
import 'package:heart_beat_client/providers/auth_provider.dart';
import 'package:heart_beat_client/providers/nav_provider.dart';

void main() {
  testWidgets('HomeScreen renders with providers', (WidgetTester tester) async {
    // Wrap HomeScreen with both providers it needs
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
          ChangeNotifierProvider<NavProvider>(create: (_) => NavProvider()),
        ],
        child: const MaterialApp(home: HomeScreen()),
      ),
    );

    await tester.pump();

    // Basic check: HomeScreen widget exists
    expect(find.byType(HomeScreen), findsOneWidget);

    // Optional: check for text that is guaranteed to appear
    // (you may need to replace 'Welcome' with actual text from your screen)
    // expect(find.text('Welcome'), findsOneWidget);
  });
}
