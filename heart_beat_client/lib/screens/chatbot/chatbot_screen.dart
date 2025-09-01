import 'package:flutter/material.dart';
import 'package:heart_beat_client/widgets/chatbot/chat_bubble.dart';
import 'package:heart_beat_client/widgets/common/bars/custom_app_bar.dart';
import 'package:heart_beat_client/widgets/common/bars/custom_bottom_bar.dart';
import 'package:heart_beat_client/widgets/common/bars/side_bar.dart';

class ChatbotScreen extends StatelessWidget {
  const ChatbotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Moody Blues"),
      drawer: SideBar(),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.05,
          horizontal: MediaQuery.of(context).size.width * 0.05,
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: ChatBubble(text: "Hello", isUser: true),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: ChatBubble(text: "Beep boop", isUser: false),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: null,
                    decoration: InputDecoration(
                      hintText: "What would you like to talk about...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.white, width: 2),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.04,
                        vertical: MediaQuery.of(context).size.height * 0.04,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomBar(),
    );
  }
}
