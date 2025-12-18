import 'package:flutter/material.dart';
import 'package:game/game.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MockGameController extends Notifier<GameState>
    with Mock
    implements GameController {
  final Player _player1 = Player(id: '1', symbol: 'X', color: Colors.blue);
  final Player _player2 = Player(id: '2', symbol: 'O', color: Colors.red);

  @override
  Player get player1 => _player1;

  @override
  Player get player2 => _player2;

  @override
  GameState build() {
    return GameState.initial(startingPlayer: _player1);
  }

  @override
  Future<void> makeMove(int index) async {}

  @override
  Future<void> reset() async {}
}
