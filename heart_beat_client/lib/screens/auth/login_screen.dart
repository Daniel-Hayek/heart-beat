import 'package:flutter/material.dart';
import 'package:heart_beat_client/controllers/auth_controller.dart';
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
  final AuthController _authController = AuthController();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _loading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    setState(() => _loading = true);

    // print(_emailController.text);
    // print(_passwordController.text);

    final result = await _authController.login(
      email: _emailController.text,
      password: _passwordController.text,
    );

    print(result['accessToken']);
  }

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
                  controller: _emailController,
                ),
                SizedBox(height: 30),
                AuthInputField(
                  label: "Password",
                  isPass: true,
                  placeholder: "Enter your password...",
                  controller: _passwordController,
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
                PrimaryButton(onPressed: _login, label: "Login"),
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
