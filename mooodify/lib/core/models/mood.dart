enum Mood {
  depressed,
  stressed,
  neutral,
  happy,
  excited,
  none,
}

extension MoodExtension on Mood {
  String get moodName {
    switch (this) {
      case Mood.depressed:
        return 'Depressed';
      case Mood.stressed:
        return 'Stressed';
      case Mood.neutral:
        return 'Neutral';
      case Mood.happy:
        return 'Happy';
      case Mood.excited:
        return 'Excited';
      case Mood.none:
        return 'None';
      default:
        return 'None';
    }
  }
}
