import 'package:flutter/material.dart';
import 'package:grpc_server/features/screens/screens.dart';

const String SERVER_ADRESS = '192.168.10.14:5000';
const int LIMIT_PRODUCT = 50;

const TextStyle PRODUCT_TEXT_STYLE = TextStyle(
  fontSize: 18,
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w400,
);

const TextStyle CART_TEXT_STYLE = TextStyle(
  fontSize: 16,
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w400,
);

const TextStyle HOME_LEFT_MENU_TEXT_STYLE = TextStyle(
    fontSize: 26, fontWeight: FontWeight.w800, fontFamily: 'Montserrat');

List<Map<String, dynamic>> menuItems = [
  {
    'title': 'Магазин',
    'descriptions': 'Содержит список товаров для продажи в магазине',
    'action': ShopMainPageRoute
  },
  {
    'title': 'Мастерская',
    'descriptions': 'Ремонт бытовой техники',
    'action': ShopMainPageRoute
  },
  {
    'title': 'Интернет заказы',
    'descriptions': 'Служит для продажи (выдачи) интернет заказов',
    'action': ShopMainPageRoute
  }
];
