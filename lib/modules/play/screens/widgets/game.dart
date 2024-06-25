import 'package:card_game/components/cards/card_stack.dart';
import 'package:card_game/components/cards/uno_card.dart';
import 'package:card_game/components/loader/loader.dart';
import 'package:card_game/modules/play/api/models/card_model.dart';
import 'package:card_game/modules/play/bloc/game_bloc.dart';
import 'package:card_game/modules/play/screens/widgets/avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Game extends StatelessWidget {
  final GameState state;
  const Game({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final currentPlayer = state.currentPlayer;
    final players = state.players;
    final hands = state.hands;
    // final topCard = gameState.topCard;
    final topCard =
        state.topCard ?? CardModel(id: "1", color: "red", value: "skip");

    if (!state.started) {
      return const Loader(
        label: 'Loading game...',
      );
    }

    final otherPlayer =
        players.firstWhere((player) => player.id != currentPlayer.id);

    final ownCards = hands[currentPlayer.id] ?? [];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Column(
        children: [
          _opponentDeck(playerName: otherPlayer.name, hidden: true),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CardStack(
                size: UnoCardSizes.large,
                onClick: () {
                  context.read<GameBloc>().add(DrawCard());
                },
                hidden: true,
              ),
              CardStack(
                size: UnoCardSizes.large,
                card: topCard,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          _playerDeck(
              playerName: currentPlayer.name,
              cards: ownCards,
              hidden: false,
              isCurrentPlayer: true),
        ],
      ),
    );
  }
}

Widget _playerDeck(
    {required String playerName,
    required List<CardModel> cards,
    required bool hidden,
    bool isCurrentPlayer = false}) {
  return Expanded(
    child: Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            // mainAxisSize: MainAxisSize.min,
            children: cards.map((card) {
              return UnoCard(
                card: card,
                hidden: hidden,
              );
            }).toList(),
          ),
        ),
        if (isCurrentPlayer)
          const SizedBox(
            height: 8,
          ),
        if (isCurrentPlayer)
          Avatar(
              // name: otherPlayer.name ,
              name: playerName),
      ],
    ),
  );
}

Widget _opponentDeck({
  required String playerName,
  required bool hidden,
}) {
  return Expanded(
    child: Column(
      children: [
        Avatar(
            // name: otherPlayer.name ,
            name: playerName),
        const SizedBox(
          height: 8,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            // mainAxisSize: MainAxisSize.min,
            children: [
              UnoCard(
                card: CardModel(id: '1', color: 'blue', value: '1'),
                hidden: true,
              ),
              UnoCard(
                card: CardModel(id: '1', color: 'blue', value: '1'),
                hidden: true,
              ),
              UnoCard(
                card: CardModel(id: '1', color: 'blue', value: '1'),
                hidden: true,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
