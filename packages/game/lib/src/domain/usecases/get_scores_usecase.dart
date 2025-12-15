import '../repositories/score_repository.dart';

/// Use case for getting all player scores.
class GetScoresUseCase {
  final ScoreRepository _repository;

  GetScoresUseCase(this._repository);

  /// Gets all scores as a map of player ID to score.
  Future<Map<String, int>> getAllScores() async {
    return await _repository.getAllScores();
  }

  /// Gets the score for a specific player by their ID.
  Future<int> getScore(String playerId) async {
    return await _repository.getScore(playerId);
  }
}
