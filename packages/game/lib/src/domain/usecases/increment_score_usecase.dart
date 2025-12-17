import '../repositories/score_repository.dart';

class IncrementScoreUseCase {
  final ScoreRepository _repository;

  IncrementScoreUseCase(this._repository);

  Future<Map<String, int>> incrementPlayerScore(String playerId) async {
    final scores = await _repository.getScores();
    Map<String, int> updatedScores = Map.from(scores);
    updatedScores[playerId] = (scores[playerId] ?? 0) + 1;
    await _repository.saveScores(updatedScores);
    return updatedScores;
  }
}
