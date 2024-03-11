import 'package:flutter/material.dart';
import 'package:mooodify/app/app.locator.dart';
import 'package:mooodify/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Routes.startupView,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
      navigatorObservers: [
        StackedService.routeObserver,
      ],
    );
  }
}
