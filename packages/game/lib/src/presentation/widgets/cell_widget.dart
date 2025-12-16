import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game/game.dart';

class CellWidget extends ConsumerStatefulWidget {
  final int index;

  const CellWidget({super.key, required this.index});

  @override
  ConsumerState<CellWidget> createState() => _CellWidgetState();
}

class _CellWidgetState extends ConsumerState<CellWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    // Animation scale in and out
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 1.0,
          end: 1.2,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 0.5,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 1.2,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 0.5,
      ),
    ]).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Cell cell = ref.watch(
      gameControllerProvider.select((state) => state.board.cells[widget.index]),
    );
    final bool isWinnerCell = ref.watch(
      gameControllerProvider.select(
        (state) => state.winnerCombination?.contains(widget.index) ?? false,
      ),
    );

    if (isWinnerCell) {
      _animationController.repeat(count: 3);
    }

    return GestureDetector(
      onTap: () {
        ref.read(gameControllerProvider.notifier).makeMove(widget.index);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: isWinnerCell ? 2 : 1,
            color:
                isWinnerCell
                    ? Colors.green
                    : Theme.of(
                      context,
                    ).colorScheme.outline.withValues(alpha: 0.5),
          ),
        ),
        child: Center(
          child: AnimatedBuilder(
            animation: _scaleAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: child,
              );
            },
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
      ),
    );
  }
}
