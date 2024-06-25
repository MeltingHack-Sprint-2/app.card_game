import 'package:card_game/modules/play/api/models/game_config.dart';
import 'package:card_game/modules/play/api/models/player_model.dart';
import 'package:card_game/modules/play/bloc/game_bloc.dart';
import 'package:card_game/modules/play/screens/widgets/game.dart';
import 'package:card_game/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayScreen extends StatelessWidget {
  static const routename = "/playScreen";
  final GameConfig config;
  final Player currentPlayer;
  const PlayScreen(
      {super.key, required this.config, required this.currentPlayer});

  @override
  Widget build(BuildContext context) {
    final theme = context.easyPockerTheme;
    // final gameState = Provider.of<GameState>(context);
    return BlocProvider(
      create: (context) =>
          GameBloc(config, currentPlayer), // Add config and current player
      child: BlocConsumer<GameBloc, GameState>(
        listener: (context, state) {

        },
        builder: (context, state) {
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
          
            Navigator.pop(context);
          },
        ),
              ],
            ),
            body: const Game(),
          );
        },
      ),
    );
  }
}
