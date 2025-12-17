import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/src/domain/entities/board.dart';
import 'package:game/src/domain/entities/cell.dart';
import 'package:game/src/domain/entities/player.dart';
import 'package:game/src/domain/usecases/check_winner_usecase.dart';

void main() {
  group('CheckWinnerUseCase', () {
    final CheckWinnerUseCase useCase = CheckWinnerUseCase();
    final Player player1 = Player(id: '1', symbol: 'X', color: Colors.blue);
    final Player player2 = Player(id: '2', symbol: 'O', color: Colors.red);

    test('should return null when no winner', () {
      final board = Board();
      final combination = useCase.getWinnerCombination(
        board: board,
        player: player1,
      );

      expect(combination, null);
    });

    test('should detect winner in first row', () {
      final cells = List.generate(9, (index) => Cell.empty());
      cells[0] = Cell.filled(player1);
      cells[1] = Cell.filled(player1);
      cells[2] = Cell.filled(player1);
      final board = Board.fromCells(cells);

      final combination = useCase.getWinnerCombination(
        board: board,
        player: player1,
      );

      expect(combination, [0, 1, 2]);
    });

    test('should detect winner in second row', () {
      final cells = List.generate(9, (index) => Cell.empty());
      cells[3] = Cell.filled(player1);
      cells[4] = Cell.filled(player1);
      cells[5] = Cell.filled(player1);
      final board = Board.fromCells(cells);

      final combination = useCase.getWinnerCombination(
        board: board,
        player: player1,
      );

      expect(combination, [3, 4, 5]);
    });

    test('should detect winner in third row', () {
      final cells = List.generate(9, (index) => Cell.empty());
      cells[6] = Cell.filled(player1);
      cells[7] = Cell.filled(player1);
      cells[8] = Cell.filled(player1);
      final board = Board.fromCells(cells);

      final combination = useCase.getWinnerCombination(
        board: board,
        player: player1,
      );

      expect(combination, [6, 7, 8]);
    });

    test('should detect winner in first column', () {
      final cells = List.generate(9, (index) => Cell.empty());
      cells[0] = Cell.filled(player1);
      cells[3] = Cell.filled(player1);
      cells[6] = Cell.filled(player1);
      final board = Board.fromCells(cells);

      final combination = useCase.getWinnerCombination(
        board: board,
        player: player1,
      );

      expect(combination, [0, 3, 6]);
    });

    test('should detect winner in second column', () {
      final cells = List.generate(9, (index) => Cell.empty());
      cells[1] = Cell.filled(player1);
      cells[4] = Cell.filled(player1);
      cells[7] = Cell.filled(player1);
      final board = Board.fromCells(cells);

      final combination = useCase.getWinnerCombination(
        board: board,
        player: player1,
      );

      expect(combination, [1, 4, 7]);
    });

    test('should detect winner in third column', () {
      final cells = List.generate(9, (index) => Cell.empty());
      cells[2] = Cell.filled(player1);
      cells[5] = Cell.filled(player1);
      cells[8] = Cell.filled(player1);
      final board = Board.fromCells(cells);

      final combination = useCase.getWinnerCombination(
        board: board,
        player: player1,
      );

      expect(combination, [2, 5, 8]);
    });

    test('should detect winner in main diagonal', () {
      final cells = List.generate(9, (index) => Cell.empty());
      cells[0] = Cell.filled(player1);
      cells[4] = Cell.filled(player1);
      cells[8] = Cell.filled(player1);
      final board = Board.fromCells(cells);

      final combination = useCase.getWinnerCombination(
        board: board,
        player: player1,
      );

      expect(combination, [0, 4, 8]);
    });

    test('should detect winner in anti-diagonal', () {
      final cells = List.generate(9, (index) => Cell.empty());
      cells[2] = Cell.filled(player1);
      cells[4] = Cell.filled(player1);
      cells[6] = Cell.filled(player1);
      final board = Board.fromCells(cells);

      final combination = useCase.getWinnerCombination(
        board: board,
        player: player1,
      );

      expect(combination, [2, 4, 6]);
    });

    test('should return null when other player wins', () {
      final cells = List.generate(9, (index) => Cell.empty());
      cells[0] = Cell.filled(player2);
      cells[1] = Cell.filled(player2);
      cells[2] = Cell.filled(player2);
      final board = Board.fromCells(cells);

      final combination = useCase.getWinnerCombination(
        board: board,
        player: player1,
      );

      expect(combination, null);
    });

    test('should return null when combination is incomplete', () {
      final cells = List.generate(9, (index) => Cell.empty());
      cells[0] = Cell.filled(player1);
      cells[1] = Cell.filled(player1);
      // Missing third cell
      final board = Board.fromCells(cells);

      final combination = useCase.getWinnerCombination(
        board: board,
        player: player1,
      );

      expect(combination, null);
    });
  });
}
