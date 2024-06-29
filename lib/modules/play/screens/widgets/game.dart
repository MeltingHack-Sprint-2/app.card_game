import 'package:card_game/components/cards/card_stack.dart';
import 'package:card_game/components/cards/uno_card.dart';
import 'package:card_game/modules/play/api/models/card_model.dart';
import 'package:card_game/modules/play/bloc/game_bloc.dart';
import 'package:card_game/modules/play/screens/widgets/avatar.dart';
import 'package:card_game/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Game extends StatelessWidget {
  final GameState state;
  final GameBloc bloc;
  const Game({
    super.key,
    required this.state,
    required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    final currentPlayer = state.players
        .firstWhere((player) => player.name == state.currentPlayer);
    final players = state.players;
    final hands = state.hands;
    final topCard =
        state.topCard ?? CardModel(id: "1", color: "red", value: "skip");

    final otherPlayer =
        players.firstWhere((player) => player.id != currentPlayer.id);

    final ownCards = hands[currentPlayer.id] ?? [];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Column(
        children: [
          _opponentDeck(playerName: otherPlayer.name, hidden: true),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CardStack(
                size: UnoCardSizes.large,
                onClick: () {
                  bloc.add(DrawCard());
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
              playerId: currentPlayer.id,
              context: context,
              bloc: bloc),
        ],
      ),
    );
  }
}

Widget _playerDeck({
  required String playerName,
  required List<CardModel> cards,
  required GameBloc bloc,
  required bool hidden,
  required BuildContext context,
  required String playerId,
}) {
  return Expanded(
    child: Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: cards.map((card) {
              return UnoCard(
                card: card,
                onClick: () =>
                    bloc.add(PlayCard(playerId: playerId, cardId: card.id)),
                hidden: hidden,
              );
            }).toList(),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Avatar(color: AppColors.lightGrey, name: playerName),
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
        Avatar(name: playerName, color: AppColors.lightGrey),
        const SizedBox(
          height: 8,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
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
