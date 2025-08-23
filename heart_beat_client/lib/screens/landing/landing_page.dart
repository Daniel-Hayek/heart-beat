import 'package:flutter/material.dart';
import 'package:heart_beat_client/widgets/common/primary_button.dart';
import 'package:heart_beat_client/widgets/common/secondary_button.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                PrimaryButton(onPressed: () {}, label: "Login"),
                SecondaryButton(onPressed: () {}, label: "Register"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
