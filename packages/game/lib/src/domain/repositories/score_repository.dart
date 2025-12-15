abstract class ScoreRepository {
  Future<int> getScore(String playerId);

  Future<void> incrementScore(String playerId);

  Future<void> resetScores();

  Future<Map<String, int>> getAllScores();
}
