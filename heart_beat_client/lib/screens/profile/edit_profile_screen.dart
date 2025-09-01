import 'package:flutter/material.dart';
import 'package:heart_beat_client/widgets/auth/auth_input_field.dart';
import 'package:heart_beat_client/widgets/common/bars/simple_app_bar.dart';
import 'package:heart_beat_client/widgets/common/buttons/primary_button.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(title: "Edit Profile"),
      body: Center(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05,
            vertical: MediaQuery.of(context).size.height * 0.05,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AuthInputField(
                label: "Name",
                isPass: false,
                placeholder: "Enter a new name...",
                controller: _nameController,
              ),
              SizedBox(height: 20),
              AuthInputField(
                label: "Email",
                isPass: false,
                placeholder: "Enter a new email...",
                controller: _emailController,
              ),
              SizedBox(height: 20),
              AuthInputField(
                label: "Password",
                isPass: true,
                placeholder: "Enter a new password...",
                controller: _passwordController,
              ),
              SizedBox(height: 20),
              AuthInputField(
                label: "Confirm Password",
                isPass: true,
                placeholder: "Confirm new password...",
                controller: _confirmController,
              ),
              SizedBox(height: 40),
              PrimaryButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                label: "Update",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
