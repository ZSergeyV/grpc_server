part of 'settings_bloc.dart';

abstract class SettingEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ReadSettingsEvent extends SettingEvent {
  //ReadSettingsEvent();
}

class WriteSettingEvent extends SettingEvent {
  //WriteSettingEvent();
}
