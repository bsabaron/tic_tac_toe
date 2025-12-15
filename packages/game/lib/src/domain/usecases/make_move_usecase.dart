import '../game_domain.dart';

class MakeMoveUseCase {
  void makeMove({
    required Board board,
    required int index,
    required Player player,
  }) {
    board.cells[index] = Cell.filled(player);
  }
}
