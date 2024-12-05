import 'package:shared_preferences/shared_preferences.dart';

class GIVPref {
  static final GIVPref _instance = GIVPref._internal();
  static SharedPreferences? _pref;

  GIVPref._internal();

  factory GIVPref() {
    return _instance;
  }

  Future<SharedPreferences> get getPref async {
    _pref ??= await SharedPreferences.getInstance();
    return _pref!;
  }
}
