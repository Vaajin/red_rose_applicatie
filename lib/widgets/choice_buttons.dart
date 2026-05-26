import 'package:flutter/material.dart';

class ChoiceButtons extends StatelessWidget {
  final List<String> choices;
  final Function(String) onChoose;

  const ChoiceButtons({
    super.key,
    required this.choices,
    required this.onChoose,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: choices.map((choice) {
        return SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 4,
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () => onChoose(choice),
              child: Text(choice),
            ),
          ),
        );
      }).toList(),
    );
  }
}