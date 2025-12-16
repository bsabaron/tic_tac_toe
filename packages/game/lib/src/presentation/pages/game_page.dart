import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game/src/presentation/controllers/score_controller.dart';
import 'package:game/src/presentation/game_presentation.dart';

class GamePage extends ConsumerWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPlayer = ref.watch(
      gameControllerProvider.select((state) => state.currentPlayer),
    );
    final scores = ref.watch(scoreControllerProvider);
    final player1 = ref.read(gameControllerProvider.notifier).player1;
    final player2 = ref.read(gameControllerProvider.notifier).player2;

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
                scores
                        .whenData(
                          (scores) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            spacing: 16,
                            children: [
                              Expanded(
                                child: PlayerWithScoreCard(
                                  player: player1,
                                  isPlaying: player1.id == currentPlayer.id,
                                  score: scores[player1.id] ?? 0,
                                ),
                              ).animate().slideX(
                                begin: -1.0,
                                duration: 500.ms,
                                curve: Curves.linearToEaseOut,
                              ),
                              Text('vs', style: TextStyle(fontSize: 20)),
                              Expanded(
                                child: PlayerWithScoreCard(
                                  player: player2,
                                  isPlaying: player2.id == currentPlayer.id,
                                  score: scores[player2.id] ?? 0,
                                ),
                              ).animate().slideX(
                                begin: 1.0,
                                duration: 500.ms,
                                curve: Curves.linearToEaseOut,
                              ),
                            ],
                          ),
                        )
                        .value ??
                    const SizedBox.shrink(),
                GameStatusSection().animate().fadeIn(
                  delay: 500.ms,
                  duration: 300.ms,
                  curve: Curves.linearToEaseOut,
                ),
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
