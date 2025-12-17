import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game/src/domain/repositories/score_repository.dart';
import 'package:game/src/presentation/controllers/score_controller.dart';
import 'package:game/src/presentation/providers/repository_provider.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'score_controller_test.mocks.dart';

@GenerateMocks([ScoreRepository])
void main() {
  group('ScoreController', () {
    late ProviderContainer container;
    late MockScoreRepository mockRepository;

    setUp(() {
      mockRepository = MockScoreRepository();
      container = ProviderContainer(
        overrides: [scoreRepositoryProvider.overrideWithValue(mockRepository)],
      );
    });

    tearDown(() {
      container.dispose();
    });

    test('should load scores on initialization', () async {
      const expectedScores = {'1': 5, '2': 3};
      when(mockRepository.getScores()).thenAnswer((_) async => expectedScores);

      final scores = await container.read(scoreControllerProvider.future);

      expect(scores, expectedScores);
      verify(mockRepository.getScores()).called(1);
    });

    test('should reset all scores to empty map', () async {
      const initialScores = {'1': 5, '2': 3};
      when(mockRepository.getScores()).thenAnswer((_) async => initialScores);

      await container.read(scoreControllerProvider.future);

      final controller = container.read(scoreControllerProvider.notifier);
      await controller.resetScores();

      final scores = await container.read(scoreControllerProvider.future);
      expect(scores, {});
      verify(mockRepository.resetScores()).called(1);
    });

    test('should reset scores when already empty', () async {
      when(mockRepository.getScores()).thenAnswer((_) async => {});
      when(mockRepository.resetScores()).thenAnswer((_) async => {});

      await container.read(scoreControllerProvider.future);

      final controller = container.read(scoreControllerProvider.notifier);
      await controller.resetScores();

      final scores = await container.read(scoreControllerProvider.future);
      expect(scores, {});
      verify(mockRepository.resetScores()).called(1);
    });

    test('should propagate exception when reset fails', () async {
      when(mockRepository.getScores()).thenAnswer((_) async => {});
      when(mockRepository.resetScores()).thenThrow(Exception('Reset error'));

      await container.read(scoreControllerProvider.future);

      final controller = container.read(scoreControllerProvider.notifier);

      expectLater(controller.resetScores(), throwsException);
    });
  });
}
