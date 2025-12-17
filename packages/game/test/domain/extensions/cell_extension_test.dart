import 'dart:ui';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/src/domain/entities/cell.dart';
import 'package:game/src/domain/entities/player.dart';
import 'package:game/src/domain/extensions/cell_extension.dart';

void main() {
  group('CellExtension', () {
    late Player player;

    setUp(() {
      player = Player(id: '1', symbol: 'X', color: const Color(0xFF000000));
    });

    test('isEmpty should return true for empty cell', () {
      final cell = Cell.empty();

      expect(cell.isEmpty, true);
      expect(cell.isFilled, false);
    });

    test('isEmpty should return false for filled cell', () {
      final cell = Cell.filled(player);

      expect(cell.isFilled, true);
      expect(cell.isEmpty, false);
    });
  });
}
