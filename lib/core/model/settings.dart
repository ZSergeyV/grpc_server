import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:shared_preferences_windows/shared_preferences_windows.dart';

class AppSetting extends Equatable {
  const AppSetting({required this.name, required this.value});

  final String name;
  final dynamic value;

  @override
  List<Object> get props => [name, value];
}

class ApplicationSettings {
  final Map<String, dynamic> settings = {};

  void getSettingsByName(String name) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    bool isValue = _prefs.containsKey(name);
    //if (isValue) settings.update({'a', '1221'});
    //(AppSetting(name: name, value: _prefs.get(name)));
    //return isValue ? _prefs.get(name) : '';
    //return isValue ? _prefs.get(name) : '';
    //return _settings.firstWhere((element) => element.name == name).name;
  }

  //List<AppSetting> getSettings() => _settings;

  void setSettings(String name, dynamic value) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    if (value is int) _prefs.setInt(name, value);
    if (value is String) _prefs.setString(name, value);
    if (value is bool) _prefs.setBool(name, value);

    // _settings.add(
    //     const AppSetting(name: 'SERVER_ADRESS', value: '192.168.10.14:5000'));
    // _settings.add(const AppSetting(name: 'LIMIT_PRODUCT', value: 50));
  }

  void init() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.remove('SERVER_ADRESS');

    if (!_prefs.containsKey('SERVER_ADRESS')) {
      _prefs.setString('SERVER_ADRESS', '192.168.10.3:5000');
    }
    if (!_prefs.containsKey('LIMIT_PRODUCT')) {
      _prefs.setInt('LIMIT_PRODUCT', 50);
    }

    // settings.add(
    //     const AppSetting(name: 'SERVER_ADRESS', value: '192.168.10.3:5000'));
    // settings.add(const AppSetting(name: 'LIMIT_PRODUCT', value: 50));
  }
}
