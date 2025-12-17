import '../entities/board.dart';
import 'cell_extension.dart';

extension BoardExtension on Board {
  bool get isFull => cells.every((cell) => cell.isFilled);
}
