import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grpc_server/bloc/repair/repair_bloc.dart';
import 'package:grpc_server/features/widgets/repair_widgets.dart';
import 'package:grpc_server/resources/api_repository.dart';

class RepairShopMain extends StatelessWidget {
  const RepairShopMain({super.key});

  @override
  Widget build(BuildContext context) {
    final DataRepository dataRepository = DataRepository();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 250, 250),
      body: MultiBlocProvider(
          providers: [
            BlocProvider<RepairBloc>(
                lazy: false,
                create: (BuildContext context) =>
                    RepairBloc(repository: dataRepository)
                      ..add(FetchedNoPayRepairs())),
          ],
          child: OrientationBuilder(builder: (context, orientation) {
            return SafeArea(
                child: orientation == Orientation.landscape
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex: 1, child: RepairMainMenu()),
                          Expanded(
                              flex: 3,
                              child: Container(
                                color: Colors.white,
                              )),
                        ],
                      )
                    : const Column(
                        children: [
                          // const Expanded(child: LeftPanelDateTime()),
                          // Expanded(child: HomeRightPanel(context)),
                        ],
                      ));
          })),
    );
  }
}
