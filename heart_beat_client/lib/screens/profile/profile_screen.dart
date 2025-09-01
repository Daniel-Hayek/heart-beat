import 'package:flutter/material.dart';
import 'package:heart_beat_client/routes/app_routes.dart';
import 'package:heart_beat_client/widgets/common/bars/simple_app_bar.dart';
import 'package:heart_beat_client/widgets/common/buttons/primary_button.dart';
import 'package:heart_beat_client/widgets/common/logos/medium_logo.dart';
import 'package:heart_beat_client/widgets/profile/profile_info.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(title: "Profile"),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05,
            vertical: MediaQuery.of(context).size.height * 0.05,
          ),
          child: Column(
            children: [
              MediumLogo(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileInfo(label: "Name", value: "Jeff"),
                  ProfileInfo(label: "Email", value: "jeff@mail.com"),
                  ProfileInfo(label: "Password", value: "******"),
                ],
              ),
              PrimaryButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.editProfile);
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
