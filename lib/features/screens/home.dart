import 'package:flutter/material.dart';
import 'package:grpc_server/features/widgets/home_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: OrientationBuilder(builder: (context, orientation) {
      return SafeArea(
        child: GestureDetector(
            child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            //alignment: const AlignmentDirectional(0, 0),
            children: [
              HomeBackgroundImage(orientation: orientation),
              LeftPanel(orientation: orientation)
            ],
          ),
        )),
      );
    }));
  }
}
