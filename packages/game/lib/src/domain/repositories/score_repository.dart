abstract class ScoreRepository {
  Future<Map<String, int>> getScores();

  Future<Map<String, int>> saveScores(Map<String, int> scores);

  Future<void> resetScores();
}
