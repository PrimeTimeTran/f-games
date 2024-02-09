import 'package:flame/game.dart';
import 'package:flutter/widgets.dart';
import 'package:z_solitare/1.paper_card_game.dart';
// import 'package:z_solitare/red_knives.dart';

void main() {
  // final game = RedKnives();
  final game = KlondikeGame();
  runApp(GameWidget(game: game));
}
