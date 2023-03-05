import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_randomcolor/flutter_randomcolor.dart';
import 'package:grpc_server/bloc/categories/categories_bloc.dart';
import 'package:grpc_server/features/screens/screens.dart';

Options options = Options(format: Format.rgbArray, luminosity: Luminosity.dark);

class ListCategories extends StatelessWidget {
  final Orientation orientation;
  const ListCategories({super.key, required this.orientation});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc, CategoriesState>(
        builder: (context, state) {
      return SizedBox(
        width: MediaQuery.of(context).size.width *
            (orientation == Orientation.portrait ? 0.98 : 0.7),
        height: double.infinity,
        child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
            child: Builder(builder: (context) {
              switch (state.status) {
                case CategoriesStatus.failure:
                  return const Center(
                      child:
                          Text('Ошибка при получении списка категорий товара'));
                case CategoriesStatus.success:
                  return GridView.builder(
                    cacheExtent: 50,
                    padding: EdgeInsets.zero,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio: 0.7,
                    ),
                    primary: false,
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    itemCount: state.categories.length,
                    itemBuilder: (context, catIndex) {
                      final captionCount = RegExp(r'(\d*.наим.)')
                          .firstMatch(state.categories[catIndex].title)![0]
                          ?.trim();
                      final categoryTitle = state.categories[catIndex].title
                          .replaceAll('($captionCount)', '');
                      final productCount =
                          RegExp(r'\d*').firstMatch(captionCount!)![0];
                      return CategoryGridItem(
                          context,
                          state.categories[catIndex].id,
                          categoryTitle,
                          productCount!);
                    },
                  );
                case CategoriesStatus.initial:
                  return const Center(child: CircularProgressIndicator());
              }
            })),
      ); //container
    }); //swich
  }
}

Widget CategoryGridItem(
    BuildContext context, int id, String title, String count) {
  final colorRGB = RandomColor.getColor(options);
  return InkWell(
    onTap: () async {
      Navigator.pushNamed(context, ProductsPageRoute, arguments: id);
    },
    child: Card(
      //elevation: 5,
      color: Color.fromARGB(255, colorRGB[0], colorRGB[1], colorRGB[2]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title.toUpperCase(),
              softWrap: true,
              maxLines: 6,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 28.0),
                child: Divider(color: Color(0xFFECECEC)),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 16, 8),
                child: Text(
                  count,
                  textAlign: TextAlign.right,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
}
