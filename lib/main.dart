import 'package:flame/game.dart';
import 'package:flutter/widgets.dart';

import 'red_knives.dart';

void main() {
  final game = RedKnives();
  runApp(GameWidget(game: game));
}
