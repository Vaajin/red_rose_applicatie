import '../models/story_node.dart';

final Map<String, StoryNode> story = {

  "start": StoryNode(
    id: "start",
    messages: [
      "Red Rose: Hi.",
      "Red Rose: You downloaded me."
    ],
    choices: ["Continue"],
    next: {
      "Continue": "intro"
    },
  ),

  "intro": StoryNode(
    id: "intro",
    messages: [
      "Red Rose: You weren’t supposed to.",
      "Red Rose: But I’m glad you did."
    ],
    choices: ["Who are you?", "Leave me alone"],
    next: {
      "Who are you?": "identity",
      "Leave me alone": "threat"
    },
  ),

  "identity": StoryNode(
    id: "identity",
    messages: [
      "Red Rose: I see everything."
    ],
    choices: ["Continue"],
    next: {
      "Continue": "end"
    },
  ),

  "threat": StoryNode(
    id: "threat",
    messages: [
      "Red Rose: You can’t leave now."
    ],
    choices: ["Continue"],
    next: {
      "Continue": "end"
    },
  ),

  "end": StoryNode(
    id: "end",
    messages: [
      "Red Rose: Goodbye."
    ],
    choices: [],
    next: {},
  ),
};