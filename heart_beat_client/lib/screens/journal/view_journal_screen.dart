import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_beat_client/core/constants/app_colors.dart';
import 'package:heart_beat_client/core/constants/sample_text.dart';
import 'package:heart_beat_client/widgets/common/fonts/body_text.dart';
import 'package:heart_beat_client/widgets/common/fonts/title_text.dart';

class ViewJournalScreen extends StatelessWidget {
  const ViewJournalScreen({Key? key}) : super(key: key);

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
        title: TitleText(text: "Journal Entry Title", size: 18),
        centerTitle: true,
        backgroundColor: AppColors.backgroundColor,
      ),
      body: Column(
        children: [
          Text(
            "mm/dd/yy",
            style: TextStyle(
              fontFamily: 'montserrat',
              color: AppColors.primaryColor,
              fontSize: 18,
            ),
          ),
          BodyText(text: SampleText.sampleText, size: 16, maxLines: null)
        ],
      ),
    );
  }
}
