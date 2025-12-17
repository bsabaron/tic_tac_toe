import 'package:freezed_annotation/freezed_annotation.dart';
import 'cell.dart';

part 'board.freezed.dart';

@freezed
abstract class Board with _$Board {
  const factory Board({required List<Cell> cells}) = _Board;

  factory Board.initial() {
    return Board(cells: List.generate(9, (index) => Cell.empty()));
  }
}
