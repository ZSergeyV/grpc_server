import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grpc_server/bloc/cart/cart_bloc.dart';
import 'package:grpc_server/bloc/products/products_bloc.dart';
import 'package:grpc_server/bloc/settings/settings_bloc.dart';
import 'package:grpc_server/core/model/products.dart';
import 'package:grpc_server/features/screens/screens.dart';

class ListProducts extends StatefulWidget {
  final Orientation orientation;
  const ListProducts({super.key, required this.orientation});

  @override
  State<ListProducts> createState() => _ListProductsState();
}

class _ListProductsState extends State<ListProducts> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    final _bloc = context.read<ProductsBloc>();
    if (_isBottom) {
      final int idCategory = _bloc.state.products[0].idCategory;
      _bloc.add(ProductsFetched(idCategory, _bloc.state.products.length));
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= maxScroll;
  }

  @override
  Widget build(BuildContext context) {
    //final ProductsState stateBlocProduct = context.read<ProductsBloc>().state;
    return BlocBuilder<ProductsBloc, ProductsState>(builder: (context, state) {
      return Container(
        width: MediaQuery.of(context).size.width *
            (widget.orientation == Orientation.portrait ? 0.98 : 0.7),
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFFC9C9C9),
        ),
        child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
            child: Builder(builder: (context) {
              switch (state.status) {
                case ProductsStatus.failure:
                  return const Center(
                      child: Text('Ошибка при получении списка товаров'));
                case ProductsStatus.success:
                  if (state.products.isEmpty) {
                    return const Center(
                        child: Text('Нет данных для отображения'));
                  }
                  return ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return index >= state.products.length
                          ? const BottomLoader()
                          : ProductListItem(context, state.products[index]);
                    },
                    itemCount: state.hasReachedMax
                        ? state.products.length
                        : state.products.length + 1,
                    controller:
                        _scrollController, //ProductListItem(product: state.products[index])
                  );
                case ProductsStatus.initial:
                  return const Center(child: CircularProgressIndicator());
              }
            })),
      ); //container
    }); //swich
  }
}

Widget ProductListItem(BuildContext context, Product product) {
  final thumb = product.thumb;
  final SettingState _settings = context.watch<SettingBloc>().state;
  final _cartBloc = context.read<CartBloc>();

  String SERVER_ADRESS = _settings.settings['SERVER_ADRESS'];
  return Padding(
    padding: const EdgeInsets.all(2.0),
    child: Material(
      elevation: 2,
      child: ListTile(
        onTap: () => Navigator.pushNamed(context, ProductItemPageRoute,
            arguments: product),
        onLongPress: () => _cartBloc.add(AddProduct(product)),
        leading: thumb != ''
            ? Image.network(
                'http://$SERVER_ADRESS/static/images/thumbnail/$thumb')
            : Image.asset('assets/images/no-image.png'),
        title: Row(
          children: [
            Expanded(
              flex: 8,
              child: Text(
                product.name,
                maxLines: 5,
                softWrap: true,
                style: const TextStyle(fontSize: 15),
              ),
            ),
            Expanded(
              child: Text(
                textAlign: TextAlign.center,
                '${product.price.toStringAsFixed(0)} р.',
                maxLines: 2,
                softWrap: true,
                style: const TextStyle(fontSize: 15),
              ),
            ),
            Expanded(
              child: Text(
                textAlign: TextAlign.center,
                product.quantityStore.toString(),
                maxLines: 2,
                softWrap: true,
                style: const TextStyle(fontSize: 15),
              ),
            ),
            Expanded(
              child: Text(
                textAlign: TextAlign.center,
                product.storageCell +
                    (product.storageCellStock != ''
                        ? '\n (${product.storageCellStock})'
                        : ''),
                maxLines: 2,
                softWrap: true,
                style: const TextStyle(fontSize: 15),
              ),
            ),
            // Expanded(
            //   child: SvgPicture.asset(
            //     'assets/images/add-to-cart-svgrepo-com.svg',
            //     width: MediaQuery.of(context).size.width * 0.025,
            //     fit: BoxFit.contain,
            //     color: Colors.green[800],
            //   ),
            // ),
          ],
        ),
        trailing: GestureDetector(
          onTap: () => _cartBloc.add(AddProduct(product)),
          child: SvgPicture.asset(
            'assets/images/add-to-cart-svgrepo-com.svg',
            width: MediaQuery.of(context).size.width * 0.025,
            fit: BoxFit.contain,
            color: Colors.green[800],
          ),
        ),
        //isThreeLine: true,
        minVerticalPadding: 10.0,
        //dense: true,
      ),
    ),
  );
}

class BottomLoader extends StatelessWidget {
  const BottomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(strokeWidth: 1.5),
      ),
    );
  }
}
