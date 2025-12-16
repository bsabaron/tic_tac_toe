import 'package:game/src/domain/game_domain.dart';
import 'package:game/src/presentation/providers/repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'score_controller.g.dart';

@riverpod
class ScoreController extends _$ScoreController {
  late final IncrementScoreUseCase _incrementScoreUseCase =
      IncrementScoreUseCase(ref.read(scoreRepositoryProvider));
  late final GetScoresUseCase _getScoresUseCase = GetScoresUseCase(
    ref.read(scoreRepositoryProvider),
  );

  @override
  Future<Map<String, int>> build() async {
    return await _getScoresUseCase.getScores();
  }

  Future<void> incrementPlayerScore(String playerId) async {
    await _incrementScoreUseCase.incrementPlayerScore(playerId);
    final updatedScores = await _getScoresUseCase.getScores();
    state = AsyncValue.data(updatedScores);
  }

  Future<void> resetScores() async {
    final scoreRepository = ref.read(scoreRepositoryProvider);
    await scoreRepository.resetScores();
    state = const AsyncValue.data({});
  }
}
