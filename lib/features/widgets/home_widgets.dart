import 'dart:async';

import 'package:flutter/material.dart';
import 'package:grpc_server/features/screens/screens.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class HomeBackgroundImage extends StatelessWidget {
  final Orientation orientation;
  const HomeBackgroundImage({super.key, required this.orientation});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const AlignmentDirectional(1, 1),
      child: Image.asset(
        'assets/images/splash_screen_bg.png',
        width: 768,
        height: MediaQuery.of(context).size.height *
            (orientation == Orientation.portrait ? 0.52 : 0.84),
        fit: BoxFit.scaleDown,
      ),
    );
  }
}

class LeftPanel extends StatelessWidget {
  final Orientation orientation;
  const LeftPanel({super.key, required this.orientation});

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: const AlignmentDirectional(-1, 0),
        child: Container(
            width: MediaQuery.of(context).size.width *
                (orientation == Orientation.portrait ? 0.7 : 0.5),
            height: MediaQuery.of(context).size.height * 1,
            //decoration: const BoxDecoration(),
            child: Align(
              alignment: const AlignmentDirectional(-1, 1),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  LeftPanelCaption(),
                  LeftPanelButton(),
                  LeftPanelDateTime()
                ],
              ),
            )));
  }
}

class LeftPanelCaption extends StatelessWidget {
  const LeftPanelCaption({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
          child: Text(
            'ГУЛЛИВЕР',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 50,
                  letterSpacing: 25,
                  fontWeight: FontWeight.w100,
                ),
          ),
        ),
        Align(
          alignment: const AlignmentDirectional(0.4, 0),
          child: Text(
            'КАССА',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: const Color(0xFF7F7F7F),
                  fontSize: 30,
                  letterSpacing: 15,
                  fontWeight: FontWeight.w300,
                ),
          ),
        ),
      ],
    );
  }
}

class LeftPanelButton extends StatelessWidget {
  const LeftPanelButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
          child: ElevatedButton(
            onPressed: () async {
              Navigator.pushNamed(context, ShopMainPageRoute);
            },
            style: ElevatedButton.styleFrom(
              textStyle:
                  const TextStyle(fontSize: 35, fontStyle: FontStyle.normal),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(40)),
              ),
              backgroundColor: const Color.fromARGB(255, 15, 41, 184),
              foregroundColor: Colors.white,
              minimumSize: const Size(400, 80),
            ),
            child: const Text('МАГАЗИН'),
          ),
          // ),
        ),
        ElevatedButton(
          onPressed: () {
            print('Button pressed ...');
          },
          style: ElevatedButton.styleFrom(
            textStyle:
                const TextStyle(fontSize: 35, fontStyle: FontStyle.normal),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(40)),
            ),
            backgroundColor: const Color(0xFF4B39EF),
            foregroundColor: Colors.white,
            minimumSize: const Size(400, 80),
          ),
          child: const Text('МАСТЕРСКАЯ'),
        ),
        // ),
      ],
    );
  }
}

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

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedTime = _formatDateTime(now, 'HH:mm');
    final String formattedDate = _formatDateTime(now, 'dd MMMM yyyy');

    setState(() {
      _timeString = formattedTime;
      _dateString = formattedDate;
    });
  }

  String _formatDateTime(DateTime dateTime, String format) {
    return DateFormat(format, 'ru').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(25, 0, 0, 0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _timeString,
            style: const TextStyle(
              color: Color(0xFF6B6B6B),
              fontSize: 50,
              letterSpacing: 10,
              fontWeight: FontWeight.w300,
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 20),
            child: Text(
              _dateString,
              style: const TextStyle(
                color: Color.fromARGB(255, 97, 97, 97),
                fontSize: 20,
                fontWeight: FontWeight.w200,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
