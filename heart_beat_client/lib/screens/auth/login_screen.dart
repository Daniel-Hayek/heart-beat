import 'package:flutter/material.dart';
import 'package:heart_beat_client/widgets/auth/auth_input_field.dart';
import 'package:heart_beat_client/widgets/common/medium_logo.dart';
import 'package:heart_beat_client/widgets/common/primary_button.dart';
import 'package:heart_beat_client/widgets/common/tertiary_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            MediumLogo(),
            AuthInputField(
              label: "Email",
              isPass: false,
              placeholder: "Enter your email...",
            ),
            AuthInputField(
              label: "Password",
              isPass: true,
              placeholder: "Enter your password...",
            ),
            TertiaryButton(onPressed: () {}, label: "Forgot your password?"),
            PrimaryButton(onPressed: () {}, label: "Login"),
            Divider(),
            Row()
          ],
        ),
      ),
    );
  }
}
