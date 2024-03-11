import 'dart:ui';

class Mood {
  final String id;
  final String type;
  final double value;
  final DateTime updatedAt;

  const Mood({
    required this.id,
    required this.type,
    required this.value,
    required this.updatedAt,
  });

  // factory Mood.fromJson(Map<String, dynamic> json) {
  //   return Mood(id: json, type: type, value: value, updatedAt: updatedAt);
  // }
}
