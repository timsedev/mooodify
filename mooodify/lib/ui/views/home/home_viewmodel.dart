import 'package:mooodify/core/models/mood.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  List<Mood> get moods => Mood.values;
}
