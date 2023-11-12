import 'package:mooodify/core/models/mood.dart';

class MoodService {
  Map<DateTime, Mood> moodByDay = {};

  void addMood(DateTime date, Mood mood) {
    moodByDay[date] = mood;
  }

  Mood? getMood(DateTime date) {
    return moodByDay[date];
  }
}
