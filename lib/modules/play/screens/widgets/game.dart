import 'package:card_game/components/cards/card_stack.dart';
import 'package:card_game/components/cards/uno_card.dart';
import 'package:card_game/components/loader/loader.dart';
import 'package:card_game/modules/play/api/enums/game_events.dart';
import 'package:card_game/modules/play/api/models/card_model.dart';
import 'package:card_game/modules/play/screens/widgets/avatar.dart';
import 'package:card_game/modules/play/state/game_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  @override
  void initState() {
    super.initState();

    final gameState = Provider.of<GameState>(context, listen: false);

    // Fetch initial game state
    gameState.socket.emit(Events.GAME_STATE, {'room': gameState.config.room});

    // Set up interval to refetch game state
    gameState.refetchGameStateInterval();

    // Set up socket listeners
    gameState.socket.on(Events.GAME_STATE, (data) {
      gameState.updateGameState(data);
    });

    gameState.socket.on(Events.GAME_OVER, (data) {
      gameState.handleGameOver(data, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final gameState = Provider.of<GameState>(context);
    final currentPlayer = gameState.currentPlayer;
    final players = gameState.players;
    final hands = gameState.hands;
    final topCard = gameState.topCard;

    if (!gameState.started) {
      return const Loader(
        label: 'Loading game...',
      );
    }

    // final otherPlayer =
    //     players.firstWhere((player) => player.id != currentPlayer.id);
    // final otherCards = hands[otherPlayer.id]!;
    // final ownCards = hands[currentPlayer.id]!;

    final otherCards = [
      CardModel(id: "1", color: "blue", value: "2"),
      CardModel(id: "1", color: "blue", value: "2"),
    ];
    final ownCards = [
      CardModel(id: "1", color: "red", value: "2"),
      CardModel(id: "1", color: "blue", value: "2"),
      CardModel(id: "1", color: "yellow", value: "2"),
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Avatar(
                  // name: otherPlayer.name ,
                  name: "Mori"
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    // mainAxisSize: MainAxisSize.min,
                    children: otherCards.map((card) {
                      return UnoCard(
                        card: card,
                        hidden: true,
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CardStack(
                size: UnoCardSizes.large,
                onClick: gameState.drawCard,
                hidden: true,
              ),
              CardStack(
                size: UnoCardSizes.large,
                card: topCard,
              ),
            ],
          ),

         const SizedBox(height: 20,),
          Expanded(
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,

                  child: Row(
                    // mainAxisSize: MainAxisSize.min,
                    children: ownCards.map((card) {
                      return UnoCard(
                        card: card,
                        onClick: (playerId, cardId) =>
                            gameState.playCard(currentPlayer.id, card.id),
                        hidden: false,
                      );
                    }).toList(),
                  ),
                ),
                Avatar(
                  // name: currentPlayer.name,
                  name :"Urnna"
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}