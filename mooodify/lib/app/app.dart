import 'package:mooodify/ui/views/home/home_view.dart';
import 'package:mooodify/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:mooodify/ui/views/calendar/calendar_view.dart';
import 'package:mooodify/services/mood_service.dart';
import 'package:mooodify/ui/views/stats/stats_view.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: CalendarView),
    MaterialRoute(page: StatsView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: MoodService),
// @stacked-service
  ],
  bottomsheets: [
    // @stacked-bottom-sheet
  ],
  dialogs: [
    // @stacked-dialog
  ],
)
class App {}
