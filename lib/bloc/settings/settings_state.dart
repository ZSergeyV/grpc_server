part of 'settings_bloc.dart';

enum SettingsStatus { read, write, success, failure }

class SettingState extends Equatable {
  const SettingState({
    this.status = SettingsStatus.read,
    this.settings = const {},
  });

  final SettingsStatus status;
  final Map<String, dynamic> settings;

  SettingState copyWith({
    SettingsStatus? status,
    Map<String, dynamic>? settings,
  }) {
    return SettingState(
      status: status ?? this.status,
      settings: settings ?? this.settings,
    );
  }

  @override
  String toString() {
    return '''Settings { status: $status} }''';
  }

  @override
  List<Object> get props => [status, settings];
}
