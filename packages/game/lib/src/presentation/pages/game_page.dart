import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game/src/presentation/game_presentation.dart';

class GamePage extends ConsumerWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic-Tac-Toe'),
        actions: [
          IconButton(
            onPressed: () => _showResetScoresDialog(context, ref),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 32,
              children: [
                const PlayersWithScoreSection(),
                const GameStatusSection(),
                const BoardWidget(),
                FilledButton(
                  onPressed: () {
                    ref.read(gameControllerProvider.notifier).reset();
                  },
                  child: const Text('Rejouer'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showResetScoresDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder:
          (context) => ConfirmationDialog(
            title: 'Êtes-vous sûr de vouloir réinitialiser les scores ?',
            onConfirm: () {
              ref.read(scoreControllerProvider.notifier).resetScores();
            },
          ),
    );
  }
}
