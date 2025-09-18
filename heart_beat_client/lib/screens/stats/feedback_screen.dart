import 'package:flutter/material.dart';
import 'package:heart_beat_client/providers/auth_provider.dart';
import 'package:heart_beat_client/providers/nav_provider.dart';
import 'package:heart_beat_client/repositories/device_data_repository.dart';
import 'package:heart_beat_client/routes/app_routes.dart';
import 'package:heart_beat_client/widgets/auth/auth_snack_bar.dart';
import 'package:heart_beat_client/widgets/common/bars/simple_app_bar.dart';
import 'package:heart_beat_client/widgets/common/buttons/primary_button.dart';
import 'package:heart_beat_client/widgets/stats/feedback_field.dart';
import 'package:provider/provider.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final TextEditingController _heartrateController = TextEditingController();
  final TextEditingController _sleepController = TextEditingController();
  final TextEditingController _stepsController = TextEditingController();
  final TextEditingController _activityController = TextEditingController();
  final TextEditingController _usageController = TextEditingController();

  final dataRepo = DeviceDataRepository();

  @override
  void dispose() {
    _heartrateController.dispose();
    _sleepController.dispose();
    _stepsController.dispose();
    _activityController.dispose();
    _usageController.dispose();
    super.dispose();
  }

  void validate(String token, int id) {
    if (_heartrateController.text.trim().isEmpty) {
      _showError("Heartrate is required");
      return;
    }

    if (_sleepController.text.trim().isEmpty) {
      _showError("Sleep duration is required");
      return;
    }

    if (_stepsController.text.trim().isEmpty) {
      _showError("Steps are required");
      return;
    }

    if (_activityController.text.trim().isEmpty) {
      _showError("Activity is required");
      return;
    }

    if (_usageController.text.trim().isEmpty) {
      _showError("Phone usage is required");
      return;
    }

    final heartrate = double.tryParse(_heartrateController.text)!;
    final sleep = double.tryParse(_sleepController.text)!;
    final steps = double.tryParse(_stepsController.text)!;
    final activity = double.tryParse(_activityController.text)!;
    final usage = int.tryParse(_usageController.text)!;

    if (heartrate < 40 || heartrate > 140) {
      _showError("Invalid heartrate");
      return;
    }

    if (sleep < 1 || sleep > 16) {
      _showError("Invalid sleep duration");
      return;
    }

    if (steps < 1 || steps > 30000) {
      _showError("Invalid steps");
      return;
    }

    if (activity < 0 || activity > 500) {
      _showError("Invalid activity");
      return;
    }

    if (usage < 1 || usage > 1440) {
      _showError("Invalid phone usage");
      return;
    }

    dataRepo.logData(
      id: id,
      sleepDuration: double.tryParse(_sleepController.text)!,
      activityLevel: double.tryParse(_activityController.text)!,
      steps: double.tryParse(_stepsController.text)!,
      heartrate: double.tryParse(_heartrateController.text)!,
      token: token,
    );

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(AuthSnackBar(content: Text("Your data has been logged!")));

    context.read<NavProvider>().setIndex(2);

    Navigator.pushReplacementNamed(context, AppRoutes.home);
  }

  void _showError(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(AuthSnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthProvider>();

    return Scaffold(
      appBar: SimpleAppBar(title: "Smartwatch Vitals Manual Input"),
      body: Padding(
        padding: EdgeInsetsGeometry.all(
          MediaQuery.of(context).size.width * 0.06,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FeedbackField(
                    label:
                        "What is your average heartrate over the last few hours?",
                    controller: _heartrateController,
                  ),
                  SizedBox(height: 40),
                  FeedbackField(
                    label: "How many hours did you sleep last night?",
                    controller: _sleepController,
                  ),
                  SizedBox(height: 40),
                  FeedbackField(
                    label: "How many steps did you take in the last 24 hours?",
                    controller: _stepsController,
                  ),
                  SizedBox(height: 40),
                  FeedbackField(
                    label:
                        "How many minutes of physical activity have you done in the last 24 hours?",
                    controller: _activityController,
                  ),
                  SizedBox(height: 40),
                  FeedbackField(
                    label:
                        "How many hours of phone usage do you have in the last 24 hours?",
                    controller: _usageController,
                  ),
                ],
              ),
              SizedBox(height: 30),
              PrimaryButton(
                onPressed: () {
                  validate(authProvider.token!, authProvider.userId!);
                },
                label: "Submit Data",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
