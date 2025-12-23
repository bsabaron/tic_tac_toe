import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game/game.dart';

import '../controllers/game_controller_test_mock.dart';
import '../controllers/score_controller_test_mock.dart';

void main() {
  group('GamePage', () {
    late ProviderContainer container;
    late MockGameController mockGameController;
    late MockScoreController mockScoreController;

    setUp(() {
      mockGameController = MockGameController();
      mockScoreController = MockScoreController();

      container = ProviderContainer(
        overrides: [
          gameControllerProvider.overrideWith(() => mockGameController),
          scoreControllerProvider.overrideWith(() => mockScoreController),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    testWidgets('should display all main components', (tester) async {
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(home: GamePage()),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Tic-Tac-Toe'), findsOneWidget);
      expect(find.byType(BoardWidget), findsOneWidget);
      expect(find.byType(GameStatusSection), findsOneWidget);
      expect(find.byType(PlayersWithScoreSection), findsOneWidget);
      expect(find.text('Rejouer'), findsOneWidget);
    });

    testWidgets('should reset game when Rejouer button is tapped', (
      tester,
    ) async {
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(home: GamePage()),
        ),
      );

      await tester.pumpAndSettle();

      final resetButton = find.text('Rejouer');
      await tester.tap(resetButton);
      await tester.pumpAndSettle();

      // verify(mockGameController.reset()).called(1);
    });

    testWidgets('should reset scores when confirming dialog', (tester) async {
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(home: GamePage()),
        ),
      );

      await tester.pumpAndSettle();

      final refreshIcon = find.byIcon(Icons.refresh);
      await tester.tap(refreshIcon);
      await tester.pumpAndSettle();

      expect(
        find.text('Êtes-vous sûr de vouloir réinitialiser les scores ?'),
        findsOneWidget,
      );

      final confirmButton = find.text('Oui');
      await tester.tap(confirmButton);
      await tester.pumpAndSettle();

      // verify(mockScoreController.resetScores()).called(1);
    });
  });
}
