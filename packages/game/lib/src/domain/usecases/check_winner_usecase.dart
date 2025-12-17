import 'package:game/src/domain/game_domain.dart';

class CheckWinnerUseCase {
  /// All winning combinations in a 3x3 Tic-Tac-Toe board
  static const _winningCombinations = [
    // Rows
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    // Columns
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    // Diagonals
    [0, 4, 8],
    [2, 4, 6],
  ];

  List<int>? getWinnerCombination({
    required Board board,
    required Player player,
  }) {
    // Check all winning combinations
    for (final combination in _winningCombinations) {
      final cellsOfCombination =
          combination.map((index) => board.cells[index]).toList();

      // Check if all cells in the combination have the same player symbol
      if (cellsOfCombination.every(
        (cell) => cell.isFilled && cell.player?.id == player.id,
      )) {
        return combination;
      }
    }

    return null;
  }
}
