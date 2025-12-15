import '../../domain/entities/board.dart';
import '../../domain/entities/player.dart';

enum GameStatus { playing, won, draw }

class GameState {
  final Board board;
  final Player currentPlayer;
  final GameStatus status;
  final List<int>? winnerCombination;

  const GameState({
    required this.board,
    required this.currentPlayer,
    required this.status,
    this.winnerCombination,
  });

  factory GameState.initial({required Player startingPlayer}) {
    return GameState(
      board: Board(),
      currentPlayer: startingPlayer,
      status: GameStatus.playing,
      winnerCombination: null,
    );
  }

  GameState copyWith({
    Board? board,
    Player? currentPlayer,
    GameStatus? status,
    List<int>? winnerCombination,
  }) {
    return GameState(
      board: board ?? this.board,
      currentPlayer: currentPlayer ?? this.currentPlayer,
      status: status ?? this.status,
      winnerCombination: winnerCombination ?? this.winnerCombination,
    );
  }
}
