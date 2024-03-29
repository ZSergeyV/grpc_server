import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grpc_server/bloc/settings/settings_bloc.dart';
import 'package:grpc_server/features/widgets/home_widgets.dart';
import 'package:grpc_server/resources/local_store.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final LocalStoreSettings localStore = LocalStoreSettings();
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 250, 250, 250),
        body: MultiBlocProvider(
            providers: [
              BlocProvider<SettingBloc>(
                  lazy: false,
                  create: (BuildContext context) =>
                      SettingBloc(store: localStore)..add(ReadSettingsEvent())),
            ],
            child: OrientationBuilder(builder: (context, orientation) {
              return SafeArea(
                child: GestureDetector(
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: orientation == Orientation.landscape
                            ? Row(
                                children: [
                                  Expanded(
                                      flex: 1, child: HomeLeftPanel(context)),
                                  Expanded(
                                      flex: 3, child: HomeRightPanel(context)),
                                ],
                              )
                            : Column(
                                children: [
                                  const Expanded(child: LeftPanelDateTime()),
                                  Expanded(child: HomeRightPanel(context)),
                                ],
                              ))),
              );
            })));
  }
}
