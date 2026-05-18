import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  final String username;

  const ChatScreen({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Red Rose"),
      ),
      body: Center(
        child: Text(
          "Hello $username",
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}