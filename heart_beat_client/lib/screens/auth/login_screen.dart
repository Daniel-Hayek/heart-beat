import 'package:flutter/material.dart';
import 'package:heart_beat_client/providers/auth_provider.dart';
import 'package:heart_beat_client/repositories/auth_repository.dart';
import 'package:heart_beat_client/routes/app_routes.dart';
import 'package:heart_beat_client/widgets/auth/auth_input_field.dart';
import 'package:heart_beat_client/widgets/auth/auth_snack_bar.dart';
import 'package:heart_beat_client/widgets/auth/swap_auth.dart';
import 'package:heart_beat_client/widgets/common/medium_logo.dart';
import 'package:heart_beat_client/widgets/common/primary_button.dart';
import 'package:heart_beat_client/widgets/common/tertiary_button.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthRepository _authController = AuthRepository();

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

    // final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final authProvider = context.read<AuthProvider>();
    //.watch the same but with listen = true

    // print(_emailController.text);
    // print(_passwordController.text);
    try {
      final result = await _authController.login(
        email: _emailController.text,
        password: _passwordController.text,
      );

      authProvider.login(result['accessToken']);
      print(result['accessToken']);

      if (!mounted) {
        return;
      }

      Navigator.pushReplacementNamed(context, AppRoutes.home);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(AuthSnackBar(content: Text(e.toString())));
    } finally {
      setState(() => _loading = false);
    }
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
                PrimaryButton(
                  onPressed: _loading ? null : _login,
                  label: _loading ? "Loggin in..." : "Login",
                ),
              ],
            ),
            Divider(),
            SwapAuth(
              text: "Don't have an account?",
              buttonLabel: "Register",
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.register);
              },
            ),
          ],
        ),
      ),
    );
  }
}
