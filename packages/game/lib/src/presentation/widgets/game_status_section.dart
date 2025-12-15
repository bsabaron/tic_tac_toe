import 'package:flutter/material.dart';
import 'package:game/src/presentation/models/game_state.dart';

class GameStatusSection extends StatelessWidget {
  final GameState gameState;

  const GameStatusSection({super.key, required this.gameState});

  @override
  Widget build(BuildContext context) {
    String statusText;
    Color statusColor;

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
