import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game/src/presentation/game_presentation.dart';

class GameStatusSection extends ConsumerWidget {
  const GameStatusSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String statusText;
    Color statusColor;

    final gameState = ref.watch(
      gameControllerProvider.select((state) => state),
    );

    switch (gameState.status) {
      case GameStatus.playing:
        statusText = 'C\'est à ${gameState.currentPlayer.symbol} de jouer !';
        statusColor = Theme.of(context).colorScheme.primary;
        break;
      case GameStatus.won:
        statusText = '${gameState.currentPlayer.symbol} a gagné !';
        statusColor = Colors.green;
        break;
      case GameStatus.draw:
        statusText = "Match nul !";
        statusColor = Colors.orange;
        break;
    }

    return Text(
      statusText,
      style: TextStyle(fontSize: 20, color: statusColor),
      textAlign: TextAlign.center,
    );
  }
}
