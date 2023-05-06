import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grpc_server/bloc/cart/cart_bloc.dart';
import 'package:grpc_server/bloc/products/products_bloc.dart';
import 'package:badges/badges.dart' as badges;
import 'package:grpc_server/config/config.dart';
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
  late ProductsBloc _bloc;

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
  var _cartBloc = context.watch<CartBloc>();
  final itemInCart = _cartBloc.productInCart(product);
  return Padding(
    padding: const EdgeInsets.only(bottom: 5),
    child: Material(
      elevation: 0,
      child: ListTile(
        onTap: () => Navigator.pushNamed(context, ProductItemPageRoute,
            arguments: product),
        onLongPress: () => _cartBloc.add(AddProduct(product)),
        leading: Column(
          children: [
            Expanded(
              child: thumb != ''
                  ? Image.network(
                      product.thumb,
                      width: 60,
                    )
                  : Image.asset('assets/images/no-image.png'),
            ),
          ],
        ),

        title: Row(
          children: [
            Expanded(
              flex: 5,
              child: Text(
                product.name,
                maxLines: 5,
                softWrap: true,
                style: PRODUCT_TEXT_STYLE,
              ),
            ),
            Expanded(
              child: Text(
                textAlign: TextAlign.center,
                '${product.price.toStringAsFixed(0)} р.',
                maxLines: 2,
                softWrap: true,
                style: PRODUCT_TEXT_STYLE,
              ),
            ),
            Expanded(
              child: Text(
                textAlign: TextAlign.center,
                product.quantityStore.toString(),
                maxLines: 2,
                softWrap: true,
                style: PRODUCT_TEXT_STYLE,
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    product.storageCell +
                        (product.storageCellStock != ''
                            ? '\n(${product.storageCellStock})'
                            : ''),
                    maxLines: 2,
                    softWrap: true,
                    style: PRODUCT_TEXT_STYLE,
                  ),
                ],
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Expanded(
              // child:
              badges.Badge(
                  ignorePointer: false,
                  showBadge: itemInCart['isCart'],
                  badgeAnimation: const badges.BadgeAnimation.rotation(),
                  badgeStyle: const badges.BadgeStyle(
                      padding: EdgeInsets.all(8), elevation: 2),
                  badgeContent: Text(
                    '${itemInCart['isCart'] ? itemInCart['count'] : 0}',
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  child: SvgPicture.asset(
                    'assets/images/add-to-cart-svgrepo-com.svg',
                    width: 42,
                    fit: BoxFit.contain,
                    color: const Color.fromARGB(123, 15, 110, 15),
                  )),
              // ),
            ],
          ),
        ),
        //isThreeLine: true,
        minVerticalPadding: 8.0,
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
