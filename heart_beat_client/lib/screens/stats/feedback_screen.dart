import 'package:flutter/material.dart';
import 'package:heart_beat_client/widgets/auth/auth_snack_bar.dart';
import 'package:heart_beat_client/widgets/common/bars/simple_app_bar.dart';
import 'package:heart_beat_client/widgets/common/buttons/primary_button.dart';
import 'package:heart_beat_client/widgets/stats/feedback_field.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(title: "Feedback"),
      body: Padding(
        padding: EdgeInsetsGeometry.all(
          MediaQuery.of(context).size.width * 0.06,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FeedbackField(
                  label: "Thoughts on this issue",
                  controller: null,
                ),
                SizedBox(height: 40),
                FeedbackField(
                  label: "Thoughts on this issue",
                  controller: null,
                ),
                SizedBox(height: 40),
                FeedbackField(
                  label: "Thoughts on this issue",
                  controller: null,
                ),
              ],
            ),
            PrimaryButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  AuthSnackBar(content: Text("Thank you for your feedback!")),
                );
                Navigator.pop(context);
              },
              label: "Submit Feedback",
            ),
          ],
        ),
      ),
    );
  }
}
