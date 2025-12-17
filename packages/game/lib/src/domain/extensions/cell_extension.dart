import '../entities/cell.dart';

extension CellExtension on Cell {
  bool get isEmpty => player == null;

  bool get isFilled => player != null;
}
