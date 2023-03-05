import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:grpc_server/bloc/settings/settings_bloc.dart';
import 'package:grpc_server/core/model/products.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Product _product =
        ModalRoute.of(context)!.settings.arguments as Product;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 97, 97, 97),
          title: Text(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            _product.name,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        body: OrientationBuilder(
            builder: (context, orientation) => SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: orientation == Orientation.landscape
                        ? Row(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  flex: 1,
                                  child:
                                      ImageSliderProduct(code: _product.code)),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  children: [
                                    ProductInfo(context, _product),
                                  ],
                                ),
                              )
                            ],
                          )
                        : Column(
                            children: [
                              ImageSliderProduct(code: _product.code),
                              ProductInfo(context, _product)
                            ],
                          ),
                  ),
                )));
  }
}

class ImageSliderProduct extends StatelessWidget {
  ImageSliderProduct({super.key, required this.code});
  final int code;

  // final List<String> _imgList = [
  //   'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  //   'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  //   'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  //   'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  //   'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  //   'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  // ];

  List _imgProduct = [];

  Future<void> _getImages() async {
    final data = await _fetchProduct(code);
    _imgProduct = data['images'] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    _getImages();
    return CarouselSlider(
      options: CarouselOptions(),
      items: _imgProduct
          .map((item) => Container(
                margin: const EdgeInsets.only(left: 8, right: 8, top: 0),
                child: Center(child: Image.network(item, fit: BoxFit.cover)),
              ))
          .toList(),
    );
  }
}

Future<Map<String, dynamic>> _fetchProduct(int code) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String serverAdress = prefs.getString('SERVER_ADRESS') ?? '';
  //int limitProduct = prefs.getInt('LIMIT_PRODUCT') ?? 0;

  final response = await http.get(
    Uri.http(
      serverAdress,
      '/api/v1/product',
      <String, String>{
        'code': code.toString(),
      },
    ),
  );

  if (response.statusCode == 200) {
    final body = json.decode(response.body);
    return body;
  }
  throw Exception('Ошибка получения данных товара');
}

Widget ProductInfo(BuildContext context, Product product) {
  const TextStyle menuTextStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.w400);
  return Expanded(
    child: ListView(children: [
      ListTile(
        leading: const Text('Где:', style: menuTextStyle),
        title: Text(product.storageCell.toString(), style: menuTextStyle),
        onTap: () {},
        minVerticalPadding: 15,
      ),
      ListTile(
          leading: const Text('Запас', style: menuTextStyle),
          title:
              Text(product.storageCellStock.toString(), style: menuTextStyle),
          onTap: () {},
          minVerticalPadding: 15),
      ListTile(
          leading: const Text('Наличие', style: menuTextStyle),
          title: Text(product.quantityStore.toString(), style: menuTextStyle),
          onTap: () {},
          minVerticalPadding: 15),
      ListTile(
          leading: const Text('На ближнем складе', style: menuTextStyle),
          title: Text(product.quantityStock.toString(), style: menuTextStyle),
          onTap: () {},
          minVerticalPadding: 15),
      ListTile(
          leading: const Text('На дальнем складе', style: menuTextStyle),
          title: const Text('', style: menuTextStyle),
          trailing: InkWell(
            child: const Icon(Icons.edit),
            onTap: () => debugPrint('tap'),
          ),
          // onTap: () => Navigator.pushNamed(context, SettingsPageRoute),
          minVerticalPadding: 15),
    ]),
  );
}
