import 'package:flutter/material.dart';
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
                Container(
                  width: 20,
                  height: 3,
                  decoration: BoxDecoration(
                    color: isPlaying ? player.color : Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ],
            ),
            RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyMedium,
                children: [
                  TextSpan(text: 'Score: '),
                  TextSpan(
                    text: score.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
