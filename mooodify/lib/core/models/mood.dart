import 'dart:ui';

class Mood {
  final String id;
  final String type;
  final double value;
  final DateTime updatedAt;

  Mood({
    required this.id,
    required this.type,
    required this.value,
    required this.updatedAt,
  });
}
