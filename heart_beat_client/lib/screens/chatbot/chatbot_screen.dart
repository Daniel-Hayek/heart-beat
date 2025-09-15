import 'package:flutter/material.dart';
import 'package:heart_beat_client/models/message.dart';
import 'package:heart_beat_client/providers/agent_provider.dart';
import 'package:heart_beat_client/services/n8n_service.dart';
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
                  final message = messages[index];

                  return ChatBubble(
                    text: message.message,
                    isUser: message.isUser,
                  );
                },
              ),
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
                          agentProvider.addMessage(
                            Message(
                              message: _messageController.text,
                              isUser: true,
                            ),
                          );

                          _messageController.text = '';

                          final history = messages
                              .sublist(
                                messages.length > 5 ? messages.length - 5 : 0,
                              )
                              .map((m) => m.toJson())
                              .toList();

                          try {
                            final response = await _n8n.client.post(
                              '/webhook/heartbeat-chat',
                              data: {"message": history},
                            );

                            if (response.data == null) {
                              agentProvider.addMessage(
                                Message(
                                  message:
                                      "Moody Blues is currently vibing out! Maybe try again later?",
                                  isUser: false,
                                ),
                              );
                            } else {
                              agentProvider.addMessage(
                                Message(
                                  message:
                                      response.data,
                                  isUser: false,
                                ),
                              );
                            }
                          } catch (e) {
                            throw Exception(e);
                          }
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
