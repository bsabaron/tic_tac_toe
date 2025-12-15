import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/game_data.dart';
import '../../domain/game_domain.dart';

part 'repository_provider.g.dart';

@Riverpod(keepAlive: true)
ScoreRepository scoreRepository(Ref ref) {
  return ScoreRepositoryImpl();
}
