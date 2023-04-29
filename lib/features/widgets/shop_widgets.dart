import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grpc_server/bloc/cart/cart_bloc.dart';
import 'package:grpc_server/bloc/categories/categories_bloc.dart';
import 'package:grpc_server/features/screens/screens.dart';
import 'package:badges/badges.dart' as badges;
import 'package:grpc_server/resources/api_repository.dart';

class TopMenuShop extends StatelessWidget {
  const TopMenuShop({super.key, required this.orientation});
  final Orientation orientation;

  @override
  Widget build(BuildContext context) {
    const dividerIcon = SizedBox(width: 16);

    return Row(
      mainAxisSize: MainAxisSize.max,
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
                  onTap: () => Navigator.pushNamed(context, CartPageRoute),
                  // arguments: context),
                  child: orientation == Orientation.portrait
                      ? badges.Badge(
                          badgeAnimation: const badges.BadgeAnimation.scale(),
                          position:
                              badges.BadgePosition.topEnd(top: -15, end: -10),
                          showBadge:
                              context.watch<CartBloc>().state.totalCount == 0
                                  ? false
                                  : true,
                          ignorePointer: false,
                          badgeStyle: const badges.BadgeStyle(
                              padding: EdgeInsets.all(10)),
                          badgeContent: Text(
                            '${context.watch<CartBloc>().state.totalCount}',
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white),
                          ),
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

    final DataRepository dataRepository = DataRepository();

    return BlocBuilder<CategoriesBloc, CategoriesState>(
        bloc: CategoriesBloc(repository: dataRepository)
          ..add(CategoriesFetched()),
        builder: (context, state) {
          final screenWidth = MediaQuery.of(context).size.width;
          bool orientation =
              (MediaQuery.of(context).orientation == Orientation.portrait);
          return Drawer(
              width: (orientation ? screenWidth / 1.5 : screenWidth / 3),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    DrawerHeader(
                      padding: const EdgeInsets.all(0),
                      decoration: const BoxDecoration(
                          //color: Color.fromARGB(255, 180, 180, 180),
                          ),
                      child: Image.asset('assets/images/drawer_image.png',
                          fit: BoxFit.cover),
                    ),
                    if (state.status == CategoriesStatus.success)
                      Expanded(
                        child: ListView.builder(
                            itemCount: state.categories.length,
                            itemBuilder: (contex, index) {
                              final captionCount = RegExp(r'(\d*.наим.)')
                                  .firstMatch(state.categories[index].title)![0]
                                  ?.trim();
                              final String categoryTitle = state
                                  .categories[index].title
                                  .replaceAll('($captionCount)', '')
                                  .trim();
                              // final productCount =
                              //     RegExp(r'\d*').firstMatch(captionCount!)![0];
                              return ListTile(
                                minLeadingWidth: 0,
                                minVerticalPadding: 10,
                                leading: const Icon(Icons.folder, size: 36),
                                title:
                                    Text(categoryTitle, style: menuTextStyle),
                                //subtitle: Text(productCount.toString()),
                                onTap: () {
                                  Scaffold.of(context).closeDrawer();
                                  Navigator.pop(context, true);
                                  Navigator.pushNamed(
                                      context, ShopMainPageRoute,
                                      arguments: state.categories[index].id);
                                },
                              );
                            }),
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
                  ]));
        });
  }
}
