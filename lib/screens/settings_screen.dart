import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Settings",
          style: TextStyle(color: Colors.red),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "RED ROSE SYSTEM",
              style: TextStyle(
                color: Colors.red,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 20),

            Text(
              "This application is a narrative-driven chat experience "
              "where player choices influence four core variables:",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),

            SizedBox(height: 20),

            Text(
              "- Trust (cooperation)\n"
              "- Fear (resistance)\n"
              "- Pressure (psychological influence)\n"
              "- Exposure (system risk / fail state)",
              style: TextStyle(color: Colors.white70),
            ),

            SizedBox(height: 30),

            Text(
              "Endings:\n"
              "• Acceptance → trust dominant\n"
              "• Submission → fear/pressure dominant\n"
              "• Game Over → exposure threshold",
              style: TextStyle(color: Colors.white70),
            ),

            SizedBox(height: 30),

            Text(
              "Version: Beta 0.1",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}