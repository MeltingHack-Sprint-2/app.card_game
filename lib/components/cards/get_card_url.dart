import 'package:card_game/modules/play/api/models/card_model.dart';

String getCardImageURL(CardModel card, {bool hidden = false})  {
  if (hidden) {
    return 'assets/cards/back.svg';
  }

  return 'assets/cards/${card.color}/${card.value}.svg';
}

String getBlankCardURL({bool hidden = false})  {
  if (hidden) {
    return 'assets/cards/back.svg';
  }

  return 'assets/cards/blank.svg';
}
