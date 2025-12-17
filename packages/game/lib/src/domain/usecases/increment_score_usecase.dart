import '../repositories/score_repository.dart';

class IncrementScoreUseCase {
  final ScoreRepository _repository;

  IncrementScoreUseCase(this._repository);

  Future<void> incrementPlayerScore(String playerId) async {
    final scores = await _repository.getScores();
    scores[playerId] = (scores[playerId] ?? 0) + 1;
    return _repository.saveScores(scores);
  }
}
