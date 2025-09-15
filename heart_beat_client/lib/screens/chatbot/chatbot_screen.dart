import 'package:flutter/material.dart';
import 'package:heart_beat_client/providers/agent_provider.dart';
import 'package:heart_beat_client/services/api_service.dart';
import 'package:heart_beat_client/services/n8n_service.dart';
import 'package:heart_beat_client/widgets/auth/auth_snack_bar.dart';
import 'package:heart_beat_client/widgets/chatbot/chat_bubble.dart';
import 'package:heart_beat_client/widgets/common/bars/custom_app_bar.dart';
import 'package:heart_beat_client/widgets/common/bars/custom_bottom_bar.dart';
import 'package:heart_beat_client/widgets/common/bars/side_bar.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _messageController = TextEditingController();
  final N8nService _n8n = N8nService();

  @override
  Widget build(BuildContext context) {
    final agentProvider = context.watch<AgentProvider>();

    final messages = agentProvider.messages;

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
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[messages.length - index - 1];

                  return ChatBubble(text: message, isUser: true);
                },
              ),

              // Align(
              //   alignment: Alignment.centerRight,
              //   child: ChatBubble(text: "Hello", isUser: true),
              // ),
              // Align(
              //   alignment: Alignment.centerLeft,
              //   child: ChatBubble(text: "Beep boop", isUser: false),
              // ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    textAlignVertical: TextAlignVertical.top,
                    maxLines: 1,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: "What would you like to talk about...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.white, width: 2),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.03,
                        vertical: MediaQuery.of(context).size.height * 0.02,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () async {
                          agentProvider.addMessage(_messageController.text.trim());
                          _messageController.text = '';

                          final response = await _n8n.client.post(
                            '/webhook/heartbeat-chat',
                            data: {"message": _messageController.text},
                          );

                          agentProvider.addMessage(response.data.toString());

                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   AuthSnackBar(content: Text(response.data)),
                          // );
                        },
                        icon: Icon(
                          LucideIcons.send,
                          color: Colors.white,
                          size: 24,
                        ),
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
