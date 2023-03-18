import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grpc_server/bloc/cart/cart_bloc.dart';
import 'package:grpc_server/features/screens/screens.dart';
import 'package:badges/badges.dart' as badges;

class TopMenuShop extends StatelessWidget {
  const TopMenuShop({super.key, required this.orientation});
  final Orientation orientation;

  @override
  Widget build(BuildContext context) {
    const dividerIcon = SizedBox(width: 16);
    final _cartBloc = context.watch<CartBloc>();

    return Row(
      mainAxisSize: MainAxisSize.max,
      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 60,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.menu,
                  size: 32,
                ),
                onPressed: () async {
                  Scaffold.of(context).openDrawer();
                },
              ),
              // const Padding(
              //   padding: EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
              //   child: Text(
              //     'Товары',
              //     textAlign: TextAlign.center,
              //     style: TextStyle(
              //         fontSize: 18.0,
              //         fontWeight: FontWeight.w800,
              //         fontFamily: 'Roboto'),
              //     maxLines: 1,
              //   ),
              // ),
            ],
          ),
        ),
        //SizedBox(
        // height: 60,
        //width: double.infinity,
        // child:
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.search_outlined,
                    size: 34,
                  ),
                  onPressed: () {
                    showSearch(
                        context: context,
                        delegate: AppSearchDelegate(),
                        useRootNavigator: true);
                  },
                ),
                //dividerIcon,
                IconButton(
                  icon: const Icon(
                    Icons.view_module,
                    size: 34,
                  ),
                  onPressed: () {
                    print('IconButton pressed ...');
                  },
                ),
                //dividerIcon,
                // IconButton(
                //   icon: const Icon(
                //     Icons.view_list_rounded,
                //     size: 30,
                //   ),
                //   onPressed: () {
                //     print('IconButton pressed ...');
                //   },
                // ),
                IconButton(
                  icon: const Icon(
                    Icons.favorite_border,
                    size: 34,
                  ),
                  onPressed: () {
                    print('IconButton pressed ...');
                  },
                ),
                orientation == Orientation.portrait
                    ? dividerIcon
                    : const SizedBox(),
                InkWell(
                  onTap: () => Navigator.pushNamed(context, CartPageRoute,
                      arguments: context),
                  child: orientation == Orientation.portrait
                      ? badges.Badge(
                          // onTap: () =>
                          //     Navigator.pushNamed(context, CartPageRoute),
                          position:
                              badges.BadgePosition.topEnd(top: -15, end: -10),
                          showBadge: true,
                          ignorePointer: false,
                          badgeStyle: const badges.BadgeStyle(
                              padding: EdgeInsets.all(10)),
                          badgeContent: Text(
                            '${_cartBloc.state.totalCount}',
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white),
                          ),
                          //padding: EdgeInsetsGeometry.lerp(a, b, t),
                          child: SvgPicture.asset(
                            'assets/images/2703080_cart_basket_ecommerce_shop_icon.svg',
                            fit: BoxFit.contain,
                            height: 42,
                            width: 42,
                            color: const Color.fromARGB(248, 78, 78, 78),
                          ),
                        )
                      : const SizedBox(),
                ),
                // )
              ],
            ),
          ),
        ),
        //),
      ],
    );
  }
}

class AppSearchDelegate extends SearchDelegate {
  @override
  String? get searchFieldLabel => 'Поиск';

  @override
  TextInputType? get keyboardType => TextInputType.text;

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              if (query.isEmpty) {
                close(context, null);
              } else {
                query = '';
              }
            }),
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null));

  @override
  Widget buildResults(BuildContext context) {
    return const Text('data');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // return BlocBuilder<ProductsBloc, ProductsState>(builder: (context, state) {
    List<String> suggestions = ['12323', '45654', '798978'];

    return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (contex, index) {
          final item = suggestions[index];
          return ListTile(
            title: Text(item),
            onTap: () => query = item,
          );
        });
    // });
  }
}

class LeftMenuShop extends StatelessWidget {
  const LeftMenuShop({super.key});

  @override
  Widget build(BuildContext context) {
    const TextStyle menuTextStyle =
        TextStyle(fontSize: 20, fontWeight: FontWeight.w400);

    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: ListView(children: [
              DrawerHeader(
                padding: const EdgeInsets.all(0),
                decoration: const BoxDecoration(
                    //color: Color.fromARGB(255, 180, 180, 180),
                    ),
                child: Image.asset('assets/images/drawer_image.png',
                    fit: BoxFit.cover),
              ),
              ListTile(
                leading: const Icon(
                  Icons.point_of_sale,
                  size: 32,
                ),
                title: const Text('Касса', style: menuTextStyle),
                onTap: () {},
                minVerticalPadding: 15,
              ),
              ListTile(
                  leading: const Icon(
                    Icons.shopping_bag,
                    size: 32,
                  ),
                  title: const Text('Продажи', style: menuTextStyle),
                  onTap: () {},
                  minVerticalPadding: 15),
              ListTile(
                  leading: const Icon(
                    Icons.language,
                    size: 32,
                  ),
                  title: const Text('Интернет заказы', style: menuTextStyle),
                  onTap: () {},
                  minVerticalPadding: 15),
              ListTile(
                  leading: const Icon(
                    Icons.construction,
                    size: 32,
                  ),
                  title: const Text('Мастерская', style: menuTextStyle),
                  onTap: () {},
                  minVerticalPadding: 15),
              ListTile(
                  leading: const Icon(
                    Icons.settings,
                    size: 32,
                  ),
                  title: const Text('Настройки', style: menuTextStyle),
                  onTap: () => Navigator.pushNamed(context, SettingsPageRoute),
                  minVerticalPadding: 15),
            ]),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.logout,
              size: 32,
            ),
            title: const Text('Выход', style: menuTextStyle),
            onTap: () => Navigator.pushNamed(context, HomePageRoute),
          ),
          const SizedBox(height: 8.0)
        ],
      ),
    );
  }
}
