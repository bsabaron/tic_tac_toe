import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game/src/domain/game_domain.dart';
import 'package:game/src/presentation/controllers/game_controller.dart';
import 'package:game/src/presentation/widgets/cell_widget.dart';

import '../controllers/game_controller_test_mock.dart';

void main() {
  group('CellWidget', () {
    late ProviderContainer container;
    late MockGameController mockGameController;
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

    testWidgets('should display empty cell initially', (tester) async {
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(home: Scaffold(body: CellWidget(index: 0))),
        ),
      );

      final textFinder = find.text('');
      expect(textFinder, findsOneWidget);
    });

    testWidgets('should display player symbol when cell is filled', (
      tester,
    ) async {
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(home: Scaffold(body: CellWidget(index: 0))),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text(''), findsOneWidget);

      // Fill the first cell with player 1
      final cells = List.generate(9, (index) => Cell.empty());
      cells[0] = Cell.filled(gameController.player1);
      final board = Board(cells: cells);
      gameController.state = gameController.state.copyWith(board: board);

      await tester.pumpAndSettle();

      expect(find.text(gameController.player1.symbol), findsOneWidget);
    });
  });
}
