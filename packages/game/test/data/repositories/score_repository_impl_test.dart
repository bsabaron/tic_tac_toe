import 'package:flutter_test/flutter_test.dart';
import 'package:game/src/data/repositories/score_repository_impl.dart';
import 'package:game/src/data/exceptions/game_repository_exception.dart';
import 'package:core/core.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'score_repository_impl_test.mocks.dart';

@GenerateMocks([SharedPreferencesService])
void main() {
  group('ScoreRepositoryImpl', () {
    late ScoreRepositoryImpl repository;
    late MockSharedPreferencesService mockService;

    setUp(() {
      mockService = MockSharedPreferencesService();
      repository = ScoreRepositoryImpl(sharedPreferencesService: mockService);
    });

    test('should return empty map when no scores are stored', () async {
      when(mockService.getString('scores')).thenAnswer((_) async => null);

      final scores = await repository.getScores();

      expect(scores, {});
      verify(mockService.getString('scores')).called(1);
    });

    test('should save and retrieve scores', () async {
      const playerId1 = '1';
      const playerId2 = '2';
      const scoresJson = '{"$playerId1":2,"$playerId2":1}';

      when(mockService.getString('scores')).thenAnswer((_) async => scoresJson);
      when(
        mockService.setString('scores', scoresJson),
      ).thenAnswer((_) async => {});

      await repository.saveScores({playerId1: 2, playerId2: 1});
      final scores = await repository.getScores();

      expect(scores[playerId1], 2);
      expect(scores[playerId2], 1);
      verify(mockService.setString('scores', scoresJson)).called(1);
      verify(mockService.getString('scores')).called(1);
    });

    test('should reset all scores', () async {
      const playerId1 = '1';
      const playerId2 = '2';
      const scoresJson = '{"$playerId1":1,"$playerId2":1}';

      when(mockService.getString('scores')).thenAnswer((_) async => null);
      when(
        mockService.setString('scores', scoresJson),
      ).thenAnswer((_) async => {});
      when(mockService.remove('scores')).thenAnswer((_) async => {});

      await repository.saveScores({playerId1: 1, playerId2: 1});

      await repository.resetScores();

      final scores = await repository.getScores();
      expect(scores, {});
      verify(mockService.remove('scores')).called(1);
      verify(mockService.getString('scores')).called(1);
    });

    test('should handle corrupted JSON data gracefully', () async {
      when(
        mockService.getString('scores'),
      ).thenAnswer((_) async => 'invalid json');

      final repository2 = ScoreRepositoryImpl(
        sharedPreferencesService: mockService,
      );

      expect(
        () => repository2.getScores(),
        throwsA(isA<RepositoryOperationException>()),
      );
      verify(mockService.getString('scores')).called(1);
    });
  });
}
