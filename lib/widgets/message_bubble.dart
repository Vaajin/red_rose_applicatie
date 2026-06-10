import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;

  const MessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isUser = message.startsWith("You:");
    final isSystem = message.startsWith("[SYSTEM]");
    final isTyping = message.contains("is typing...");

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.78,
        ),
        decoration: BoxDecoration(
          color: isSystem
              ? const Color(0xFF2A1000)
              : isUser
              ? const Color(0xFF8B0000)
              : const Color(0xFF1C0A0A),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: isUser
                ? const Radius.circular(16)
                : const Radius.circular(4),
            bottomRight: isUser
                ? const Radius.circular(4)
                : const Radius.circular(16),
          ),
          border: Border.all(
            color: isSystem
                ? const Color(0xFF8B3A00).withValues(alpha: 0.6)
                : isUser
                ? const Color(0xFFE53935).withValues(alpha: 0.4)
                : const Color(0xFF4A1515).withValues(alpha: 0.5),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isSystem
                  ? const Color(0xFFFF6600).withValues(alpha: 0.08)
                  : isUser
                  ? const Color(0xFFB71C1C).withValues(alpha: 0.15)
                  : Colors.black.withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: isTyping
            ? _TypingIndicator()
            : Text(
                message,
                style: TextStyle(
                  color: isSystem
                      ? const Color(0xFFFFAA55)
                      : const Color(0xFFEEEEEE),
                  fontSize: 14.5,
                  height: 1.4,
                  letterSpacing: isSystem ? 0.5 : 0,
                  fontStyle: isSystem ? FontStyle.italic : FontStyle.normal,
                ),
              ),
      ),
    );
  }
}

class _TypingIndicator extends StatefulWidget {
  @override
  State<_TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<_TypingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (i) {
            final delay = i * 0.33;
            final t = (_controller.value - delay).clamp(0.0, 1.0);
            final opacity = (0.3 + 0.7 * (0.5 - (t - 0.5).abs()) * 2).clamp(
              0.3,
              1.0,
            );
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFCC3333).withValues(alpha: opacity),
              ),
            );
          }),
        );
      },
    );
  }
}
