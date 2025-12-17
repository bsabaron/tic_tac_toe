import 'cell.dart';

class Board {
  final List<Cell> cells;

  Board() : cells = List.filled(9, Cell.empty());

  const Board.fromCells(this.cells) : assert(cells.length == 9);
}
