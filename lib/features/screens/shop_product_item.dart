import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
// import 'package:grpc_server/bloc/settings/settings_bloc.dart';
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
