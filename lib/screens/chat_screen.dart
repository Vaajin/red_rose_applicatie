import 'package:flutter/material.dart';
import '../data/story_data.dart';
import '../models/story_node.dart';

class ChatScreen extends StatefulWidget {
  final String username;

  const ChatScreen({super.key, required this.username});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String currentId = "start";
  List<String> messages = [];

  bool loading = false;

  int trust = 0;
  int pressure = 0;
  int fear = 0;
  int exposure = 0;

  final ScrollController scrollController = ScrollController();

  StoryNode get node => story[currentId]!;

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

    messages.removeLast();

    for (final msg in node.messages) {
      setState(() {
        messages.add("Red Rose: is typing...");
      });

      scrollToBottom();

      await Future.delayed(const Duration(milliseconds: 900));

      setState(() {
        messages.removeLast();
        messages.add(msg);
      });

      scrollToBottom();

      await Future.delayed(const Duration(milliseconds: 300));
    }

    setState(() {
      loading = false;
    });

    scrollToBottom();
  }

  void choose(String choice) {
    messages.add("You: $choice");

    if (choice.toLowerCase().contains("who")) {
      trust++;
    }

    if (choice.toLowerCase().contains("leave")) {
      pressure++;
      fear++;
    }

    if (pressure >= 2) {
      exposure++;
    }

    if (fear >= 2) {
      messages.add("[SYSTEM] Unusual activity detected...");
    }

    String nextId = node.next[choice]!;

    if (fear >= 3) {
      nextId = "threat";
      messages.add("Red Rose: You're not in control.");
    }

    if (exposure >= 2) {
      nextId = "end";
      messages.add("[SYSTEM] Connection terminated.");
    }

    currentId = nextId;

    setState(() {});

    loadNode();

    scrollToBottom();
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
              "Trust: $trust | Pressure: $pressure | Fear: $fear | Exposure: $exposure",
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

                final isUser = msg.startsWith("You:");

                final isSystem = msg.startsWith("[SYSTEM]");

                return Align(
                  alignment: isUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,

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
                      msg,
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                );
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

          if (!loading)
            Column(
              children: node.choices.map((c) {
                return SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[700],
                      ),
                      onPressed: () => choose(c),
                      child: Text(c),
                    ),
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
}
