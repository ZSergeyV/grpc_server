import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:grpc_server/bloc/products/products_bloc.dart';
import 'package:grpc_server/features/screens/screens.dart';

class TopMenuShop extends StatelessWidget {
  const TopMenuShop({super.key, required this.isCategory});
  final bool isCategory;

  @override
  Widget build(BuildContext context) {
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
                  size: 30,
                ),
                onPressed: () async {
                  Scaffold.of(context).openDrawer();
                },
              ),
              const Padding(
                padding: EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                child: Text(
                  'Товары',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'Roboto'),
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ),
        //SizedBox(
        // height: 60,
        //width: double.infinity,
        // child:
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.search_outlined,
                  size: 30,
                ),
                onPressed: () {
                  showSearch(
                      context: context,
                      delegate: AppSearchDelegate(),
                      useRootNavigator: true);
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.view_module,
                  size: 30,
                ),
                onPressed: () {
                  print('IconButton pressed ...');
                },
              ),
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
                  size: 30,
                ),
                onPressed: () {
                  print('IconButton pressed ...');
                },
              ),
            ],
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

class BasketTopWidget extends StatelessWidget {
  const BasketTopWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.29,
      height: 65,
      decoration: const BoxDecoration(
          color: Color(0xFFBCBCBC),
          border: Border(
              left: BorderSide(
                color: Color.fromARGB(255, 168, 168, 168),
                width: 1.0,
              ),
              bottom: BorderSide(
                color: Color.fromARGB(255, 143, 143, 143),
                width: 1.0,
              ))
          // color: FlutterFlowTheme.of(context).checkListProduct,
          ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
            child: Text(
              'Текущий чек',
              // style: FlutterFlowTheme.of(context).bodyText1.override(
              //       fontFamily: 'Poppins',
              //       color: FlutterFlowTheme.of(context).topMenuText,
              //       fontSize: 20,
              //       fontWeight: FontWeight.w300,
              //     ),
            ),
          ),
          IconButton(
            // borderColor: Colors.transparent,
            // borderRadius: 5,
            // borderWidth: 1,
            // buttonSize: 52,
            icon: const Icon(
              Icons.delete_outline,
              color: Color(0xFFE83333),
              size: 30,
            ),
            onPressed: () {
              print('IconButton pressed ...');
            },
          ),
        ],
      ),
    );
  }
}

class SaleTotalWidget extends StatelessWidget {
  const SaleTotalWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.29, //width?.toDouble(),
      height: 65,
      decoration: const BoxDecoration(
        color: Color(0xFFF90C0C),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
            child: Text(
              'ВСЕГО:',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white,
                    fontSize: 20,
                    letterSpacing: 5,
                    fontWeight: FontWeight.w300,
                  ),
            ),
          ),
          Container(
            height: 65,
            decoration: const BoxDecoration(),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                  child: Text(
                    '0.0 р.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w300,
                        ),
                  ),
                ),
                IconButton(
                  // borderColor: Colors.transparent,
                  // borderRadius: 0,
                  // borderWidth: 1,
                  // buttonSize: 52,
                  icon: const Icon(
                    Icons.keyboard_control_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {
                    print('IconButton pressed ...');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RightPanelCart extends StatelessWidget {
  const RightPanelCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BasketTopWidget(),
        Container(
          width: MediaQuery.of(context).size.width * 0.29,
          height: MediaQuery.of(context).size.height - 140,
          decoration: const BoxDecoration(
              color: Color(0xFFBCBCBC),
              border: Border(
                left: BorderSide(
                  color: Color.fromARGB(255, 168, 168, 168),
                  width: 1.0,
                ),
              )
              // color: FlutterFlowTheme.of(context).checkListProduct,
              ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Stack(
                    children: [
                      Align(
                        alignment: const AlignmentDirectional(0, 0),
                        child: SvgPicture.asset(
                          'assets/images/2703080_cart_basket_ecommerce_shop_icon.svg',
                          width: MediaQuery.of(context).size.width * 0.1,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () async {
              await showDialog(
                context: context,
                builder: (alertDialogContext) {
                  return AlertDialog(
                    title: const Text('test'),
                    content: const Text('message'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(alertDialogContext),
                        child: const Text('Ok'),
                      ),
                    ],
                  );
                },
              );
            },
            child: const SaleTotalWidget(),
          ),
        ),
      ],
    );
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
