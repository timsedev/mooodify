import 'package:mooodify/core/models/mood.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  List<Mood> get moods => Mood.values;

  Mood selectedMood = Mood.Happy;
  int moodIndex = 2; // default to Neutral

  void onMoodSliderChanged(int index) {
    moodIndex = index;
    notifyListeners();
  }

  void selectMood() {
    selectedMood = moods.elementAt(moodIndex);
    notifyListeners();
  }
}
