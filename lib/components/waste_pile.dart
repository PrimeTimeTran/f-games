import 'package:flame/components.dart';

import '../1.paper_card_game.dart';
import 'card.dart';
import 'pile.dart';

class WastePile extends PositionComponent implements Pile {
  final List<Card> _cards = [];

  final Vector2 _fanOffset = Vector2(KlondikeGame.cardWidth * 0.2, 0);
  WastePile({super.position}) : super(size: KlondikeGame.cardSize);

  @override
  void acquireCard(Card card) {
    assert(card.isFaceUp);
    card.pile = this;
    card.position = position;
    card.priority = _cards.length;
    _cards.add(card);
    _fanOutTopCards();
  }

  @override
  bool canAcceptCard(Card card) => false;

  //#region Pile API

  @override
  bool canMoveCard(Card card) => _cards.isNotEmpty && card == _cards.last;

  //#endregion

  List<Card> removeAllCards() {
    final cards = _cards.toList();
    _cards.clear();
    return cards;
  }

  @override
  void removeCard(Card card) {
    assert(canMoveCard(card));
    _cards.removeLast();
    _fanOutTopCards();
  }

  @override
  void returnCard(Card card) {
    card.priority = _cards.indexOf(card);
    _fanOutTopCards();
  }

  void _fanOutTopCards() {
    final n = _cards.length;
    for (var i = 0; i < n; i++) {
      _cards[i].position = position;
    }
    if (n == 2) {
      _cards[1].position.add(_fanOffset);
    } else if (n >= 3) {
      _cards[n - 2].position.add(_fanOffset);
      _cards[n - 1].position.addScaled(_fanOffset, 2);
    }
  }
}
