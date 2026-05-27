class StoryNode {
  final String id;
  final List<String> messages;
  final List<String> choices;
  final Map<String, String> next;

  final Map<String, Map<String, int>> effects;

  StoryNode({
    required this.id,
    required this.messages,
    required this.choices,
    required this.next,
    this.effects = const {},
  });
}