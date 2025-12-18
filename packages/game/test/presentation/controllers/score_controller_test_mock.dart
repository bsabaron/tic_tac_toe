import 'package:game/game.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MockScoreController extends AsyncNotifier<Map<String, int>>
    with Mock
    implements ScoreController {
  @override
  Future<Map<String, int>> build() async => {};

  @override
  Future<void> incrementPlayerScore(String playerId) async {}
}
