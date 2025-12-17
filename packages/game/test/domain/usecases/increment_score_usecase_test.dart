import 'package:flutter_test/flutter_test.dart';
import 'package:game/src/domain/repositories/score_repository.dart';
import 'package:game/src/domain/usecases/increment_score_usecase.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'increment_score_usecase_test.mocks.dart';

@GenerateMocks([ScoreRepository])
void main() {
  final player1 = 'id1';
  final player2 = 'id2';

  group('IncrementScoreUseCase', () {
    late IncrementScoreUseCase useCase;
    late MockScoreRepository mockRepository;

    setUp(() {
      mockRepository = MockScoreRepository();
      useCase = IncrementScoreUseCase(mockRepository);
    });

    test('should increment player score from 0 to 1', () async {
      when(mockRepository.getScores()).thenAnswer((_) async => {});

      await useCase.incrementPlayerScore(player1);

      verify(mockRepository.getScores()).called(1);
      verify(mockRepository.saveScores({player1: 1})).called(1);
    });

    test('should increment existing player score', () async {
      when(mockRepository.getScores()).thenAnswer((_) async => {player1: 2});

      await useCase.incrementPlayerScore(player1);

      verify(mockRepository.saveScores({player1: 3})).called(1);
    });

    test('should handle different player IDs independently', () async {
      when(
        mockRepository.getScores(),
      ).thenAnswer((_) async => {player1: 1, player2: 5});

      await useCase.incrementPlayerScore(player1);

      verify(mockRepository.saveScores({player1: 2, player2: 5})).called(1);
    });

    test('should propagate exception from saveScores', () async {
      when(mockRepository.getScores()).thenAnswer((_) async => {});
      when(mockRepository.saveScores(any)).thenThrow(Exception('Save error'));

      expect(() => useCase.incrementPlayerScore(player1), throwsException);
    });
  });
}
