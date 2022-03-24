import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class SharedPreferenceRegister {
  static SharedPreferences? _instance;
  @preResolve
  Future<SharedPreferences> createSp() async =>
      _instance ??= await SharedPreferences.getInstance();
}
