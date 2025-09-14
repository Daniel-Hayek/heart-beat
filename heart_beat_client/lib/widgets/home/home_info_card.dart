import 'package:flutter/material.dart';
import 'package:heart_beat_client/core/constants/app_colors.dart';

class HomeInfoCard extends StatelessWidget {
  final String title;
  final String content;
  final String image;

  const HomeInfoCard({
    super.key,
    required this.title,
    required this.content,
    required this.image,
  });

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
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'montserrat',
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  content,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),

          SizedBox(width: 16),
          Expanded(
            flex: 4,
            child: Image.asset(
              'assets/images/$image',
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
