import 'dart:developer';

import 'package:mooodify/core/models/mood.dart';

class MoodService {
  Map<DateTime, Mood?> moodByDay = {};
  List<Mood> allMoods = Mood.allMoods();

  void addMood(DateTime datetime, Mood mood) {
    final date = DateTime(datetime.year, datetime.month, datetime.day);
    moodByDay[date] = mood;
  }

  Mood? getMood(DateTime datetime) {
    final date = DateTime(datetime.year, datetime.month, datetime.day);
    return moodByDay[date];
  }

  /// For debugging purposes
  void printMoods() {
    moodByDay.forEach((key, value) {
      log('$key: $value');
    });
  }
}
