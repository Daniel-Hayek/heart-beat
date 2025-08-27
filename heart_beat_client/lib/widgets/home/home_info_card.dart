import 'package:flutter/material.dart';
import 'package:heart_beat_client/core/constants/app_colors.dart';

class HomeInfoCard extends StatelessWidget {
  const HomeInfoCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text("Home Page Card Title"),
          Row(children: [Text("Home Page Card Info"), Container()]),
        ],
      ),
    );
  }
}
