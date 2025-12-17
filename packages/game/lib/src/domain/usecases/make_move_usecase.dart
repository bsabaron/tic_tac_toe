import '../game_domain.dart';

class MakeMoveUseCase {
  Board makeMove({
    required Board board,
    required int index,
    required Player player,
  }) {
    final newCells = board.cells.toList();
    newCells[index] = Cell.filled(player);
    return board.copyWith(cells: newCells);
  }
}
