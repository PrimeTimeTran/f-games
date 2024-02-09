import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';

import '../1.paper_card_game.dart';
import 'card.dart';
import 'pile.dart';
import 'waste_pile.dart';

class StockPile extends PositionComponent with TapCallbacks implements Pile {
  /// Which cards are currently placed onto this pile. The first card in the
  /// list is at the bottom, the last card is on top.
  final List<Card> _cards = [];

  //#region Rendering

  final _borderPaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 10
    ..color = const Color(0xFF3F5B5D);

  final _circlePaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 100
    ..color = const Color(0x883F5B5D);

  StockPile({super.position}) : super(size: KlondikeGame.cardSize);

  @override
  void acquireCard(Card card) {
    assert(card.isFaceDown);
    card.pile = this;
    card.position = position;
    card.priority = _cards.length;
    _cards.add(card);
  }

  @override
  bool canAcceptCard(Card card) => false;

  //#region Pile API

  @override
  bool canMoveCard(Card card) => false;

  //#endregion

  @override
  void onTapUp(TapUpEvent event) {
    final wastePile = parent!.firstChild<WastePile>()!;
    if (_cards.isEmpty) {
      wastePile.removeAllCards().reversed.forEach((card) {
        card.flip();
        acquireCard(card);
      });
    } else {
      for (var i = 0; i < 3; i++) {
        if (_cards.isNotEmpty) {
          final card = _cards.removeLast();
          card.flip();
          wastePile.acquireCard(card);
        }
      }
    }
  }

  @override
  void removeCard(Card card) => throw StateError('cannot remove cards');
  @override
  void render(Canvas canvas) {
    canvas.drawRRect(KlondikeGame.cardRRect, _borderPaint);
    canvas.drawCircle(
      Offset(width / 2, height / 2),
      KlondikeGame.cardWidth * 0.3,
      _circlePaint,
    );
  }

  @override
  void returnCard(Card card) => throw StateError('cannot remove cards');

  //#endregion
}
