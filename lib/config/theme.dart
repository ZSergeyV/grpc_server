import 'package:flutter/material.dart';

ThemeData basicTheme() => ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xFF4B39EF),
    useMaterial3: true,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    navigationRailTheme: const NavigationRailThemeData(
      elevation: 2,
      useIndicator: false,
      groupAlignment: -1,
    ),
    fontFamily: 'Cuprum');
