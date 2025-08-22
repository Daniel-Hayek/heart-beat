import 'package:flutter/material.dart';
import 'package:heart_beat_client/widgets/primary_button.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Image.asset('assets/images/heart-beat-logo.png'),
            const Text("Your virtual companion for all things mood and music"),
            Column(
              children: [
                ElevatedButton(onPressed: () {}, child: Text("test")),
                ElevatedButton(onPressed: () {}, child: Text("nooo")),
                PrimaryButton(onPressed: () {}, label: "Login"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
