import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import 'package:heart_beat_client/screens/landing/landing_screen.dart';
import 'package:heart_beat_client/providers/auth_provider.dart';
import 'package:heart_beat_client/routes/app_routes.dart';
import 'package:heart_beat_client/widgets/common/buttons/primary_button.dart';
import 'package:heart_beat_client/widgets/common/buttons/secondary_button.dart';

// Mock AuthProvider
class MockAuthProvider extends Mock implements AuthProvider {}

// Mock NavigatorObserver
class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('LandingScreen', () {
    late MockAuthProvider mockAuthProvider;
    late MockNavigatorObserver mockObserver;

    setUp(() {
      mockAuthProvider = MockAuthProvider();
      mockObserver = MockNavigatorObserver();
    });

    testWidgets('renders logo, text, and buttons when user is not logged in', (
      WidgetTester tester,
    ) async {
      // Stub AuthProvider
      when(() => mockAuthProvider.isLoading).thenReturn(false);
      when(() => mockAuthProvider.isLoggedIn).thenReturn(false);
      when(() => mockAuthProvider.loadToken()).thenAnswer((_) async => null);

      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<AuthProvider>.value(value: mockAuthProvider),
          ],
          child: MaterialApp(
            home: const LandingScreen(),
            navigatorObservers: [mockObserver],
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Check widgets exist
      expect(find.byType(LandingScreen), findsOneWidget);
      expect(find.byType(PrimaryButton), findsOneWidget);
      expect(find.byType(SecondaryButton), findsOneWidget);
      expect(
        find.text("Your virtual companion for all things mood and music"),
        findsOneWidget,
      );
      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('navigates to login screen when login button is tapped', (
      WidgetTester tester,
    ) async {
      when(() => mockAuthProvider.isLoading).thenReturn(false);
      when(() => mockAuthProvider.isLoggedIn).thenReturn(false);
      when(() => mockAuthProvider.loadToken()).thenAnswer((_) async => null);

      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<AuthProvider>.value(value: mockAuthProvider),
          ],
          child: MaterialApp(
            home: const LandingScreen(),
            routes: {
              AppRoutes.login: (context) =>
                  const SizedBox(key: Key('login_screen')),
            },
            navigatorObservers: [mockObserver],
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Tap login button
      await tester.tap(find.widgetWithText(PrimaryButton, 'Login'));
      await tester.pumpAndSettle();

      // Verify navigation occurred
      expect(find.byKey(const Key('login_screen')), findsOneWidget);
    });

    testWidgets('navigates to register screen when register button is tapped', (
      WidgetTester tester,
    ) async {
      when(() => mockAuthProvider.isLoading).thenReturn(false);
      when(() => mockAuthProvider.isLoggedIn).thenReturn(false);
      when(() => mockAuthProvider.loadToken()).thenAnswer((_) async => null);

      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<AuthProvider>.value(value: mockAuthProvider),
          ],
          child: MaterialApp(
            home: const LandingScreen(),
            routes: {
              AppRoutes.register: (context) =>
                  const SizedBox(key: Key('register_screen')),
            },
            navigatorObservers: [mockObserver],
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Tap register button
      await tester.tap(find.widgetWithText(SecondaryButton, 'Register'));
      await tester.pumpAndSettle();

      // Verify navigation occurred
      expect(find.byKey(const Key('register_screen')), findsOneWidget);
    });

    testWidgets('shows CircularProgressIndicator when loading', (
      WidgetTester tester,
    ) async {
      when(() => mockAuthProvider.isLoading).thenReturn(true);
      when(() => mockAuthProvider.isLoggedIn).thenReturn(false);
      when(() => mockAuthProvider.loadToken()).thenAnswer((_) async => null);

      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<AuthProvider>.value(value: mockAuthProvider),
          ],
          child: const MaterialApp(home: LandingScreen()),
        ),
      );

      await tester.pump(); // Only pump, not pumpAndSettle

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
