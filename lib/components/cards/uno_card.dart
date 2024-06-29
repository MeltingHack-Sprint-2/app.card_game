import 'package:card_game/components/cards/get_card_url.dart';
import 'package:card_game/modules/play/api/models/card_model.dart';
import 'package:card_game/modules/play/api/models/player_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum UnoCardSizes { large, defaultSize }

class UnoCard extends StatelessWidget {
  const UnoCard(
      {super.key,
      required this.card,
      this.currentPlayer,
      required this.hidden,
      this.size = UnoCardSizes.defaultSize,
      this.onClick});

  final CardModel card;
  final Player? currentPlayer;
  final bool hidden;
  final UnoCardSizes size;
  final void Function()? onClick;

  @override
  Widget build(BuildContext context) {
    final allowPlay = onClick != null && currentPlayer != null;
    final imageSrc = getCardImageURL(card, hidden: hidden);
    return GestureDetector(
      onTap: onClick,
      child: SizedBox(
          // margin: const EdgeInsets.only(right: 4.0),
          height: size == UnoCardSizes.large
              ? MediaQuery.of(context).size.height * 0.23
              : MediaQuery.of(context).size.height * 0.2,
          width: size == UnoCardSizes.large
              ? MediaQuery.of(context).size.height * 0.2
              : MediaQuery.of(context).size.height * 0.16,
          child: SvgPicture.asset(imageSrc)),
    );
  }
}
