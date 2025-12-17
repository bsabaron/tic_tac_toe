import 'dart:ui';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/src/domain/entities/board.dart';
import 'package:game/src/domain/entities/cell.dart';
import 'package:game/src/domain/entities/player.dart';
import 'package:game/src/domain/extensions/board_extension.dart';

void main() {
  group('BoardExtension', () {
    late Player player;

    setUp(() {
      player = Player(id: '1', symbol: 'X', color: const Color(0xFF000000));
    });

    test('isFull should return true when all cells are filled', () {
      final cells = List.generate(9, (index) => Cell.filled(player));
      final board = Board(cells: cells);

      expect(board.isFull, true);
    });

    test('isFull should return false when at least one cell is empty', () {
      final cells = List.generate(8, (index) => Cell.filled(player));
      cells.add(Cell.empty());
      final board = Board(cells: cells);

      expect(board.isFull, false);
    });

    test('isFull should return false for an empty board', () {
      final board = Board.initial();

      expect(board.isFull, false);
    });
  });
}
