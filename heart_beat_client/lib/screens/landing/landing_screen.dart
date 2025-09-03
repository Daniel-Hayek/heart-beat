import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:heart_beat_client/providers/auth_provider.dart';
import 'package:heart_beat_client/routes/app_routes.dart';
import 'package:heart_beat_client/widgets/common/buttons/primary_button.dart';
import 'package:heart_beat_client/widgets/common/buttons/secondary_button.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, _) {
        if (auth.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (auth.isLoggedIn) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (auth.isLoggedIn) {
              Navigator.pushReplacementNamed(context, AppRoutes.home);
            }
          });
        }

        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 300,
                    maxWidth: 300,
                  ),
                  child: Image.asset('assets/images/heart-beat-logo.png'),
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 200),
                  child: const Text(
                    "Your virtual companion for all things mood and music",
                    textAlign: TextAlign.center,
                  ),
                ),
                Column(
                  children: [
                    PrimaryButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.login);
                      },
                      label: "Login",
                    ),
                    SecondaryButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.register);
                      },
                      label: "Register",
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
