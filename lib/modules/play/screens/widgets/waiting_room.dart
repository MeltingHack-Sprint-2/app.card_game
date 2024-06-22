import 'package:card_game/components/buttons/button.dart';
import 'package:card_game/modules/play/api/enums/game_events.dart';
import 'package:card_game/modules/play/screens/widgets/avatar.dart';
import 'package:card_game/modules/play/state/game_state.dart';
import 'package:card_game/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class WaitingRoom extends StatelessWidget {
  const WaitingRoom({super.key});

  @override
  Widget build(BuildContext context) {
    final gameState = Provider.of<GameState>(context);
    final players = gameState.players;
    final theme = context.easyPockerTheme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: players.map((player) => Avatar(name: player.name))
                .toList(),
          ),
          Text('Waiting for more players to join...',
              style: theme.materialData.textTheme.bodyLarge,),
          PrimaryButton(
            onPressed: () {
              gameState.socket.emit(Events.GAME_START,
                {
                  'room': gameState.config.room,
                  'hand_size': gameState.config.handSize
                },
              );
            },
            text: 'Start Game',
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () async {
              final url = 'http://web_url?join=${gameState.config.room}';
              await Clipboard.setData(ClipboardData(text: url));
              Fluttertoast.showToast(msg: 'Copied URL to clipboard');
            },
          ),
        ],
      ),
    );
  }
}