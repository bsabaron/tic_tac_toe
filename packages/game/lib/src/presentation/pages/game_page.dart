import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game/src/presentation/game_presentation.dart';

class GamePage extends ConsumerWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Tic-Tac-Toe')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 32,
              children: [
                GameStatusSection(gameState: gameState),
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
}
