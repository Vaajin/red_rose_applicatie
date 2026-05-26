import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;

  const MessageBubble({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final isUser = message.startsWith("You:");
    final isSystem = message.startsWith("[SYSTEM]");

    return Align(
      alignment:
          isUser ? Alignment.centerRight : Alignment.centerLeft,

      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(12),

        constraints: const BoxConstraints(maxWidth: 300),

        decoration: BoxDecoration(
          color: isSystem
              ? Colors.orange[900]
              : isUser
                  ? Colors.red
                  : Colors.grey[900],

          borderRadius: BorderRadius.circular(14),
        ),

        child: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}