import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RepairShopMain extends StatelessWidget {
  const RepairShopMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 250, 250),
      body: MultiBlocProvider(
          providers: [],
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
                                    flex: 1,
                                    child: Container(
                                      color: Colors.brown,
                                    )),
                                Expanded(
                                    flex: 3,
                                    child: Container(
                                      color: Colors.cyan,
                                    )),
                              ],
                            )
                          : const Column(
                              children: [
                                // const Expanded(child: LeftPanelDateTime()),
                                // Expanded(child: HomeRightPanel(context)),
                              ],
                            ))),
            );
          })),
    );
  }
}
