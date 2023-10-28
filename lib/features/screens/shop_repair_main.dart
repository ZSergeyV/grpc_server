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
            // ignore: no_leading_underscores_for_local_identifiers
            final _bloc = context.read<RepairBloc>();
            return SafeArea(
                child: orientation == Orientation.landscape
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Expanded(flex: 1, child: RepairMainMenu()),
                          Expanded(
                              flex: 3,
                              child: Container(
                                color: Colors.white,
                                child: GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 20,
                                    childAspectRatio: 1.7,
                                  ),
                                  padding: const EdgeInsets.all(20),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Card(
                                      color: _bloc.state.repairs[index].paid
                                          ? Colors.greenAccent
                                          : Colors.redAccent,
                                      child: Center(
                                          child: Text(
                                              _bloc.state.repairs[index].code
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize: 22))),
                                    );
                                  },
                                  itemCount: _bloc.state.repairs.length,
//ProductListItem(product: state.products[index])
                                ),
                              )),
                        ],
                      )
                    : const Column(
                        children: [],
                      ));
          })),
    );
  }
}
