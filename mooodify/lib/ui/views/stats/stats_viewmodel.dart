import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mooodify/app/app.locator.dart';
import 'package:mooodify/core/models/mood.dart';
import 'package:mooodify/services/mood_service.dart';
import 'package:mooodify/ui/common/contants.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StatsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _moodService = locator<MoodService>();
  Mood? todayMood;
  double currentAverage = 0;
  List<Color> gradientColors = excellentGradient;

  double get chartAverage => _moodService.chartAverage;
  List<FlSpot> get chartAverageSpots => _moodService.chartAverageSpots;

  int selectedTabIndex = 0;

  void init() {
    setBusy(true);
    final now = DateTime.now();
    todayMood = _moodService.getMood(now);
    getAverage(now);
    getWeeklyAverageSpots();

    setBusy(false);
    notifyListeners();

    testGetSpots();
  }

  void getAverage(DateTime datetime) {
    currentAverage = _moodService.getAverage(datetime);
    getGradientColors();
    notifyListeners();
  }

  void getWeeklyAverageSpots() {
    _moodService.getWeeklyAverageSpots();
    notifyListeners();
  }

  void getGradientColors() {
    if (currentAverage < -1) {
      log('terrible');
      gradientColors = terribleGradient;
    } else if (currentAverage < 0 && currentAverage >= -1) {
      log('bad');
      gradientColors = badGradient;
    } else if (currentAverage < 1 && currentAverage >= 0) {
      log('neutral');
      gradientColors = neutralGradient;
    } else if (currentAverage < 2 && currentAverage >= 1) {
      log('happy');
      gradientColors = happyGradient;
    } else {
      log('excellent');
      gradientColors = excellentGradient;
    }

    notifyListeners();
  }

  void navBack() {
    _navigationService.back();
  }

  void testGetSpots() {
    final stopwatch = Stopwatch()..start();
    _moodService.getWeeklyAverageSpots();
    log('\ngetSpots() executed in ${stopwatch.elapsed}\n');
    stopwatch.stop();
  }

  void onTabTapped(int index) {
    selectedTabIndex = index;
    notifyListeners();
  }
}
