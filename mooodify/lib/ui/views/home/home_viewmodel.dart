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
  }
}
