import 'package:card_game/components/cards/uno_card.dart';
import 'package:card_game/modules/play/api/models/card_model.dart';
import 'package:flutter/material.dart';

import 'blank_card.dart';

class CardStack extends StatelessWidget {
  final String? className;
  final CardModel? card;
  final UnoCardSizes size;
  final bool hidden;
  final void Function()? onClick;
  final double offset;

  const CardStack({super.key,
    this.className,
    this.offset = 10.0,
    this.card,
    this.size = UnoCardSizes.defaultSize,
    this.hidden = false,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 200,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.black),
          ),
          child: Stack(
            children: [
              if (card != null)
                Positioned(
                  top: 0,
                  left: 0,
                  child: UnoCard(
                    size: size,
                    card: card!,
                    hidden: hidden,
                  ),
                ),
              Positioned(
                top: size == UnoCardSizes.large ? 8.0 : 6.0,
                left: size == UnoCardSizes.large ? 6.0 : 4.0,
                child: BlankCard(
                  size: size,
                  hidden: hidden,
                ),
              ),
              Positioned(
                top: size == UnoCardSizes.large ? 8.0 : 6.0,
                left: size == UnoCardSizes.large ? 12.0 : 8.0,
                child: BlankCard(
                  size: size,
                  hidden: hidden,
                ),
              ),
              Positioned(
                top: size == UnoCardSizes.large ? 8.0 : 6.0,
                left: size == UnoCardSizes.large ? 18.0 : 12.0,
                child: BlankCard(
                  size: size,
                  hidden: hidden,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
