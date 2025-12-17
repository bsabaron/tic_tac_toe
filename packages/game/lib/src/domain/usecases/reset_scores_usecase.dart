import '../repositories/score_repository.dart';

class ResetScoresUseCase {
  final ScoreRepository _repository;

  ResetScoresUseCase(this._repository);

  Future<void> resetScores() async {
    return _repository.resetScores();
  }
}
