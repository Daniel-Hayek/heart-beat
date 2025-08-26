import 'package:flutter/material.dart';
import 'package:heart_beat_client/widgets/auth/auth_input_field.dart';
import 'package:heart_beat_client/widgets/auth/swap_auth.dart';
import 'package:heart_beat_client/widgets/common/medium_logo.dart';
import 'package:heart_beat_client/widgets/common/primary_button.dart';
import 'package:heart_beat_client/widgets/common/tertiary_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TertiaryButton(
                      onPressed: () {},
                      label: "Forgot your password?",
                    ),
                  ],
                ),
                SizedBox(height: 10),
                PrimaryButton(onPressed: () {}, label: "Login"),
              ],
            ),
            Divider(),
            SwapAuth(
              text: "Don't have an account?",
              buttonLabel: "Register",
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
