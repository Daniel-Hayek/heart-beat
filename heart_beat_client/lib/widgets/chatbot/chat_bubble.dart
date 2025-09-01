import 'package:flutter/material.dart';
import 'package:heart_beat_client/core/constants/app_colors.dart';

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isUser;

  const ChatBubble({super.key, required this.text, required this.isUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: isUser ? Colors.white : AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isUser ? Colors.black : Colors.white,
          fontFamily: 'nunito',
          fontSize: 12,
        ),
      ),
    );
  }
}
