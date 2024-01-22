import 'package:mooodify/services/mood_service.dart';
import 'package:stacked/stacked.dart';
import 'package:mooodify/app/app.locator.dart';
import 'package:mooodify/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _moodService = locator<MoodService>();

  Future runStartupLogic() async {
    // read the saved moods through MoodService
    await _moodService.readMoods();

    _navigationService.replaceWithHomeView();
  }
}
