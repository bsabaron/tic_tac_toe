import 'package:flutter_test/flutter_test.dart';
import 'package:game/src/domain/repositories/score_repository.dart';
import 'package:game/src/domain/usecases/increment_score_usecase.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'increment_score_usecase_test.mocks.dart';

@GenerateMocks([ScoreRepository])
void main() {
  const player1 = 'id1';
  const player2 = 'id2';

  group('IncrementScoreUseCase', () {
    late IncrementScoreUseCase useCase;
    late MockScoreRepository mockRepository;

    setUp(() {
      mockRepository = MockScoreRepository();
      useCase = IncrementScoreUseCase(mockRepository);
    });

    test('should increment player score from 0 to 1', () async {
      final currentScores = <String, int>{};
      final expectedScores = {player1: 1};
      when(mockRepository.getScores()).thenAnswer((_) async => currentScores);

      final scores = await useCase.incrementPlayerScore(player1);

      verify(mockRepository.saveScores(expectedScores)).called(1);
      expect(scores, expectedScores);
    });

    test('should increment existing player score', () async {
      final currentScores = {player1: 2};
      final expectedScores = {player1: 3};
      when(mockRepository.getScores()).thenAnswer((_) async => currentScores);

      final scores = await useCase.incrementPlayerScore(player1);

      verify(mockRepository.saveScores(expectedScores)).called(1);
      expect(scores, expectedScores);
    });

    test('should handle different player IDs independently', () async {
      final currentScores = {player1: 1, player2: 5};
      final expectedScores = {player1: 2, player2: 5};
      when(mockRepository.getScores()).thenAnswer((_) async => currentScores);

      final scores = await useCase.incrementPlayerScore(player1);

      verify(mockRepository.saveScores(expectedScores)).called(1);
      expect(scores, expectedScores);
    });

    test('should propagate exception from saveScores', () async {
      when(mockRepository.getScores()).thenAnswer((_) async => {});
      when(mockRepository.saveScores(any)).thenThrow(Exception('Save error'));

      expect(() => useCase.incrementPlayerScore(player1), throwsException);
    });
  });
}
