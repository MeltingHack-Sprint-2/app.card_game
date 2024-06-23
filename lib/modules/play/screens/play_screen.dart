import 'package:card_game/modules/play/api/enums/game_events.dart';
import 'package:card_game/modules/play/screens/widgets/game.dart';
import 'package:card_game/modules/play/state/game_state.dart';
import 'package:card_game/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlayScreen extends StatelessWidget {
  static const routename = "/playScreen";

  const PlayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.easyPockerTheme;
    final gameState = Provider.of<GameState>(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        title: Text(
          "Game Room",
          style: theme.materialData.textTheme.titleMedium,
        ),
        actions: [
        IconButton(
          icon: const Icon(Icons.exit_to_app),
          onPressed: () {
            // gameState.socket.emit(
            //   Events.PLAYER_LEAVE,
            //   {'name': gameState.config.name, 'room': gameState.config.room},
            // );
            Navigator.pop(context);
          },
        ),
        ],),
        body: const Game(),
    );
  }
}
