import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// import 'package:grpc_server/core/model/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc() : super(const SettingState()) {
    on<ReadSettingsEvent>(_onSettingsRead);
    on<WriteSettingEvent>(_onSettingsWrite);
  }

  Future<void> _onSettingsRead(
      ReadSettingsEvent event, Emitter<SettingState> emit) async {
    try {
      if (state.status == SettingsStatus.read) {
        final _appSettings = await _getSettings();
        return emit(state.copyWith(
          status: SettingsStatus.success,
          settings: _appSettings,
        ));
      }
    } catch (_) {
      emit(state.copyWith(status: SettingsStatus.failure));
    }
  }

  Future<Map<String, dynamic>> _getSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> result = {};
    // String SERVER_ADRESS = prefs.getString('SERVER_ADRESS') ?? '';
    // int LIMIT_PRODUCT = prefs.getInt('LIMIT_PRODUCT') ?? 50;
    result['SERVER_ADRESS'] = prefs.getString('SERVER_ADRESS') ?? '';
    result['LIMIT_PRODUCT'] = prefs.getInt('LIMIT_PRODUCT') ?? 50;
    return result;
  }
}

Future<void> _onSettingsWrite(
    WriteSettingEvent event, Emitter<SettingState> emit) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // if (state is CartLoaded) {
  //     try {
  //       // shoppingRepository.addItemToCart(event.item);
  //       // emit(CartLoaded(cart: Cart(items: [...state.cart.items, event.item])));
  //     } catch (_) {
  //       emit(state.copyWith(status: SettingsStatus.failure));
  //     }
  //   }
}
