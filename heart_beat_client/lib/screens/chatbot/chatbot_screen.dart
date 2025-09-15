import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:heart_beat_client/core/constants/app_colors.dart';
import 'package:heart_beat_client/models/message.dart';
import 'package:heart_beat_client/providers/agent_provider.dart';
import 'package:heart_beat_client/providers/auth_provider.dart';
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
  final ScrollController _scrollController = ScrollController();

  final N8nService _n8n = N8nService();

  bool _isTyping = false;

  @override
  Widget build(BuildContext context) {
    final agentProvider = context.watch<AgentProvider>();
    final _authProvider = context.read<AuthProvider>();

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
                controller: _scrollController,
                itemBuilder: (context, index) {
                  final message = messages[index];

                  return ChatBubble(
                    text: message.message,
                    isUser: message.isUser,
                  );
                },
              ),
            ),
            if (_isTyping)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: const [
                    SpinKitThreeBounce(
                      color: AppColors.primaryColor,
                      size: 20.0,
                    ),
                    SizedBox(width: 10),
                    Text("Moody Blues is typing..."),
                  ],
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
                          setState(() => _isTyping = true);

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
                              data: {
                                "userId": _authProvider.userId,
                                "message": history,
                              },
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
                                Message(message: response.data, isUser: false),
                              );
                            }

                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              _scrollController.animateTo(
                                _scrollController.position.maxScrollExtent,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeOut,
                              );
                            });
                          } catch (e) {
                            throw Exception(e);
                          } finally {
                            setState(() => _isTyping = false);
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
