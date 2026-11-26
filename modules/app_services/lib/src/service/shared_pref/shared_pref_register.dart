import 'package:app_services/src/service/storage/storage_migrations.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class SharedPreferenceRegister {
  static SharedPreferences? _instance;

  /// Opens SharedPreferences and brings the stored layout up to the current
  /// schema before anything reads it ([StorageMigrations.run] never throws).
  @preResolve
  Future<SharedPreferences> createSp() async {
    final existing = _instance;
    if (existing != null) return existing;
    final prefs = await SharedPreferences.getInstance();
    await StorageMigrations.run(prefs);
    return _instance = prefs;
  }
}
