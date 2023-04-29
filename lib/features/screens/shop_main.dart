import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grpc_server/bloc/products/products_bloc.dart';
import 'package:grpc_server/bloc/categories/categories_bloc.dart';
import 'package:grpc_server/features/screens/screens.dart';
import 'package:grpc_server/features/widgets/shop_widgets.dart';
import 'package:grpc_server/resources/api_repository.dart';
// import 'package:grpc_server/resources/local_store.dart';
// import 'package:http/http.dart' as http;

class MainShopPage extends StatelessWidget {
  const MainShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final LocalStoreSettings localStore = LocalStoreSettings();
    final DataRepository dataRepository = DataRepository();

    return Scaffold(
        backgroundColor: const Color(0xFFC9C9C9),
        drawer: const LeftMenuShop(),
        body: MultiBlocProvider(
            providers: [
              BlocProvider<CategoriesBloc>(
                  lazy: false,
                  create: (BuildContext context) =>
                      CategoriesBloc(repository: dataRepository)
                        ..add(CategoriesFetched())),
              BlocProvider<ProductsBloc>(
                  lazy: false,
                  create: (_) => ProductsBloc(repository: dataRepository)
                    ..add(ProductsFetched(
                        ModalRoute.of(context)!.settings.arguments as int, 0))),
            ],
            child: OrientationBuilder(
                builder: (context, orientation) => SafeArea(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                8, 0, 0, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      (orientation == Orientation.portrait
                                          ? 0.99
                                          : 0.7),
                                  height: 60,
                                  child: TopMenuShop(orientation: orientation),
                                ),
                                Expanded(
                                  child: ListProducts(orientation: orientation),
                                ),
                              ],
                            ),
                          ),
                          orientation == Orientation.portrait
                              ? const SizedBox()
                              : const Cart(),
                        ],
                      ),
                    ))));
  }
}
