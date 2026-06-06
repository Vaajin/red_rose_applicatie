import 'package:flutter/material.dart';
import '../models/story_node.dart';
import '../services/story_engine.dart';
import '../widgets/choice_buttons.dart';
import '../widgets/message_bubble.dart';
import 'ending_screen.dart';

class ChatScreen extends StatefulWidget {
  final String username;

  const ChatScreen({super.key, required this.username});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final StoryEngine engine = StoryEngine();

  List<String> messages = [];

  bool loading = false;
  bool ended = false;

  final ScrollController scrollController = ScrollController();

  StoryNode get node => engine.node;

  @override
  void initState() {
    super.initState();
    loadNode();
  }

  void scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> loadNode() async {
    setState(() {
      loading = true;
    });

    messages.add("[SYSTEM] Connecting...");
    scrollToBottom();

    await Future.delayed(const Duration(milliseconds: 800));

    if (messages.isNotEmpty) {
      messages.removeLast();
    }

    for (final msg in node.messages) {
      setState(() {
        messages.add("Red Rose: is typing...");
      });

      scrollToBottom();

      await Future.delayed(const Duration(milliseconds: 900));

      setState(() {
        if (messages.isNotEmpty) {
          messages.removeLast();
        }

        messages.add(msg);
      });

      scrollToBottom();

      await Future.delayed(const Duration(milliseconds: 300));
    }

    setState(() {
      loading = false;
    });

    scrollToBottom();

    checkEndings();
  }

  void choose(String choice) {
    if (ended) return;

    setState(() {
      messages.add("You: $choice");
    });

    engine.choose(choice);

    if (engine.fear >= 4) {
      messages.add("[SYSTEM] Unusual activity detected...");
    }

    if (engine.fear >= 5) {
      messages.add("Red Rose: You're not in control.");
    }

    if (engine.exposure >= 6) {
      messages.add("[SYSTEM] Connection terminated.");
    }

    setState(() {});

    loadNode();

    scrollToBottom();
  }

  void checkEndings() {
    if (ended) return;

    final ending = engine.getEnding();

    if (ending == "GAME_OVER") {
      ended = true;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const EndingScreen(
            title: "GAME OVER",
            description: "Everyone knows what you did.",
          ),
        ),
      );
      return;
    }

    if (ending == "SUBMISSION") {
      ended = true;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const EndingScreen(
            title: "SUBMISSION",
            description: "You stopped resisting.",
          ),
        ),
      );
      return;
    }

    if (ending == "ACCEPTANCE") {
      ended = true;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const EndingScreen(
            title: "ACCEPTANCE",
            description: "Red Rose welcomes you.",
          ),
        ),
      );
      return;
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "RED ROSE - ${widget.username}",
          style: const TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold),
        ),
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              "Trust: ${engine.trust} | "
              "Pressure: ${engine.pressure} | "
              "Fear: ${engine.fear} | "
              "Exposure: ${engine.exposure}",
              style: const TextStyle(color: Colors.red),
            ),
          ),

          Expanded(
            child: ListView.builder(
              controller: scrollController,
              padding: const EdgeInsets.all(10),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                return MessageBubble(message: msg);
              },
            ),
          ),

          if (loading)
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "Red Rose is watching...",
                style: TextStyle(color: Colors.white54),
              ),
            ),

          if (!loading) ChoiceButtons(choices: node.choices, onChoose: choose),
        ],
      ),
    );
  }
}
