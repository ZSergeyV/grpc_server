part of 'settings_bloc.dart';

abstract class SettingEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class InitSettingsEvent extends SettingEvent {}

class ReadSettingsEvent extends SettingEvent {}

class WriteSettingEvent extends SettingEvent {}
