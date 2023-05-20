import 'package:flutter/material.dart';
import 'package:grpc_server/features/screens/screens.dart';
import 'package:grpc_server/features/screens/settings.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomePageRoute:
      return MaterialPageRoute(builder: (context) => const HomePage());
    case ShopMainPageRoute:
      return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => const MainShopPage());
    case ProductsPageRoute:
      return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => const MainShopPage());
    case ProductItemPageRoute:
      return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => const ProductPage());
    case CartPageRoute:
      return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => const CartPage());
    case RepairShopMainPageRoute:
      return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => const RepairShopMain());
    case SettingsPageRoute:
      return MaterialPageRoute(builder: (context) => const SettingsPage());
    default:
      return MaterialPageRoute(builder: (context) => const HomePage());
  }
}
