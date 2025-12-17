import 'package:flutter_test/flutter_test.dart';
import 'package:game/src/domain/repositories/score_repository.dart';
import 'package:game/src/domain/usecases/increment_score_usecase.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'increment_score_usecase_test.mocks.dart';

@GenerateMocks([ScoreRepository])
void main() {
  group('IncrementScoreUseCase', () {
    late IncrementScoreUseCase useCase;
    late MockScoreRepository mockRepository;

    setUp(() {
      mockRepository = MockScoreRepository();
      useCase = IncrementScoreUseCase(mockRepository);
    });

    test('should increment player score via repository', () async {
      const playerId = '1';
      when(
        mockRepository.incrementPlayerScore(playerId),
      ).thenAnswer((_) async => {});

      await useCase.incrementPlayerScore(playerId);

      verify(mockRepository.incrementPlayerScore(playerId)).called(1);
    });

    test('should handle different player IDs', () async {
      const playerId1 = '1';
      const playerId2 = '2';

      when(
        mockRepository.incrementPlayerScore(any),
      ).thenAnswer((_) async => {});

      await useCase.incrementPlayerScore(playerId1);
      await useCase.incrementPlayerScore(playerId2);

      verify(mockRepository.incrementPlayerScore(playerId1)).called(1);
      verify(mockRepository.incrementPlayerScore(playerId2)).called(1);
    });

    test('should propagate exception from repository', () async {
      const playerId = '1';
      when(
        mockRepository.incrementPlayerScore(playerId),
      ).thenThrow(Exception('Database error'));

      expect(() => useCase.incrementPlayerScore(playerId), throwsException);
      verify(mockRepository.incrementPlayerScore(playerId)).called(1);
    });
  });
}
