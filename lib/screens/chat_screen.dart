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

    currentId = node.next[choice]!;

    loadNode();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Red Rose - ${widget.username}"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: messages
                  .map((m) => Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          m,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ))
                  .toList(),
            ),
          ),

          if (loading)
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "Red Rose is typing...",
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
            )
        ],
      ),
    );
  }
}