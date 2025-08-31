import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_beat_client/core/constants/app_colors.dart';
import 'package:heart_beat_client/widgets/common/fonts/title_text.dart';

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
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(CupertinoIcons.back, color: Colors.white),
        ),
        title: TitleText(text: title, size: 18),
        centerTitle: true,
        backgroundColor: AppColors.backgroundColor,
      ),
      body: Column(
        children: [
          Text(
            date,
            style: TextStyle(
              fontFamily: 'montserrat',
              color: AppColors.primaryColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
            child: Text(
              text,
              style: TextStyle(fontFamily: 'nunito', fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
