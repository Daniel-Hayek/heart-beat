import 'package:flutter/material.dart';
import 'package:heart_beat_client/repositories/auth_repository.dart';
import 'package:heart_beat_client/routes/app_routes.dart';
import 'package:heart_beat_client/widgets/auth/auth_input_field.dart';
import 'package:heart_beat_client/widgets/auth/auth_snack_bar.dart';
import 'package:heart_beat_client/widgets/auth/swap_auth.dart';
import 'package:heart_beat_client/widgets/common/medium_logo.dart';
import 'package:heart_beat_client/widgets/common/primary_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthRepository _authController = AuthRepository();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _loading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void register() async {
    setState(() => _loading = true);

    try {
      final result = await _authController.register(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      );

      print(result);

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

  void validate() {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (name.isEmpty) {
      _showError("Name is required");
      return;
    }

    if (email.isEmpty) {
      _showError("Email is required");
      return;
    }

    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(email)) {
      _showError("Enter a valid email");
      return;
    }

    if (password.isEmpty) {
      _showError("Password is required");
      return;
    }
    if (password.length < 6) {
      _showError("Password must be at least 6 characters");
      return;
    }

    if (password != confirmPassword) {
      _showError("Passwords do not match");
      return;
    }

    return register();
  }

  void _showError(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(AuthSnackBar(content: Text(message)));
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
                  label: "Name",
                  isPass: false,
                  placeholder: "Enter your name...",
                  controller: _nameController,
                ),
                SizedBox(height: 30),
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
                SizedBox(height: 30),
                AuthInputField(
                  label: "Confirm Password",
                  isPass: true,
                  placeholder: "Re-enter your password...",
                  controller: _confirmPasswordController,
                ),
                SizedBox(height: 30),
                PrimaryButton(
                  onPressed: _loading ? null : validate,
                  label: _loading ? "Registering..." : "Register",
                ),
              ],
            ),
            Divider(),
            SwapAuth(
              text: "Already have an account?",
              buttonLabel: "Login",
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.login);
              },
            ),
          ],
        ),
      ),
    );
  }
}
