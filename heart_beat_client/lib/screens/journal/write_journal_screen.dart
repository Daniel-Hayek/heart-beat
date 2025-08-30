import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_beat_client/core/constants/app_colors.dart';
import 'package:heart_beat_client/widgets/common/fonts/title_text.dart';

class WriteJournalScreen extends StatelessWidget {
  const WriteJournalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(CupertinoIcons.back, color: Colors.white),
        ),
        title: TitleText(text: "New Journal Entry", size: 18),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(CupertinoIcons.floppy_disk, color: Colors.white),
          ),
        ],
        centerTitle: true,
        backgroundColor: AppColors.backgroundColor,
      ),
      body: Column(
        children: [
          Text(
            "How was your experience today?",
            style: TextStyle(
              color: AppColors.primaryColor,
              fontFamily: 'montserrat',
              fontSize: 18,
            ),
          ),
          TextFormField(
            style: const TextStyle(color: AppColors.black),
            decoration: InputDecoration(
              labelText: "What's on your mind...",
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              hintText: "What's on your mind...",
              contentPadding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
