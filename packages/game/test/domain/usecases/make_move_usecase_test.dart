import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/src/domain/game_domain.dart';

void main() {
  group('MakeMoveUseCase', () {
    final MakeMoveUseCase useCase = MakeMoveUseCase();
    const Player player = Player(id: 'id1', symbol: 'X', color: Colors.blue);
    const Player player2 = Player(id: 'id2', symbol: 'O', color: Colors.red);
    late Board board;

    setUp(() {
      board = Board.initial();
    });

    test('should fill an empty cell at the given index', () {
      const index = 0;
      expect(board.cells[index].isEmpty, true);

      board = useCase.makeMove(board: board, index: index, player: player);

      expect(board.cells[index].isFilled, true);
      expect(board.cells[index].player, player);
    });

    test('should fill different cells with the same player', () {
      board = useCase.makeMove(board: board, index: 0, player: player);
      board = useCase.makeMove(board: board, index: 4, player: player);
      board = useCase.makeMove(board: board, index: 8, player: player);

      expect(board.cells[0].player, player);
      expect(board.cells[4].player, player);
      expect(board.cells[8].player, player);
    });

    test('should fill cells with different players', () {
      board = useCase.makeMove(board: board, index: 0, player: player);
      board = useCase.makeMove(board: board, index: 1, player: player2);

      expect(board.cells[0].player, player);
      expect(board.cells[1].player, player2);
    });
  });
}
