import 'package:freezed_annotation/freezed_annotation.dart';
import 'player.dart';

part 'cell.freezed.dart';

@freezed
abstract class Cell with _$Cell {
  const factory Cell({Player? player}) = _Cell;

  factory Cell.empty() {
    return Cell(player: null);
  }

  factory Cell.filled(Player player) {
    return Cell(player: player);
  }
}
