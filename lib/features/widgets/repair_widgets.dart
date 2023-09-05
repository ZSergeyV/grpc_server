import 'package:flutter/material.dart';
import 'package:grpc_server/config/config.dart';

class RepairMainMenu extends StatefulWidget {
  const RepairMainMenu({super.key});

  @override
  State<RepairMainMenu> createState() => _RepairMainMenuState();
}

class _RepairMainMenuState extends State<RepairMainMenu> {
  late int _selectedIndex;

  @override
  void initState() {
    _selectedIndex = 0;
    super.initState();
  }

  List<NavigationRailDestination> _buildDestinations() {
    Icon icon = const Icon(Icons.check_circle_outline);

    return menuItemsRepair.map((element) {
      return NavigationRailDestination(
          icon: icon,
          label: Text(element['title'], textAlign: TextAlign.left),
          padding: const EdgeInsets.only(bottom: 12, left: 12));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(
              right: BorderSide(color: Color.fromARGB(221, 182, 182, 182))),
          color: Colors.white),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const Padding(padding: EdgeInsets.all(12), child: Text('data')),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView.builder(
                  padding: const EdgeInsets.all(2),
                  itemCount: menuItemsRepair.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      decoration: BoxDecoration(
                          color: index == _selectedIndex
                              ? const Color.fromARGB(155, 184, 248, 217)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: ListTile(
                        selectedColor: const Color.fromARGB(255, 0, 94, 58),
                        textColor: Colors.black38,
                        style: ListTileStyle.list,
                        selected: index == _selectedIndex,
                        title: Text(menuItemsRepair[index]['title'],
                            style: const TextStyle(fontSize: 22)),
                        onTap: () {
                          setState(() {
                            _selectedIndex = index;
                          });
                        },
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}

// class NavigationRailMenuButton extends StatelessWidget {
//   const NavigationRailMenuButton({super.key, this.onPressed});
//   final VoidCallback? onPressed;

//   @override
//   Widget build(BuildContext context) {
//     final Animation<double> animation =
//         NavigationRail.extendedAnimation(context);
//     return AnimatedBuilder(
//       animation: animation,
//       builder: (BuildContext context, Widget? child) {
//         return Container(
//           padding: EdgeInsets.only(
//             right: lerpDouble(0, 250, animation.value)!,
//           ),
//           child: IconButton(
//             icon: const Icon(Icons.menu),
//             iconSize: 32,
//             onPressed: onPressed,
//           ),
//         );
//       },
//     );
//   }
// }
