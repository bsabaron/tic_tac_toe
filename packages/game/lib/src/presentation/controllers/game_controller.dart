import 'package:flutter/material.dart';
import 'package:game/src/domain/game_domain.dart';
import 'package:game/src/presentation/models/game_state.dart';
import 'package:game/src/presentation/controllers/score_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'game_controller.g.dart';

@riverpod
class GameController extends _$GameController {
  final MakeMoveUseCase _makeMoveUseCase = MakeMoveUseCase();
  final CheckWinnerUseCase _checkWinnerUseCase = CheckWinnerUseCase();

  final Player _player1 = Player(id: '1', symbol: 'X', color: Colors.blue);
  Player get player1 => _player1;
  final Player _player2 = Player(id: '2', symbol: 'O', color: Colors.red);
  Player get player2 => _player2;
  late Player _lastStartingPlayer = _player1;

  @override
  GameState build() {
    return GameState.initial(startingPlayer: _player1);
  }

  /// Makes a move at the given index for the current player.
  Future<void> makeMove(int index) async {
    if (state.board.cells[index].isFilled) return;
    if (state.status != GameStatus.playing) return;

    _makeMoveUseCase.makeMove(
      board: state.board,
      index: index,
      player: state.currentPlayer,
    );

    // Check for winner
    final List<int>? winnerCombination = _checkWinnerUseCase
        .getWinnerCombination(board: state.board, player: state.currentPlayer);

    if (winnerCombination != null) {
      await ref
          .read(scoreControllerProvider.notifier)
          .incrementScore(state.currentPlayer.id);
      state = state.copyWith(
        board: state.board,
        status: GameStatus.won,
        winnerCombination: winnerCombination,
      );
      return;
    }

    // Check for draw
    if (state.board.isFull) {
      state = state.copyWith(board: state.board, status: GameStatus.draw);
      return;
    }

    // Switch to next player
    final nextPlayer =
        state.currentPlayer.id == _player1.id ? _player2 : _player1;
    state = state.copyWith(board: state.board, currentPlayer: nextPlayer);
  }

  Future<void> reset() async {
    // Alternate starting player
    final nextStartingPlayer =
        _lastStartingPlayer == _player1 ? _player2 : _player1;
    state = GameState.initial(startingPlayer: nextStartingPlayer);
    _lastStartingPlayer = nextStartingPlayer;
  }
}
