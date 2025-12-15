import '../../domain/repositories/score_repository.dart';
import '../exceptions/game_repository_exception.dart';

class ScoreRepositoryImpl implements ScoreRepository {
  final Map<String, int> _scores = {};

  @override
  Future<int> getScore(String playerId) async {
    try {
      return _scores[playerId] ?? 0;
    } catch (e) {
      throw RepositoryOperationException('Failed to get score: $e');
    }
  }

  @override
  Future<void> incrementScore(String playerId) async {
    try {
      _scores[playerId] = (_scores[playerId] ?? 0) + 1;
    } catch (e) {
      throw RepositoryOperationException('Failed to increment score: $e');
    }
  }

  @override
  Future<void> resetScores() async {
    try {
      _scores.clear();
    } catch (e) {
      throw RepositoryOperationException('Failed to reset scores: $e');
    }
  }

  @override
  Future<Map<String, int>> getAllScores() async {
    try {
      return Map<String, int>.from(_scores);
    } catch (e) {
      throw RepositoryOperationException('Failed to get all scores: $e');
    }
  }
}
