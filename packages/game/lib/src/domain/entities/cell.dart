import 'package:game/src/domain/entities/player.dart';

class Cell {
  final Player? player;

  const Cell.empty() : player = null;

  const Cell.filled(this.player);

  bool get isEmpty => player == null;

  bool get isFilled => player != null;
}
