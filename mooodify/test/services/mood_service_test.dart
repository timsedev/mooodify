import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mooodify/app/app.locator.dart';
import 'package:mooodify/services/mood_service.dart';
import 'package:mooodify/services/storage_service.dart';

import '../helpers/test_helpers.dart';
import 'mood_service_test.mocks.dart';

@GenerateMocks([StorageService])
void main() {
  group('MoodServiceTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());

    final mockStorageService = MockStorageService();
    final moodService = MoodService(storageService: mockStorageService);

    /// test cases:
    /// ! not testing this first, because decodeMoods in involved inside readMoods
    /// readMoods:
    /// - Given a list of moods, when I read them, then I should have a map of moods
    /// - Given an empty list of moods, when I read them, then I should have an empty map of moods
    /// - Given an invalid list of moods, when I read them, then I should have an empty map of moods
    // group('readMoods -', () {
    //   test(
    //       'Given a list of moods, when I read them, then I should have a map of moods',
    //       () async {
    //     when(mockStorageService.readMoods()).thenAnswer((_) async =>
    //         '{"2024-01-22T14:36:18.507":1,"2024-01-20T14:36:18.507":2}');

    //     moodService.readMoods();

    //     expect(moodService.moodByDay.length, 2);
    //     expect(moodService.moodByDay['2024-01-22T14:36:18.507'], 1);
    //     expect(moodService.moodByDay['2024-01-20T14:36:18.507'], 2);
    //   });
    // });

    /// encodeMoods:
    /// - Given a map of moods, when I encode them and decode them, then I should have the same map of moods
    /// - Given an empty map of moods, when I encode them, then I should have an empty string
    group('encodeMoods -', () {
      test(
          'Given a map of moods, when I encode them and decode them, then I should have the same map of moods',
          () async {
        when(mockStorageService.writeMoods(any)).thenAnswer((_) async =>
            '{"2024-01-22T14:36:18.507":1,"2024-01-20T14:36:18.507":2}');

        moodService.readMoods();

        expect(moodService.moodByDay.length, 2);
        expect(moodService.moodByDay['2024-01-22T14:36:18.507'], 1);
        expect(moodService.moodByDay['2024-01-20T14:36:18.507'], 2);
      });
    });

    /// decodeMoods:
    /// - Given a list of encoded moods (in String), when I decode them, then I should have a map of moods
    /// - Given an empty string (empty moods), when I decode them, then I should have an empty map of moods
    /// - Given an invalid string (invalid moods), when I decode them, then I should have an empty map of moods
    ///
    /// addMood:
    /// - Given a map of moods, when I add a mood, then I should have a map of moods with the new mood
    /// - Given a map of moods, when I add a mood with the same date, then the old mood should be replaced with the new mood
    ///
    /// getMood:
    /// - Given a map of moods, when I get a mood that was recorded before, then I should have the mood
    /// - Given a map of moods, when I get a mood that was not recorded before, then I should have a neutral mood
    ///
    /// getNeutral:
    /// - Given a map of moods, when I get the neutral mood, then I should have the neutral mood
    ///
    /// getAverage:
    /// - not needed for this method, might be removed
    ///
    /// getWeeklyAverageSpots:
    /// - Given a map of moods within this week with the average of 1, when I get the weekly average spots, then I should have a list of 7 spots with the average of 1
  });
}
