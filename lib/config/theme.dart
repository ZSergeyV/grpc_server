import 'package:flutter/material.dart';

ThemeData basicTheme() => ThemeData(
      brightness: Brightness.light,
      primaryColor: const Color(0xFF4B39EF),
      useMaterial3: true,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
