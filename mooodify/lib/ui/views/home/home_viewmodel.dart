import 'package:intl/intl.dart';
import 'package:mooodify/app/app.locator.dart';
import 'package:mooodify/core/models/mood.dart';
import 'package:mooodify/services/mood_service.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  final _moodService = locator<MoodService>();

  List<Mood> get moods => Mood.values;
  Mood selectedMood = Mood.Neutral;
  int moodIndex = 2; // default to Neutral

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
    _moodService.addMood(DateTime.now(), selectedMood);
    this.selectedMood = _moodService.getMood(DateTime.now());
    notifyListeners();

    // For debugging purposes
    _moodService.printMoods();
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
}
