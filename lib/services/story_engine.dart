import '../data/story_data.dart';
import '../models/story_node.dart';

class StoryEngine {
  String currentId = "start";

  int trust = 0;
  int pressure = 0;
  int fear = 0;
  int exposure = 0;

  StoryNode get node => story[currentId]!;

  void choose(String choice) {
    final effects = node.effects[choice];

    if (effects != null) {
      trust += effects["trust"] ?? 0;
      pressure += effects["pressure"] ?? 0;
      fear += effects["fear"] ?? 0;
      exposure += effects["exposure"] ?? 0;
    }

    currentId = node.next[choice]!;
  }

  String? getEnding() {
    if (exposure >= 7) {
      return "GAME_OVER";
    }

    if (currentId != "end") {
      return null;
    }

    if (trust >= 6 && trust > fear && trust > pressure) {
      return "ACCEPTANCE";
    }

    return "SUBMISSION";
  }
}
