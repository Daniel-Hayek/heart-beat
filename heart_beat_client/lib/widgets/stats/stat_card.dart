import 'package:flutter/cupertino.dart';
import 'package:heart_beat_client/core/constants/app_colors.dart';
import 'package:heart_beat_client/widgets/common/fonts/title_text.dart';

class StatCard extends StatelessWidget {
  final String statType;
  final int statNum;

  const StatCard({super.key, required this.statType, required this.statNum});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      width: MediaQuery.of(context).size.width * 0.4,
      height: 300,
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.07),
      margin: EdgeInsets.all(4),
      child: Column(
        children: [
          TitleText(text: statType, size: 18),
          TitleText(text: statNum.toString(), size: 26),
        ],
      ),
    );
  }
}
