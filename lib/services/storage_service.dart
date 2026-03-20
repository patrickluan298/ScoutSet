import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  StorageService._();

  static final StorageService instance = StorageService._();

  SharedPreferences? _prefs;

  Future<void> initialize() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  Future<void> save({
    required String key,
    required String value,
  }) async {
    await initialize();
    await _prefs!.setString(key, value);
  }

  Future<String?> read(String key) async {
    await initialize();
    return _prefs!.getString(key);
  }

  Future<void> remove(String key) async {
    await initialize();
    await _prefs!.remove(key);
  }

  Future<void> removeMany(Iterable<String> keys) async {
    await initialize();
    for (final key in keys) {
      await _prefs!.remove(key);
    }
  }

  Future<void> clear() async {
    await initialize();
    await _prefs!.clear();
  }
}
