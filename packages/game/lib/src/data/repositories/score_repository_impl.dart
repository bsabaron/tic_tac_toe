import 'dart:convert';

import 'package:core/core.dart';

import '../../domain/repositories/score_repository.dart';
import '../exceptions/game_repository_exception.dart';

class ScoreRepositoryImpl implements ScoreRepository {
  static const String _scoresStorageKey = 'scores';

  // Get scores from shared preferences
  Future<Map<String, int>> _getStoredScores() async {
    final String? scoresJson = await SharedPreferencesService.getString(
      _scoresStorageKey,
    );
    if (scoresJson == null) return {};
    final decoded = jsonDecode(scoresJson) as Map<String, dynamic>;
    return Map<String, int>.from(decoded);
  }

  @override
  Future<void> incrementPlayerScore(String playerId) async {
    try {
      final scores = await _getStoredScores();
      scores[playerId] = (scores[playerId] ?? 0) + 1;
      final jsonString = jsonEncode(scores);
      await SharedPreferencesService.setString(_scoresStorageKey, jsonString);
    } catch (e) {
      throw RepositoryOperationException('Failed to increment score: $e');
    }
  }

  @override
  Future<void> resetScores() async {
    try {
      return SharedPreferencesService.remove(_scoresStorageKey);
    } catch (e) {
      throw RepositoryOperationException('Failed to reset scores: $e');
    }
  }

  @override
  Future<Map<String, int>> getScores() async {
    try {
      return _getStoredScores();
    } catch (e) {
      throw RepositoryOperationException('Failed to get all scores: $e');
    }
  }
}
