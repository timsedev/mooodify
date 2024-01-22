import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  final _storage = FlutterSecureStorage();

  final _moodsKey = 'moodsKey';

  Future<void> writeMoods(String moods) async {
    log('Writing moods: $moods');

    await _storage.write(key: _moodsKey, value: moods);
  }

  Future<String?> readMoods() async {
    return await _storage.read(key: _moodsKey);
  }
}
