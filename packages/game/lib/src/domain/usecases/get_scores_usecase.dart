import '../repositories/score_repository.dart';

class GetScoresUseCase {
  final ScoreRepository _repository;

  GetScoresUseCase(this._repository);

  Future<Map<String, int>> getScores() async {
    return _repository.getScores();
  }
}
