import 'package:flutter/material.dart';
import 'package:heart_beat_client/core/constants/app_colors.dart';
import 'package:heart_beat_client/widgets/common/fonts/body_text.dart';
import 'package:heart_beat_client/widgets/common/fonts/title_text.dart';

class HomeInfoCard extends StatelessWidget {
  const HomeInfoCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      height: 200,
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          TitleText(text: "Home Screen Card", size: 20),
          Row(
            children: [
              BodyText(text: "Home Screen Text", size: 16, maxLines: null,),
              SizedBox(),
            ],
          ),
        ],
      ),
    );
  }
}
