import 'package:game/src/domain/game_domain.dart';
import 'package:game/src/presentation/providers/repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'score_controller.g.dart';

@riverpod
class ScoreController extends _$ScoreController {
  late final ScoreRepository _scoreRepository = ref.read(
    scoreRepositoryProvider,
  );
  late final IncrementScoreUseCase _incrementScoreUseCase =
      IncrementScoreUseCase(_scoreRepository);

  @override
  Future<Map<String, int>> build() async {
    return await _scoreRepository.getScores();
  }

  Future<void> incrementPlayerScore(String playerId) async {
    final updatedScores = await _incrementScoreUseCase.incrementPlayerScore(
      playerId,
    );
    state = AsyncValue.data(updatedScores);
  }

  Future<void> resetScores() async {
    await _scoreRepository.resetScores();
    state = const AsyncValue.data({});
  }
}
