import 'package:flutter/material.dart';
import 'package:heart_beat_client/core/constants/app_colors.dart';
import 'package:heart_beat_client/widgets/common/bars/simple_app_bar.dart';

class ViewJournalScreen extends StatelessWidget {
  final String title;
  final String date;
  final String text;

  const ViewJournalScreen({
    super.key,
    required this.title,
    required this.date,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(title: title),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.02,
          horizontal: MediaQuery.of(context).size.width * 0.05,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                date,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'montserrat',
                  color: AppColors.primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(text, style: TextStyle(fontFamily: 'nunito', fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
