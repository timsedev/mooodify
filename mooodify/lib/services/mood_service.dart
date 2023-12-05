import 'dart:developer';

import 'package:mooodify/core/models/mood.dart';

class MoodService {
  Map<DateTime, Mood?> moodByDay = {};
  List<Mood> allMoods = [
    Mood(type: 'Terrible', value: -2),
    Mood(type: 'Bad', value: -1),
    Mood(type: 'Neutral', value: 0),
    Mood(type: 'Happy', value: 1),
    Mood(type: 'Excellent', value: 2),
  ];

  void addMood(DateTime datetime, Mood mood) {
    final date = DateTime(datetime.year, datetime.month, datetime.day);
    moodByDay[date] = mood;
  }

  Mood getMood(DateTime datetime) {
    final date = DateTime(datetime.year, datetime.month, datetime.day);
    return moodByDay[date] ?? getNeutral();
  }

  Mood getNeutral() => allMoods[2];

  /// For debugging purposes
  void printMoods() {
    moodByDay.forEach((key, value) {
      log('$key: $value');
    });
  }
}
