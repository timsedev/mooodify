import 'dart:developer';

import 'package:mooodify/core/models/mood.dart';
import 'package:mooodify/ui/common/contants.dart';

class MoodService {
  Map<DateTime, Mood?> moodByDay = {};
  List<Mood> allMoods = [
    Mood(type: 'Terrible', value: -2, colorGradient: terribleGradient),
    Mood(type: 'Bad', value: -1, colorGradient: badGradient),
    Mood(type: 'Neutral', value: 0, colorGradient: neutralGradient),
    Mood(type: 'Happy', value: 1, colorGradient: happyGradient),
    Mood(type: 'Excellent', value: 2, colorGradient: excellentGradient),
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
