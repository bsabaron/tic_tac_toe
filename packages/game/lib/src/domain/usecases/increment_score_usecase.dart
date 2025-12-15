import '../repositories/score_repository.dart';

/// Use case for incrementing a player's score.
class IncrementScoreUseCase {
  final ScoreRepository _repository;

  IncrementScoreUseCase(this._repository);

  /// Increments the score for the given player ID.
  Future<void> incrementScore(String playerId) async {
    await _repository.incrementScore(playerId);
  }
}
