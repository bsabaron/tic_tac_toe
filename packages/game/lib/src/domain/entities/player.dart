import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:ui';

part 'player.freezed.dart';

@freezed
abstract class Player with _$Player {
  const factory Player({
    required String id,
    required String symbol,
    required Color color,
  }) = _Player;
}
