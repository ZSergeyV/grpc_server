import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grpc_server/bloc/cart/cart_bloc.dart';
import 'package:grpc_server/config/theme.dart';
import 'package:grpc_server/features/screens/screens.dart';
import 'package:grpc_server/core/router.dart' as router;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //ApplicationSettings().init();
  runApp(MultiBlocProvider(
      providers: [
        BlocProvider<CartBloc>(
            lazy: false, create: (BuildContext context) => CartBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: router.generateRoute,
        theme: basicTheme(),
        home: const HomePage(),
      )));
}
