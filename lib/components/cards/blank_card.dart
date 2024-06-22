import 'package:card_game/components/cards/uno_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'get_card_url.dart';

class BlankCard extends StatelessWidget {
  final UnoCardSizes size;
  final bool hidden;

  const BlankCard(
      {super.key, this.size = UnoCardSizes.defaultSize, this.hidden = false});

  @override
  Widget build(BuildContext context) {
    final imageSrc = getBlankCardURL(hidden: hidden);

    return Container(
        margin: const EdgeInsets.only(right: 4.0),
        height: size == UnoCardSizes.large
            ? MediaQuery.of(context).size.height * 0.23
            : MediaQuery.of(context).size.height * 0.2,
        width: size == UnoCardSizes.large
            ? MediaQuery.of(context).size.height * 0.2
            : MediaQuery.of(context).size.height * 0.16,
        child: SvgPicture.asset(imageSrc));
  }
}
