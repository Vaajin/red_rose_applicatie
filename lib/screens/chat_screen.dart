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

  StoryNode get node => story[currentId]!;

  @override
  void initState() {
    super.initState();
    loadNode();
  }

  void loadNode() async {
    setState(() {
      loading = true;
    });

    await Future.delayed(const Duration(milliseconds: 800));

    for (final msg in node.messages) {
      await Future.delayed(const Duration(milliseconds: 500));
      messages.add(msg);
      setState(() {});
    }

    setState(() {
      loading = false;
    });
  }

  void choose(String choice) {
    messages.add("You: $choice");

    if (choice.contains("Who")) {
      trust++;
    }

    if (choice.contains("Leave")) {
      pressure++;
      fear++;
    }

    if (pressure >= 2) {
      exposure++;
    }

    String nextId = node.next[choice]!;

    if (fear >= 3) {
      nextId = "threat";
    }

    if (exposure >= 2) {
      nextId = "end";
    }

    currentId = nextId;

    loadNode();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          "RED ROSE",
          style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold),
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
              padding: const EdgeInsets.all(10),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];

                final isUser = message.startsWith("You:");

                return Align(
                  alignment: isUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,

                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),

                    padding: const EdgeInsets.all(12),

                    constraints: const BoxConstraints(maxWidth: 300),

                    decoration: BoxDecoration(
                      color: isUser ? Colors.red : Colors.grey[900],

                      borderRadius: BorderRadius.circular(14),
                    ),

                    child: Text(
                      message,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
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
                  child: ElevatedButton(
                    onPressed: () => choose(c),
                    child: Text(c),
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
}
