import 'package:flutter/material.dart';
import 'package:heart_beat_client/widgets/auth/auth_input_field.dart';
import 'package:heart_beat_client/widgets/auth/swap_auth.dart';
import 'package:heart_beat_client/widgets/common/medium_logo.dart';
import 'package:heart_beat_client/widgets/common/primary_button.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MediumLogo(),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AuthInputField(
                  label: "Name",
                  isPass: false,
                  placeholder: "Enter your name...",
                ),
                SizedBox(height: 30),
                AuthInputField(
                  label: "Email",
                  isPass: false,
                  placeholder: "Enter your email...",
                ),
                SizedBox(height: 30),
                AuthInputField(
                  label: "Password",
                  isPass: true,
                  placeholder: "Enter your password...",
                ),
                SizedBox(height: 30),
                AuthInputField(
                  label: "Confirm Password",
                  isPass: true,
                  placeholder: "Re-enter your password...",
                ),
                SizedBox(height: 10),
                PrimaryButton(onPressed: () {}, label: "Register"),
              ],
            ),
            Divider(),
            SwapAuth(
              text: "Already have an account?",
              buttonLabel: "Login",
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
