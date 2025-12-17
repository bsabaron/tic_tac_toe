import 'dart:convert';

import 'package:core/core.dart';

import '../../domain/repositories/score_repository.dart';
import '../exceptions/game_repository_exception.dart';

class ScoreRepositoryImpl implements ScoreRepository {
  static const String _scoresStorageKey = 'scores';

  @override
  Future<Map<String, int>> getScores() async {
    try {
      final String? scoresJson = await SharedPreferencesService.getString(
        _scoresStorageKey,
      );
      if (scoresJson == null) return {};
      final decoded = jsonDecode(scoresJson) as Map<String, dynamic>;
      return Map<String, int>.from(decoded);
    } catch (e) {
      throw RepositoryOperationException('Failed to get all scores: $e');
    }
  }

  @override
  Future<Map<String, int>> saveScores(Map<String, int> scores) async {
    final jsonString = jsonEncode(scores);
    await SharedPreferencesService.setString(_scoresStorageKey, jsonString);
    return scores;
  }

  @override
  Future<void> resetScores() async {
    try {
      return SharedPreferencesService.remove(_scoresStorageKey);
    } catch (e) {
      throw RepositoryOperationException('Failed to reset scores: $e');
    }
  }
}
