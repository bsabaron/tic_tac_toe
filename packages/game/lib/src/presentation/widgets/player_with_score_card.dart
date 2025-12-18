import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:game/src/domain/game_domain.dart';

class PlayerWithScoreCard extends StatelessWidget {
  final Player player;
  final bool isPlaying;
  final int score;

  const PlayerWithScoreCard({
    super.key,
    required this.player,
    required this.isPlaying,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 10,
          children: [
            Column(
              spacing: 2,
              children: [
                Text(
                  player.symbol,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    height: 1,
                    color: player.color,
                  ),
                ),
                isPlaying
                    ? Container(
                      width: 20,
                      height: 3,
                      decoration: BoxDecoration(
                        color: player.color,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ).animate().scale(
                      duration: 500.ms,
                      curve: Curves.linearToEaseOut,
                    )
                    : SizedBox(height: 3),
              ],
            ),
            Row(
              spacing: 4,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Score:'),
                Text(
                  score.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
