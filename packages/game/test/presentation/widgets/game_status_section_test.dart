import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game/game.dart';

import '../controllers/game_controller_test_mock.dart';

void main() {
  group('GameStatusSection', () {
    late MockGameController mockGameController;
    late ProviderContainer container;
    late GameController gameController;

    setUp(() {
      mockGameController = MockGameController();
      container = ProviderContainer(
        overrides: [
          gameControllerProvider.overrideWith(() => mockGameController),
        ],
      );
      gameController = container.read(gameControllerProvider.notifier);
    });

    tearDown(() {
      container.dispose();
    });

    testWidgets('should display playing status', (tester) async {
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(home: Scaffold(body: GameStatusSection())),
        ),
      );
      await tester.pumpAndSettle();

      final expectedText =
          'C\'est à ${gameController.state.currentPlayer.symbol} de jouer !';
      expect(find.text(expectedText), findsOneWidget);
    });

    testWidgets('should display won status', (tester) async {
      gameController.state = gameController.state.copyWith(
        status: GameStatus.won,
      );

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(home: Scaffold(body: GameStatusSection())),
        ),
      );
      await tester.pumpAndSettle();

      final expectedText =
          '${gameController.state.currentPlayer.symbol} a gagné !';
      expect(find.text(expectedText), findsOneWidget);
    });

    testWidgets('should display draw status', (tester) async {
      gameController.state = gameController.state.copyWith(
        status: GameStatus.draw,
      );

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(home: Scaffold(body: GameStatusSection())),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Match nul !'), findsOneWidget);
    });
  });
}
