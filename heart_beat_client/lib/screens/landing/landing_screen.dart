import 'package:flutter/material.dart';
import 'package:heart_beat_client/routes/app_routes.dart';
import 'package:heart_beat_client/widgets/common/custom_app_bar.dart';
import 'package:heart_beat_client/widgets/common/primary_button.dart';
import 'package:heart_beat_client/widgets/common/secondary_button.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 300, maxWidth: 300),
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
  }
}
