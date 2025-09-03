import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_beat_client/core/constants/app_colors.dart';
import 'package:heart_beat_client/widgets/common/buttons/primary_button.dart';
import 'package:heart_beat_client/widgets/common/fonts/title_text.dart';

class WriteJournalScreen extends StatelessWidget {
  const WriteJournalScreen({super.key});

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
        title: TitleText(text: "New Journal Entry", size: 18),
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
            style: const TextStyle(color: Colors.white),
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.backgroundColor,
              hintText: "What's on your mind...",
              contentPadding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 12,
              ),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ],
      ),
      floatingActionButton: PrimaryButton(onPressed: () {}, label: "Save"),
    );
  }
}
