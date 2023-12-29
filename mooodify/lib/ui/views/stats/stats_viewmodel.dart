import 'package:mooodify/app/app.locator.dart';
import 'package:mooodify/core/models/mood.dart';
import 'package:mooodify/services/mood_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StatsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _moodService = locator<MoodService>();
  Mood? todayMood;
  double currentAverage = 0;

  void init() {
    setBusy(true);
    final now = DateTime.now();
    todayMood = _moodService.getMood(now);
    currentAverage = _moodService.getAverage(now);

    setBusy(false);
    notifyListeners();
  }

  void getAverage(DateTime datetime) {
    currentAverage = _moodService.getAverage(datetime);
    notifyListeners();
  }

  void navBack() {
    _navigationService.back();
  }
}
