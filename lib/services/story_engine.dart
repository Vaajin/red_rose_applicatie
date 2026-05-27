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

    if (choice.toLowerCase().contains("who")) {
      trust++;
    }

    if (choice.toLowerCase().contains("leave")) {
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