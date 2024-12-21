import 'package:shared_preferences/shared_preferences.dart';

class GIVPrefService {
  static final GIVPrefService _instance = GIVPrefService._internal();
  static SharedPreferences? _pref;

  GIVPrefService._internal();

  factory GIVPrefService() {
    return _instance;
  }

  Future<SharedPreferences> get getPref async {
    _pref ??= await SharedPreferences.getInstance();
    return _pref!;
  }
}
