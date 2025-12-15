import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game/game.dart';

class CellWidget extends ConsumerWidget {
  final int index;

  const CellWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameControllerProvider);
    final cell = gameState.board.cells[index];

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
          child: Text(
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
