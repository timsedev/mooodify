import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:mooodify/app/app.locator.dart';
import 'package:mooodify/app/app.router.dart';
import 'package:mooodify/core/models/mood.dart';
import 'package:mooodify/services/mood_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _moodService = locator<MoodService>();
  final _navigationService = locator<NavigationService>();

  List<Mood> get moods => _moodService.allMoods;
  Mood? selectedMood;
  int moodIndex = 2; // default to Neutral

  DateTime selectedDate = DateTime.now();

  Future<void> init() async {
    setBusy(true);
    selectedMood = _moodService.getMood(DateTime.now());
    setBusy(false);
  }

  void onMoodSliderChanged(int index) {
    moodIndex = index;
    notifyListeners();
  }

  void selectMood() {
    final selectedMood = moods.elementAt(moodIndex);
    _moodService.addMood(selectedDate, selectedMood);
    this.selectedMood = _moodService.getMood(selectedDate);
    notifyListeners();

    // For debugging purposes
    _moodService.printMoods();
    log('Selected moodname: ${selectedMood.type}');
    log('All Selected moods: ${_moodService.moodByDay}');
  }

  String formatDate(DateTime now) {
    final date = DateFormat('dd MMM yyyy').format(now);

    /// if it is today or yesterday, show that instead of the day of the week
    final isToday = now.day == DateTime.now().day;
    final isYesterday =
        now.day == DateTime.now().subtract(const Duration(days: 1)).day;

    /// if it is not today or yesterday, show the day of the week
    final dayOfWeek = DateFormat('EEEE').format(now);
    final prefix = isToday
        ? 'Today'
        : isYesterday
            ? 'Yesterday'
            : dayOfWeek;

    return '$prefix, $date';
  }

  void forwardDate() {
    final tomorrow = selectedDate.add(const Duration(days: 1));
    selectedMood = _moodService.getMood(tomorrow);
    selectedDate = tomorrow;
    notifyListeners();
  }

  void backwardDate() {
    final yesterday = selectedDate.subtract(const Duration(days: 1));
    selectedMood = _moodService.getMood(yesterday);
    selectedDate = yesterday;
    notifyListeners();
  }

  Future<void> navToCalendarView() async {
    await _navigationService.navigateToCalendarView();
  }

  Future<void> navToStatsView() async {
    await _navigationService.navigateToStatsView();
  }
}
