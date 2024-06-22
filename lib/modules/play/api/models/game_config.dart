
// GameConfig model
import 'package:card_game/modules/play/api/enums/game_action.dart';

class GameConfig {
  final String action;
  final String name;
  final String room;
  final int handSize;

  GameConfig({
    required this.action,
    required this.name,
    required this.room,
    required this.handSize,
  });

  Map<String, dynamic> toJson() {
    return {
      'action': action,
      'name': name,
      'room': room,
      'hand_size': handSize,
    };
  }
}