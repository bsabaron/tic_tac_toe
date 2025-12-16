abstract class ScoreRepository {
  Future<Map<String, int>> getScores();

  Future<void> incrementPlayerScore(String playerId);

  Future<void> resetScores();
}
