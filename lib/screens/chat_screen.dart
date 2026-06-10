import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/story_node.dart';
import '../services/story_engine.dart';
import '../widgets/choice_buttons.dart';
import '../widgets/message_bubble.dart';
import 'settings_screen.dart';
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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF2A0808), Color(0xFF120404), Color(0xFF0A0000)],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Faded rose watermark in background
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: Opacity(
                    opacity: 0.04,
                    child: SvgPicture.asset(
                      'assets/Red_Rose_logo.svg',
                      width: 320,
                      height: 320,
                      colorFilter: const ColorFilter.matrix(<double>[
                        -1,
                        0,
                        0,
                        0,
                        200,
                        0,
                        0,
                        0,
                        0,
                        10,
                        0,
                        0,
                        0,
                        0,
                        10,
                        0,
                        0,
                        0,
                        1,
                        0,
                      ]),
                    ),
                  ),
                ),
              ),

              // Main content
              Column(
                children: [
                  // AppBar
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Color(0x334A1515), width: 1),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: const Color(
                                  0xFFB71C1C,
                                ).withValues(alpha: 0.4),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: SvgPicture.asset(
                            'assets/Red_Rose_logo.svg',
                            width: 34,
                            height: 34,
                            colorFilter: const ColorFilter.matrix(<double>[
                              -1,
                              0,
                              0,
                              0,
                              200,
                              0,
                              0,
                              0,
                              0,
                              10,
                              0,
                              0,
                              0,
                              0,
                              10,
                              0,
                              0,
                              0,
                              1,
                              0,
                            ]),
                          ),
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "RED ROSE",
                                style: TextStyle(
                                  color: Color(0xFFCC1111),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 3,
                                ),
                              ),
                              Text(
                                widget.username,
                                style: const TextStyle(
                                  color: Color(0xFF886666),
                                  fontSize: 11,
                                  letterSpacing: 1,
                                ),
                              ),
                            ],
                          ),
                        ),

                        IconButton(
                          icon: const Icon(
                            Icons.settings_outlined,
                            color: Color(0xFF886666),
                            size: 20,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const SettingsScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  // Stats bar
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _StatChip(
                          label: "TRUST",
                          value: engine.trust,
                          color: const Color(0xFF4CAF50),
                        ),
                        _StatChip(
                          label: "PRESSURE",
                          value: engine.pressure,
                          color: const Color(0xFFFF9800),
                        ),
                        _StatChip(
                          label: "FEAR",
                          value: engine.fear,
                          color: const Color(0xFFFF5722),
                        ),
                        _StatChip(
                          label: "EXPOSURE",
                          value: engine.exposure,
                          color: const Color(0xFFE53935),
                        ),
                      ],
                    ),
                  ),

                  // Messages
                  Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        return MessageBubble(message: messages[index]);
                      },
                    ),
                  ),

                  // Loading indicator
                  if (loading)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(
                                0xFF884444,
                              ).withValues(alpha: 0.6),
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Text(
                            "Red Rose is watching...",
                            style: TextStyle(
                              color: Color(0xFF664444),
                              fontSize: 12,
                              letterSpacing: 1,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),

                  // Choice buttons
                  if (!loading)
                    ChoiceButtons(choices: node.choices, onChoose: choose),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final int value;
  final Color color;

  const _StatChip({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF664444),
            fontSize: 9,
            letterSpacing: 1,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value.toString(),
          style: TextStyle(
            color: color,
            fontSize: 14,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}
