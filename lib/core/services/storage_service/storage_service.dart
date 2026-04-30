import 'package:shared_preferences/shared_preferences.dart';

abstract interface class StorageService {
  Future<void> setString({required String key, required String value});

  String? getString({required String key});

  Future<void> setBool({required String key, required bool value});

  bool? getBool({required String key});
}

class StorageServiceImpl implements StorageService {
  final SharedPreferences sharedPreferences;

  StorageServiceImpl({required this.sharedPreferences});

  @override
  Future<void> setString({required String key, required String value}) async {
    await sharedPreferences.setString(key, value);
  }

  @override
  String? getString({required String key}) {
    final data = sharedPreferences.getString(key);
    return data;
  }

  @override
  Future<void> setBool({required String key, required bool value}) async {
    await sharedPreferences.setBool(key, value);
  }

  @override
  bool? getBool({required String key}) {
    final data = sharedPreferences.getBool(key);
    return data;
  }
}
