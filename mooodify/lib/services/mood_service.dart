import 'dart:convert';
import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mooodify/app/app.locator.dart';
import 'package:mooodify/core/models/mood.dart';
import 'package:mooodify/services/storage_service.dart';

class MoodService {
  StorageService _storageService = locator<StorageService>();

  /// this is where all the recorded moods are
  Map<DateTime, Mood?> moodByDay = {};

  /// these are all the mood options
  List<Mood> allMoods = [
    Mood(type: 'Terrible', value: -2),
    Mood(type: 'Bad', value: -1),
    Mood(type: 'Neutral', value: 0),
    Mood(type: 'Happy', value: 1),
    Mood(type: 'Excellent', value: 2),
  ];

  double chartAverage = 0;
  List<FlSpot> chartAverageSpots = [];

  MoodService({StorageService? storageService}) {
    if (storageService != null) {
      _storageService = storageService;
    }
  }

  Future<void> readMoods() async {
    final encodedMoods = await _storageService.readMoods();

    if (encodedMoods != null) {
      moodByDay = decodeMoods(encodedMoods);
    }
  }

  String? encodeMoods() {
    final encodedMoods = jsonEncode(moodByDay);

    _storageService.writeMoods(jsonEncode(encodedMoods));

    return encodedMoods;
  }

  Map<DateTime, Mood> decodeMoods(String encodedMoods) {
    final decodedMoods = jsonDecode(encodedMoods);
    return decodedMoods;
  }

  void addMood(DateTime datetime, Mood mood) {
    final date = DateTime(datetime.year, datetime.month, datetime.day);
    moodByDay[date] = mood;
  }

  Mood getMood(DateTime datetime) {
    final date = DateTime(datetime.year, datetime.month, datetime.day);
    return moodByDay[date] ?? getNeutral();
  }

  Mood getNeutral() => allMoods[2];

  /// For debugging purposes
  void printMoods() {
    moodByDay.forEach((key, value) {
      log('$key: $value');
    });
  }

  /// calculate the average for of mood (value) for the last 7 days:
  double getAverage(DateTime datetime) {
    final date = DateTime(datetime.year, datetime.month, datetime.day);
    final last7Days =
        List.generate(7, (index) => date.subtract(Duration(days: index)));
    final moods = last7Days.map((day) => getMood(day).value);
    final average = moods.reduce((a, b) => a + b) / moods.length;
    return average;
  }

  void getWeeklyAverageSpots() {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1)); // Monday

    final daysOfWeek =
        List.generate(7, (index) => startOfWeek.add(Duration(days: index)));
    final moods = daysOfWeek.map((day) => getMood(day).value);

    chartAverage = moods.reduce((a, b) => a + b) / moods.length;
    chartAverageSpots = List.generate(7, (index) {
      final day = daysOfWeek[index];
      final mood = getMood(day);
      return FlSpot(index.toDouble(), mood.value);
    });
  }
}
