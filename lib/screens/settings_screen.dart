import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF2A0808), Color(0xFF0A0000)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Custom AppBar
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Color(0xFF886666),
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      "SETTINGS",
                      style: TextStyle(
                        color: Color(0xFFCC1111),
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 4,
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "RED ROSE SYSTEM",
                        style: TextStyle(
                          color: Color(0xFFCC1111),
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Container(
                        height: 1,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFFB71C1C), Colors.transparent],
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      const Text(
                        "This application is a narrative-driven chat experience "
                        "where player choices influence four core variables.",
                        style: TextStyle(
                          color: Color(0xFFAAAAAA),
                          fontSize: 15,
                          height: 1.6,
                        ),
                      ),

                      const SizedBox(height: 24),

                      _Section(
                        title: "VARIABLES",
                        children: const [
                          _StatRow(
                            label: "TRUST",
                            desc: "Cooperation with Red Rose",
                            color: Color(0xFF4CAF50),
                          ),
                          _StatRow(
                            label: "FEAR",
                            desc: "Resistance level",
                            color: Color(0xFFFF5722),
                          ),
                          _StatRow(
                            label: "PRESSURE",
                            desc: "Psychological influence",
                            color: Color(0xFFFF9800),
                          ),
                          _StatRow(
                            label: "EXPOSURE",
                            desc: "System risk / fail state",
                            color: Color(0xFFE53935),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      _Section(
                        title: "ENDINGS",
                        children: const [
                          _EndingRow(
                            title: "ACCEPTANCE",
                            desc: "Trust dominant",
                            color: Color(0xFFFFD700),
                          ),
                          _EndingRow(
                            title: "SUBMISSION",
                            desc: "Fear / pressure dominant",
                            color: Color(0xFFAA0000),
                          ),
                          _EndingRow(
                            title: "GAME OVER",
                            desc: "Exposure threshold reached",
                            color: Color(0xFFFF3300),
                          ),
                        ],
                      ),

                      const SizedBox(height: 40),

                      const Text(
                        "VERSION BETA 0.1",
                        style: TextStyle(
                          color: Color(0xFF443333),
                          fontSize: 11,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _Section({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFF884444),
            fontSize: 11,
            letterSpacing: 3,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1C0A0A),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF4A1515), width: 1),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }
}

class _StatRow extends StatelessWidget {
  final String label;
  final String desc;
  final Color color;

  const _StatRow({
    required this.label,
    required this.desc,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 4,
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          ),
          const SizedBox(width: 10),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              desc,
              style: const TextStyle(color: Color(0xFF886666), fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}

class _EndingRow extends StatelessWidget {
  final String title;
  final String desc;
  final Color color;

  const _EndingRow({
    required this.title,
    required this.desc,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(width: 10),
          Container(width: 1, height: 12, color: const Color(0xFF4A1515)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              desc,
              style: const TextStyle(color: Color(0xFF886666), fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
