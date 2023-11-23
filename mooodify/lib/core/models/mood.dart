class Mood {
  MoodType moodType;
  double moodValue;

  Mood({
    required this.moodType,
    required this.moodValue,
  });

  static List<Mood> allMoods() {
    return [
      Mood(moodType: MoodType.terrible, moodValue: -2),
      Mood(moodType: MoodType.bad, moodValue: -1),
      Mood(moodType: MoodType.neutral, moodValue: 0),
      Mood(moodType: MoodType.happy, moodValue: 1),
      Mood(moodType: MoodType.excellent, moodValue: 2),
    ];
  }
}

enum MoodType {
  terrible,
  bad,
  neutral,
  happy,
  excellent,
  none,
}

extension MoodExtension on MoodType {
  String get moodName {
    switch (this) {
      case MoodType.terrible:
        return 'Terrible';
      case MoodType.bad:
        return 'Bad';
      case MoodType.neutral:
        return 'Neutral';
      case MoodType.happy:
        return 'Happy';
      case MoodType.excellent:
        return 'Excellent';
      case MoodType.none:
        return 'None';
      default:
        return 'None';
    }
  }
}
