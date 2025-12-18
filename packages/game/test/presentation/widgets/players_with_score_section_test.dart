import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game/game.dart';
import 'package:game/src/presentation/widgets/players_with_score_section.dart';

import '../controllers/game_controller_test_mock.dart';
import '../controllers/score_controller_test_mock.dart';

void main() {
  group('PlayersWithScoreSection', () {
    late ProviderContainer container;
    late MockGameController mockGameController;
    late MockScoreController mockScoreController;
    late GameController gameController;
    late ScoreController scoreController;
    setUp(() {
      mockGameController = MockGameController();
      mockScoreController = MockScoreController();

      container = ProviderContainer(
        overrides: [
          gameControllerProvider.overrideWith(() => mockGameController),
          scoreControllerProvider.overrideWith(() => mockScoreController),
        ],
      );
      gameController = container.read(gameControllerProvider.notifier);
      scoreController = container.read(scoreControllerProvider.notifier);
    });

    tearDown(() {
      container.dispose();
    });

    testWidgets('should display both player cards with scores', (tester) async {
      const scores = {'1': 10, '2': 7};
      scoreController.state = AsyncValue.data(scores);

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(home: Scaffold(body: PlayersWithScoreSection())),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text(gameController.player1.symbol), findsOneWidget);
      expect(find.text(gameController.player2.symbol), findsOneWidget);
      expect(find.text('vs'), findsOneWidget);
      expect(find.text('Score:'), findsExactly(2));
      expect(find.text('10'), findsOneWidget);
      expect(find.text('7'), findsOneWidget);
    });

    testWidgets('should display score 0 when player has no score', (
      tester,
    ) async {
      const scores = {'1': 5};
      scoreController.state = AsyncValue.data(scores);

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(home: Scaffold(body: PlayersWithScoreSection())),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Score:'), findsExactly(2));
      expect(find.text('5'), findsOneWidget);
      expect(find.text('0'), findsOneWidget);
    });

    testWidgets('should verify players isPlaying status', (tester) async {
      const scores = {'1': 3, '2': 2};
      scoreController.state = AsyncValue.data(scores);

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(home: Scaffold(body: PlayersWithScoreSection())),
        ),
      );
      await tester.pumpAndSettle();

      final player1Card = find.byType(PlayerWithScoreCard).first;
      final player1CardWidget = tester.widget<PlayerWithScoreCard>(player1Card);
      expect(player1CardWidget.isPlaying, true);
      expect(player1CardWidget.player.id, gameController.player1.id);

      final player2Card = find.byType(PlayerWithScoreCard).last;
      final player2CardWidget = tester.widget<PlayerWithScoreCard>(player2Card);
      expect(player2CardWidget.isPlaying, false);
      expect(player2CardWidget.player.id, gameController.player2.id);
    });

    testWidgets('should update when current player changes', (tester) async {
      const scores = {'1': 3, '2': 2};
      scoreController.state = AsyncValue.data(scores);

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(home: Scaffold(body: PlayersWithScoreSection())),
        ),
      );
      await tester.pumpAndSettle();

      final player1Card = find.byType(PlayerWithScoreCard).first;
      final player1CardWidget = tester.widget<PlayerWithScoreCard>(player1Card);
      expect(player1CardWidget.isPlaying, true);

      // Change current player to player 2
      gameController.state = gameController.state.copyWith(
        currentPlayer: gameController.player2,
      );

      // Wait for the animation to complete
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 600));

      final updatedPlayer1Card = find.byType(PlayerWithScoreCard).first;
      final updatedPlayer1CardWidget = tester.widget<PlayerWithScoreCard>(
        updatedPlayer1Card,
      );
      expect(updatedPlayer1CardWidget.isPlaying, false);

      final updatedPlayer2Card = find.byType(PlayerWithScoreCard).last;
      final updatedPlayer2CardWidget = tester.widget<PlayerWithScoreCard>(
        updatedPlayer2Card,
      );
      expect(updatedPlayer2CardWidget.isPlaying, true);
    });

    testWidgets('should update when player score changes', (tester) async {
      const initialScores = {'1': 3, '2': 2};
      scoreController.state = AsyncValue.data(initialScores);

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(home: Scaffold(body: PlayersWithScoreSection())),
        ),
      );
      await tester.pumpAndSettle();

      // Verify initial scores
      expect(find.text('3'), findsOneWidget);
      expect(find.text('2'), findsOneWidget);

      // Update player 1 score
      const updatedScores = {'1': 5, '2': 2};
      scoreController.state = AsyncValue.data(updatedScores);

      // Wait for the animation to complete
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 600));

      // Verify updated scores
      expect(find.text('5'), findsOneWidget);
      expect(find.text('2'), findsOneWidget);
      expect(find.text('3'), findsNothing);

      final player1Card = find.byType(PlayerWithScoreCard).first;
      final player1CardWidget = tester.widget<PlayerWithScoreCard>(player1Card);
      expect(player1CardWidget.score, 5);
      expect(player1CardWidget.player.id, gameController.player1.id);

      final player2Card = find.byType(PlayerWithScoreCard).last;
      final player2CardWidget = tester.widget<PlayerWithScoreCard>(player2Card);
      expect(player2CardWidget.score, 2);
      expect(player2CardWidget.player.id, gameController.player2.id);
    });
  });
}
