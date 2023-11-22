import 'package:mooodify/app/app.locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StatsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  void navBack() {
    _navigationService.back();
  }
}
