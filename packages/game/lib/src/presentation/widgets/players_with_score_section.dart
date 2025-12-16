import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game/src/presentation/game_presentation.dart';

class PlayersWithScoreSection extends ConsumerWidget {
  const PlayersWithScoreSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player1 = ref.read(gameControllerProvider.notifier).player1;
    final player2 = ref.read(gameControllerProvider.notifier).player2;
    final currentPlayer = ref.watch(
      gameControllerProvider.select((state) => state.currentPlayer),
    );
    final scores = ref.watch(scoreControllerProvider);

    return scores
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
        const SizedBox.shrink();
  }
}
