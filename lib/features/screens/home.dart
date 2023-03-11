import 'package:flutter/material.dart';
import 'package:grpc_server/features/widgets/home_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: OrientationBuilder(builder: (context, orientation) {
      return SafeArea(
        child: GestureDetector(
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Row(
                  children: [
                    Expanded(flex: 1, child: HomeLeftPanel(context)),
                    Expanded(flex: 3, child: HomeRightPanel(context)),
                  ],
                ))),
      );
    }));
  }
}
