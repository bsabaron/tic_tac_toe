abstract class ScoreRepository {
  Future<Map<String, int>> getScores();

  Future<void> saveScores(Map<String, int> scores);

  Future<void> resetScores();
}
