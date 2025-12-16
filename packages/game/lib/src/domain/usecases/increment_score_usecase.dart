import '../repositories/score_repository.dart';

class IncrementScoreUseCase {
  final ScoreRepository _repository;

  IncrementScoreUseCase(this._repository);

  /// Increments the score for the given player ID.
  Future<void> incrementPlayerScore(String playerId) async {
    await _repository.incrementPlayerScore(playerId);
  }
}
