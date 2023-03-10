import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grpc_server/bloc/cart/cart_bloc.dart';
import 'package:grpc_server/bloc/categories/categories_bloc.dart';
import 'package:grpc_server/bloc/products/products_bloc.dart';
import 'package:grpc_server/bloc/settings/settings_bloc.dart';
import 'package:grpc_server/features/screens/screens.dart';
import 'package:grpc_server/features/screens/shop_cart.dart';
import 'package:grpc_server/features/widgets/shop_widgets.dart';
import 'package:grpc_server/resources/local_store.dart';
import 'package:http/http.dart' as http;

class MainShopPage extends StatelessWidget {
  const MainShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isCategory =
        ModalRoute.of(context)!.settings.name == ShopMainPageRoute
            ? true
            : false;
    final LocalStoreSettings localStore = LocalStoreSettings();

    return Scaffold(
        backgroundColor: const Color(0xFFC9C9C9),
        drawer: const LeftMenuShop(),
        body: MultiBlocProvider(
          providers: [
            BlocProvider<SettingBloc>(
                lazy: false,
                create: (BuildContext context) =>
                    SettingBloc(store: localStore)..add(ReadSettingsEvent())),
            BlocProvider<CartBloc>(
                lazy: false, create: (BuildContext context) => CartBloc()),
            BlocProvider<CategoriesBloc>(
                create: (BuildContext context) =>
                    CategoriesBloc(store: localStore, httpClient: http.Client())
                      ..add(CategoriesFetched())),
            BlocProvider<ProductsBloc>(
                create: (_) => ProductsBloc(
                    store: localStore, httpClient: http.Client())
                  ..add(ProductsFetched(
                      !isCategory
                          ? ModalRoute.of(context)!.settings.arguments as int
                          : -1,
                      0))),
          ],
          child: OrientationBuilder(
              builder: (context, orientation) => SafeArea(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width *
                                    (orientation == Orientation.portrait
                                        ? 0.99
                                        : 0.7),
                                height: 60,
                                child: TopMenuShop(isCategory: isCategory),
                              ),
                              Expanded(
                                child: isCategory
                                    ? ListCategories(orientation: orientation)
                                    : ListProducts(orientation: orientation),
                              ),
                            ],
                          ),
                        ),
                        orientation == Orientation.portrait
                            ? const SizedBox()
                            : const Cart(),
                      ],
                    ),
                  )),
        ));
  }
}
