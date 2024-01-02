import 'dart:developer';

import 'package:mooodify/core/models/mood.dart';
import 'package:mooodify/ui/common/contants.dart';

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

  /// calculate the average for of mood (value) for the last 7 days:
  double getAverage(DateTime datetime) {
    final date = DateTime(datetime.year, datetime.month, datetime.day);
    final last7Days =
        List.generate(7, (index) => date.subtract(Duration(days: index)));
    final moods = last7Days.map((day) => getMood(day).value);
    final average = moods.reduce((a, b) => a + b) / moods.length;
    return average;
  }
}
