import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grpc_server/resources/local_store.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc({required this.store}) : super(const SettingState()) {
    on<ReadSettingsEvent>(_onSettingsRead);
    on<WriteSettingEvent>(_onSettingsWrite);
    //on<InitSettingsEvent>(_onSettingsInit);
  }

  final LocalStoreSettings store;

  // Future<void> _onSettingsInit(
  //     InitSettingsEvent event, Emitter<SettingState> emit) async {
  //   //_localStore = LocalStoreSettings().initStore();
  // }

  Future<void> _onSettingsRead(
      ReadSettingsEvent event, Emitter<SettingState> emit) async {
    try {
      if (state.status == SettingsStatus.read) {
        //await store.initStore();
        final appSettings = await _getSettings();
        return emit(state.copyWith(
          status: SettingsStatus.success,
          settings: appSettings,
        ));
      }
    } catch (_) {
      emit(state.copyWith(status: SettingsStatus.failure));
    }
  }

  Future<Map<String, dynamic>> _getSettings() async {
    Map<String, dynamic> result = {};

    result['SERVER_ADRESS'] = await store.getValue('SERVER_ADRESS') ?? '';
    result['LIMIT_PRODUCT'] = await store.getValue('LIMIT_PRODUCT') ?? 50;
    return result;
  }
}

Future<void> _onSettingsWrite(
    WriteSettingEvent event, Emitter<SettingState> emit) async {
  //SharedPreferences prefs = await SharedPreferences.getInstance();
  // if (state is CartLoaded) {
  //     try {
  //       // shoppingRepository.addItemToCart(event.item);
  //       // emit(CartLoaded(cart: Cart(items: [...state.cart.items, event.item])));
  //     } catch (_) {
  //       emit(state.copyWith(status: SettingsStatus.failure));
  //     }
  //   }
}
