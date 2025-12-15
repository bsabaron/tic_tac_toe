import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:game/game.dart';

class CellWidget extends ConsumerWidget {
  final int index;

  const CellWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameControllerProvider);
    final cell = gameState.board.cells[index];
    final isWinnerCell = gameState.winnerCombination?.contains(index) ?? false;

    return GestureDetector(
      onTap: () {
        ref.read(gameControllerProvider.notifier).makeMove(index);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.5),
          ),
        ),
        child: Center(
          child:
              isWinnerCell
                  ? Text(
                        cell.player?.symbol ?? '',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: cell.player?.color,
                        ),
                      )
                      .animate(
                        onPlay:
                            (controller) =>
                                isWinnerCell
                                    ? controller.repeat(count: 3)
                                    : null,
                      )
                      .scale(
                        begin: const Offset(1.0, 1.0),
                        end: const Offset(1.2, 1.2),
                        duration: 500.ms,
                        curve: Curves.easeInOut,
                      )
                      .then()
                      .scale(
                        begin: const Offset(1.2, 1.2),
                        end: const Offset(1.0, 1.0),
                        duration: 500.ms,
                        curve: Curves.easeInOut,
                      )
                  : Text(
                    cell.player?.symbol ?? '',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: cell.player?.color,
                    ),
                  ),
        ),
      ),
    );
  }
}
