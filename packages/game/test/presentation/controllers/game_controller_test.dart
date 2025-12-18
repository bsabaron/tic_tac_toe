import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game/src/domain/game_domain.dart';
import 'package:game/src/presentation/controllers/game_controller.dart';
import 'package:game/src/presentation/controllers/score_controller.dart';
import 'package:game/src/presentation/models/game_state.dart';

import 'score_controller_test_mock.dart';

void main() {
  group('GameController', () {
    late ProviderContainer container;
    late GameController controller;
    late Player player1;
    late Player player2;
    late MockScoreController mockScoreController;

    setUp(() {
      mockScoreController = MockScoreController();
      container = ProviderContainer(
        overrides: [
          scoreControllerProvider.overrideWith(() => mockScoreController),
        ],
      );
      controller = container.read(gameControllerProvider.notifier);
      player1 = controller.player1;
      player2 = controller.player2;
    });

    tearDown(() {
      container.dispose();
    });

    test('should initialize with player1 as starting player', () {
      final initialState = container.read(gameControllerProvider);

      expect(initialState.currentPlayer, player1);
      expect(initialState.status, GameStatus.playing);
      expect(initialState.board.cells.every((cell) => cell.isEmpty), true);
    });

    test('should make a move and switch to next player', () async {
      await controller.makeMove(0);

      final state = container.read(gameControllerProvider);
      expect(state.board.cells[0].player, player1);
      expect(state.currentPlayer, player2);
      expect(state.status, GameStatus.playing);
    });

    test('should not make a move if cell is already filled', () async {
      await controller.makeMove(0);
      final stateAfterFirstMove = container.read(gameControllerProvider);

      await controller.makeMove(0);

      final stateAfterSecondMove = container.read(gameControllerProvider);
      expect(stateAfterSecondMove.board.cells[0].player, player1);
      expect(
        stateAfterSecondMove.currentPlayer,
        stateAfterFirstMove.currentPlayer,
      );
    });

    test('should not make a move if game is not in playing status', () async {
      controller.state = controller.state.copyWith(status: GameStatus.won);

      await controller.makeMove(4);

      final state = container.read(gameControllerProvider);
      expect(state.status, GameStatus.won);
      expect(state.board.cells[4].isEmpty, true);
    });

    test('should detect winner in first row', () async {
      final cells = List.generate(9, (index) => Cell.empty());
      cells[0] = Cell.filled(player1);
      cells[1] = Cell.filled(player1);
      final board = Board(cells: cells);
      controller.state = controller.state.copyWith(board: board);

      await controller.makeMove(2);

      final state = container.read(gameControllerProvider);
      expect(state.status, GameStatus.won);
      expect(state.winnerCombination, [0, 1, 2]);
      expect(state.currentPlayer, player1);
    });

    test('should detect draw when board is full', () async {
      final cells = List.generate(9, (index) => Cell.empty());
      cells[0] = Cell.filled(player1);
      cells[1] = Cell.filled(player2);
      cells[2] = Cell.filled(player1);
      cells[3] = Cell.filled(player2);
      cells[4] = Cell.filled(player1);
      cells[5] = Cell.filled(player2);
      cells[6] = Cell.filled(player2);
      cells[7] = Cell.filled(player1);

      final board = Board(cells: cells);
      controller.state = controller.state.copyWith(
        board: board,
        currentPlayer: player2,
      );

      await controller.makeMove(8);

      final state = container.read(gameControllerProvider);
      expect(state.status, GameStatus.draw);
      expect(state.board.isFull, true);
    });

    test('should reset game and alternate starting player', () async {
      await controller.makeMove(0);

      await controller.reset();
      final stateAfterFirstReset = container.read(gameControllerProvider);
      expect(stateAfterFirstReset.currentPlayer, player2);

      await controller.reset();
      final stateAfterSecondReset = container.read(gameControllerProvider);
      expect(stateAfterSecondReset.currentPlayer, player1);
      expect(
        stateAfterSecondReset.board.cells.every((cell) => cell.isEmpty),
        true,
      );
    });

    test('should alternate players correctly', () async {
      await controller.makeMove(0);
      expect(container.read(gameControllerProvider).currentPlayer, player2);

      await controller.makeMove(1);
      expect(container.read(gameControllerProvider).currentPlayer, player1);

      await controller.makeMove(2);
      expect(container.read(gameControllerProvider).currentPlayer, player2);
    });
  });
}
