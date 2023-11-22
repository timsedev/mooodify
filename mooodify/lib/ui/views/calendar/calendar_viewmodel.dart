import 'package:mooodify/app/app.locator.dart';
import 'package:mooodify/core/models/mood.dart';
import 'package:mooodify/services/mood_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class CalendarViewModel extends BaseViewModel {
  final _moodService = locator<MoodService>();
  final _navigationService = locator<NavigationService>();

  Mood todayMood = Mood.none;
  DateTime focusedDay = DateTime.now();

  Future<void> init() async {
    todayMood = _moodService.getMood(DateTime.now());
    notifyListeners();
  }

  /// There will only be one mood per day, but the eventLoader expects a list
  List<Mood?> getMoodsForDay(DateTime day) {
    final moodOfDay = _moodService.getMood(day);
    if (moodOfDay == Mood.none) {
      return [];
    }
    return [moodOfDay];
  }

  void onDaySelected(DateTime day) {
    todayMood = _moodService.getMood(day);
    focusedDay = day;
    notifyListeners();
  }

  void navBack() {
    _navigationService.back();
  }
}
