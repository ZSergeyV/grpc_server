import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:grpc_server/bloc/categories/categories_bloc.dart';
import 'package:grpc_server/config/config.dart';
import 'package:grpc_server/features/screens/screens.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class LeftPanelDateTime extends StatefulWidget {
  const LeftPanelDateTime({super.key});

  @override
  State<LeftPanelDateTime> createState() => _LeftPanelDateTimeState();
}

class _LeftPanelDateTimeState extends State<LeftPanelDateTime> {
  late String _timeString;
  late String _dateString;

  @override
  void initState() {
    Intl.defaultLocale = 'ru_RU';
    initializeDateFormatting('ru_RU', null);
    _timeString = _formatDateTime(DateTime.now(), 'HH:mm');
    _dateString = _formatDateTime(DateTime.now(), 'dd MMMM yyyy');

    Timer.periodic(const Duration(seconds: 5), (Timer t) => _getTime());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedTime = _formatDateTime(now, 'HH:mm');
    final String formattedDate = _formatDateTime(now, 'dd MMMM yyyy');

    if (mounted) {
      setState(() {
        _timeString = formattedTime;
        _dateString = formattedDate;
      });
    }
  }

  String _formatDateTime(DateTime dateTime, String format) {
    return DateFormat(format, 'ru').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          _timeString,
          style: const TextStyle(
              color: Color.fromARGB(255, 66, 66, 66),
              fontSize: 60,
              letterSpacing: 5,
              fontWeight: FontWeight.w600,
              fontFamily: 'Roboto'),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
          child: Text(
            _dateString,
            style: const TextStyle(
                color: Color.fromARGB(255, 65, 65, 65),
                fontSize: 30,
                fontWeight: FontWeight.w300,
                fontFamily: 'Roboto'),
          ),
        ),
      ],
    );
    // );
  }
}

Widget HomeLeftPanel(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      const Expanded(child: LeftPanelDateTime()),
      const SizedBox(
        height: 15,
      ),
      Expanded(
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(
                Icons.point_of_sale,
                size: 42,
              ),
              title: const Text('Касса', style: HOME_LEFT_MENU_TEXT_STYLE),
              onTap: () {},
              minVerticalPadding: 15,
            ),
            ListTile(
                leading: const Icon(
                  Icons.shopping_bag,
                  size: 42,
                ),
                title: const Text('Продажи', style: HOME_LEFT_MENU_TEXT_STYLE),
                onTap: () {},
                minVerticalPadding: 15),
            ListTile(
                leading: const Icon(
                  Icons.settings,
                  size: 42,
                ),
                title:
                    const Text('Настройки', style: HOME_LEFT_MENU_TEXT_STYLE),
                onTap: () => Navigator.pushNamed(context, SettingsPageRoute),
                minVerticalPadding: 15),
          ],
        ),
      )
    ],
  );
}

Widget HomeRightPanel(BuildContext context) {
  // return BlocBuilder<CategoriesBloc, CategoriesState>(
  //     builder: (builderContext, state) {
  return Padding(
    padding: const EdgeInsets.all(65.0),
    child: GridView.builder(
        cacheExtent: 5,
        padding: EdgeInsets.zero,
        primary: false,
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 1.7,
        ),
        itemCount: menuItems.length,
        itemBuilder: (context, index) =>
            HomeGridItem(context, menuItems[index])),
  );
  // });
}

Widget HomeGridItem(BuildContext context, Map<String, dynamic> item) {
  return InkWell(
    onTap: () async {
      Navigator.pushNamed(context, item['action'], arguments: 820);
    },
    child: Card(
        surfaceTintColor: Colors.white,
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              item['title'],
              style: const TextStyle(fontSize: 30),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              item['descriptions'] ?? '',
              style: const TextStyle(fontSize: 24),
            ),
          ]),
        )),
  );
}
