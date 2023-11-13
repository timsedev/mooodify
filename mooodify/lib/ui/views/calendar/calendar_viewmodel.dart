import 'package:mooodify/app/app.locator.dart';
import 'package:mooodify/core/models/mood.dart';
import 'package:mooodify/services/mood_service.dart';
import 'package:stacked/stacked.dart';

class CalendarViewModel extends BaseViewModel {
  final _moodService = locator<MoodService>();

  /// There will only be one mood per day, but the eventLoader expects a list
  List<Mood?> getMoodsForDay(DateTime day) {
    final moodOfDay = _moodService.getMood(day);
    if (moodOfDay == Mood.none) {
      return [];
    }
    return [moodOfDay];
  }
}
