import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grpc_server/bloc/cart/cart_bloc.dart';
import 'package:grpc_server/core/model/products.dart';
import 'package:grpc_server/resources/api_provider.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Product _product =
        ModalRoute.of(context)!.settings.arguments as Product;

    final DataProvider provider = DataProvider();

    var _cartBloc = context.watch<CartBloc>();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 97, 97, 97),
          title: const Text(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            'Назад',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: FutureBuilder<Map<String, dynamic>>(
            future: provider.fetchProductInfo(_product.code),
            builder:
                (context, AsyncSnapshot<Map<String, dynamic>> productInfo) {
              if (productInfo.hasData) {
                final List listImages = productInfo.data!['images'];
                productInfo.data!
                    .addAll({'product': _product, 'bloc': _cartBloc});
                return OrientationBuilder(
                    builder: (context, orientation) => SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: orientation == Orientation.landscape
                                ? Row(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child: ImageSliderProduct(
                                              paths: listImages)),
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          children: [
                                            ProductInfo(
                                                context, productInfo.data!),
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                : Column(
                                    children: [
                                      ImageSliderProduct(paths: listImages),
                                      ProductInfo(context, productInfo.data!)
                                    ],
                                  ),
                          ),
                        ));
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }
}

class ImageSliderProduct extends StatelessWidget {
  const ImageSliderProduct({super.key, required this.paths});
  final List paths;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(enableInfiniteScroll: false),
      items: paths
          .map((path) => Container(
                margin: const EdgeInsets.only(left: 8, right: 8, top: 0),
                child: Center(
                  child: CachedNetworkImage(
                    imageUrl: path,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Text('Не удалось загрузить изображение'),
                  ),
                ),
              ))
          .toList(),
    );
  }
}

Widget ProductInfo(BuildContext context, Map product) {
  const TextStyle menuTextStyle =
      TextStyle(fontSize: 22, fontWeight: FontWeight.w400);
  const double minInterval = 0;
  // final LocalStoreSettings localStore = LocalStoreSettings();
  final CartBloc cartBloc = product['bloc'];
  final productInCart = cartBloc.productInCart(product['product']);
  return Expanded(
    child: ListView(children: [
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(product['name'],
                  style: menuTextStyle.copyWith(fontSize: 26)),
              const SizedBox(height: 10),
              Text('Цена: ${product['price']} р.',
                  style: menuTextStyle.copyWith(fontSize: 26)),
            ]),
      ),
      const SizedBox(height: 20),
      ListTile(
          leading: const Text('Наличие:', style: menuTextStyle),
          title:
              Text(product['quantity_store'].toString(), style: menuTextStyle),
          trailing: TextButton(
            child: Text('Редактировать',
                style: menuTextStyle.copyWith(fontSize: 22)),
            onPressed: () {},
          ),
          minVerticalPadding: minInterval),
      ListTile(
        leading: const Text('Где:', style: menuTextStyle),
        title: Text(product['storage_cell'].toString(), style: menuTextStyle),
        trailing: TextButton(
          child: Text('Редактировать',
              style: menuTextStyle.copyWith(fontSize: 22)),
          onPressed: () {},
        ),
        minVerticalPadding: minInterval,
      ),
      ListTile(
          leading: const Text('Запас', style: menuTextStyle),
          title: Text(product['storage_cell_stock'].toString(),
              style: menuTextStyle),
          trailing: TextButton(
            child: Text('Редактировать',
                style: menuTextStyle.copyWith(fontSize: 22)),
            onPressed: () {},
          ),
          minVerticalPadding: minInterval),
      ListTile(
          leading: const Text('На ближнем складе', style: menuTextStyle),
          title:
              Text(product['quantity_stock'].toString(), style: menuTextStyle),
          minVerticalPadding: 15),
      ListTile(
          leading: const Text('На дальнем складе', style: menuTextStyle),
          title: Text(product['provider'] ?? '', style: menuTextStyle),
          minVerticalPadding: minInterval),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FilledButton(
                onPressed: () => cartBloc.add(AddProduct(product['product'])),
                style: FilledButton.styleFrom(
                    backgroundColor: Colors.amber[900],
                    shape: const RoundedRectangleBorder()),
                child: Text(
                    'В корзину ${productInCart['isCart'] ? '( ${productInCart['count']} )' : ''}',
                    style: menuTextStyle.copyWith(fontSize: 24)))
          ],
        ),
      )
    ]),
  );
}



// Future<Image> _fetchImage(String path) async {
//   // SharedPreferences prefs = await SharedPreferences.getInstance();
//   String serverAdress = '192.168.1.12:5000';
//   //prefs.getString('SERVER_ADRESS') ?? '';
//   //int limitProduct = prefs.getInt('LIMIT_PRODUCT') ?? 0;

//   final response = await http.get(
//     Uri.http(
//       serverAdress,
//       '/api/v1/get-image',
//       <String, String>{
//         'path': path,
//       },
//     ),
//   );

//   if (response.statusCode == 200) {
//     return Image.memory(response.bodyBytes);
//   }
//   throw Exception('Ошибка получения данных товара');
// }
