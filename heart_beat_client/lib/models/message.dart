class Message {
  final String message;
  final bool isUser;

  Message({required this.message, required this.isUser});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      message: json['message'] as String,
      isUser: json['isUser'] as bool,
    );
  }

  Map<String, dynamic> toJson() => {
    "role": isUser ? "User" : "Assistant",
    "content": message,
  };

  Map<String, dynamic> toGeminiJson() {
    return {
      "role": isUser ? "user" : "model",
      "parts": [
        {"text": message},
      ],
    };
  }
}
