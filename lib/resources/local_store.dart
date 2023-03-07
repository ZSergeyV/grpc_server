import 'package:shared_preferences/shared_preferences.dart';

class LocalStoreSettings {
  late SharedPreferences _prefs;

  // Future<void> initStore() async {
  //   _prefs = await SharedPreferences.getInstance();
  // }

  void setValue(String name, dynamic value) async {
    _prefs = await SharedPreferences.getInstance();
    if (value is int) _prefs.setInt(name, value);
    if (value is String) _prefs.setString(name, value);
    if (value is bool) _prefs.setBool(name, value);
  }

  dynamic getValue(String name) async {
    _prefs = await SharedPreferences.getInstance();
    bool isValue = _prefs.containsKey(name);
    if (isValue) return _prefs.get(name);
  }
}
