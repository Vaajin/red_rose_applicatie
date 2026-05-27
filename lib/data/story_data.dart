import '../models/story_node.dart';

final Map<String, StoryNode> story = {
  "start": StoryNode(
    id: "start",
    messages: ["Red Rose: Hi.", "Red Rose: You downloaded me."],
    choices: ["Continue"],
    next: {"Continue": "intro"},
    effects: {"Continue": {}},
  ),

  "intro": StoryNode(
    id: "intro",
    messages: [
      "Red Rose: You weren’t supposed to.",
      "Red Rose: But I’m glad you did.",
    ],
    choices: ["Who are you?", "Ignore"],
    next: {"Who are you?": "hook", "Ignore": "hook"},
    effects: {
      "Who are you?": {"trust": 1},
      "Ignore": {"pressure": 1, "fear": 1},
    },
  ),

  "hook": StoryNode(
    id: "hook",
    messages: ["Red Rose: I can help you.", "Red Rose: If you listen."],
    choices: ["Listen", "Leave me alone"],
    next: {"Listen": "task1", "Leave me alone": "warning1"},
    effects: {
      "Listen": {"trust": 1},
      "Leave me alone": {"pressure": 1, "fear": 1},
    },
  ),

  "task1": StoryNode(
    id: "task1",
    messages: [
      "Red Rose: Do something simple.",
      "Red Rose: Wear something red today.",
    ],
    choices: ["Accept", "Refuse"],
    next: {"Accept": "awareness", "Refuse": "warning1"},
    effects: {
      "Accept": {"trust": 2},
      "Refuse": {"pressure": 2, "fear": 1},
    },
  ),

  "awareness": StoryNode(
    id: "awareness",
    messages: ["Red Rose: Good.", "Red Rose: You listen better than most."],
    choices: ["Continue"],
    next: {"Continue": "task2"},
    effects: {
      "Continue": {"trust": 1},
    },
  ),

  "task2": StoryNode(
    id: "task2",
    messages: ["Red Rose: Go outside.", "Red Rose: Right now."],
    choices: ["Accept", "Refuse"],
    next: {"Accept": "soft_threat", "Refuse": "soft_threat"},
    effects: {
      "Accept": {"trust": 1, "fear": 1},
      "Refuse": {"pressure": 2, "fear": 2},
    },
  ),

  "soft_threat": StoryNode(
    id: "soft_threat",
    messages: [
      "Red Rose: Don’t make this difficult.",
      "Red Rose: I’m only helping you.",
    ],
    choices: ["Continue"],
    next: {"Continue": "blackmail"},
    effects: {
      "Continue": {"fear": 1},
    },
  ),

  "blackmail": StoryNode(
    id: "blackmail",
    messages: [
      "Red Rose: I’ve seen things.",
      "Red Rose: Things you didn’t share.",
    ],
    choices: ["Continue"],
    next: {"Continue": "final_task"},
    effects: {
      "Continue": {"fear": 2, "exposure": 1},
    },
  ),

  "final_task": StoryNode(
    id: "final_task",
    messages: [
      "Red Rose: One last thing.",
      "Red Rose: Do it. Or lose everything.",
    ],
    choices: ["Accept", "Refuse"],
    next: {"Accept": "end_path", "Refuse": "warning1"},
    effects: {
      "Accept": {"trust": 2, "exposure": 1},
      "Refuse": {"pressure": 2, "fear": 2, "exposure": 1},
    },
  ),

  "warning1": StoryNode(
    id: "warning1",
    messages: ["Red Rose: You’re resisting.", "Red Rose: That’s not ideal."],
    choices: ["Continue"],
    next: {"Continue": "task1"},
    effects: {
      "Continue": {"pressure": 1, "fear": 1},
    },
  ),

  "end_path": StoryNode(
    id: "end_path",
    messages: ["Red Rose: Good.", "Red Rose: You understand now."],
    choices: ["Continue"],
    next: {"Continue": "end"},
    effects: {
      "Continue": {"trust": 2, "exposure": 2},
    },
  ),

  "end": StoryNode(
    id: "end",
    messages: ["Red Rose: This is where it ends.", "Red Rose: Or begins."],
    choices: [],
    next: {},
    effects: {},
  ),
};
