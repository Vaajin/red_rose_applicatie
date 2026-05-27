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

    String nextId = node.next[choice]!;

    if (fear >= 3) {
      nextId = "soft_threat";
    }

    if (exposure >= 2) {
      nextId = "end";
    }

    if (trust >= 6) {
      exposure += 1;
    }

    if (fear >= 4) {
      exposure += 1;
    }
    
    currentId = nextId;
  }

  String? getEnding() {
    if (exposure >= 3) {
      return "GAME_OVER";
    }

    if (fear >= 5) {
      return "SUBMISSION";
    }

    if (trust >= 6) {
      return "ACCEPTANCE";
    }

    return null;
  }
}
