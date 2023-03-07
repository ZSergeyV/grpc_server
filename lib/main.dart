import 'package:flutter/material.dart';
import 'package:grpc_server/config/theme.dart';
import 'package:grpc_server/features/screens/screens.dart';
import 'package:grpc_server/core/router.dart' as router;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //ApplicationSettings().init();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    onGenerateRoute: router.generateRoute,
    theme: basicTheme(),
    home: const HomePage(),
  ));
}
