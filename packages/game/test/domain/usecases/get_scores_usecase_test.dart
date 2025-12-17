import 'package:flutter_test/flutter_test.dart';
import 'package:game/src/domain/repositories/score_repository.dart';
import 'package:game/src/domain/usecases/get_scores_usecase.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'get_scores_usecase_test.mocks.dart';

@GenerateMocks([ScoreRepository])
void main() {
  group('GetScoresUseCase', () {
    late GetScoresUseCase useCase;
    late MockScoreRepository mockRepository;

    setUp(() {
      mockRepository = MockScoreRepository();
      useCase = GetScoresUseCase(mockRepository);
    });

    test('should return scores from repository', () async {
      final expectedScores = {'1': 5, '2': 3};
      when(mockRepository.getScores()).thenAnswer((_) async => expectedScores);

      final result = await useCase.getScores();

      expect(result, expectedScores);
      verify(mockRepository.getScores()).called(1);
    });

    test('should propagate exception from repository', () async {
      when(mockRepository.getScores()).thenThrow(Exception('Database error'));

      expect(() => useCase.getScores(), throwsException);
      verify(mockRepository.getScores()).called(1);
    });
  });
}
