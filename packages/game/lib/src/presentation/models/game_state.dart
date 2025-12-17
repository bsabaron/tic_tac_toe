import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/board.dart';
import '../../domain/entities/player.dart';

part 'game_state.freezed.dart';

enum GameStatus { playing, won, draw }

@freezed
abstract class GameState with _$GameState {
  const factory GameState({
    required Board board,
    required Player currentPlayer,
    required GameStatus status,
    List<int>? winnerCombination,
  }) = _GameState;

  factory GameState.initial({required Player startingPlayer}) {
    return GameState(
      board: Board.initial(),
      currentPlayer: startingPlayer,
      status: GameStatus.playing,
      winnerCombination: null,
    );
  }
}
