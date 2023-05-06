import 'package:cart_stepper/cart_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grpc_server/bloc/cart/cart_bloc.dart';
import 'package:grpc_server/config/config.dart';
import 'package:grpc_server/core/model/cart.dart';
import 'package:grpc_server/features/screens/screens.dart';
import 'package:grpc_server/features/widgets/cart_widgets.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(
          'Корзина',
          style: TextStyle(fontSize: 24),
        ),
        elevation: 3,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: IconButton(
                onPressed: () => _showDialogClearCart(context),
                icon: const Icon(
                  Icons.delete_outline,
                  color: Color(0xFFE83333),
                  size: 36,
                )),
          )
        ],
      ),
      body: BlocBuilder<CartBloc, CartState>(builder: (context, state) {
        double dividerWidth = MediaQuery.of(context).size.width / 2.2;

        return SafeArea(
            child: Column(
          children: [
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.only(
                        left: 12, right: 12, bottom: 0, top: 12),
                    child: Builder(builder: (context) {
                      switch (state.status) {
                        case CartStatus.initial:
                          return ListView.builder(
                            itemBuilder: (BuildContext context, int index) {
                              return Dismissible(
                                background: Container(
                                  color: const Color.fromARGB(255, 206, 35, 23),
                                ),
                                key: ValueKey<int>(
                                    state.items[index].product.code),
                                child: CartProductItem(
                                    state.items[index], true, context),
                                onDismissed: (direction) => context
                                    .read<CartBloc>()
                                    .add(DeleteProduct(state.items[index])),
                              );
                            },
                            itemCount: state.items.length,
                          );
                        case CartStatus.empty:
                          return const Center(
                              child: Text(
                            'Корзина пуста',
                            style: TextStyle(fontSize: 24),
                          ));
                        default:
                          return const SizedBox();
                      }
                    }))),
            Container(
                height: 86,
                // color: const Color.fromARGB(255, 5, 128, 46),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 5, 128, 46),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40.0),
                    topLeft: Radius.circular(40.0),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 18),
                      child: SizedBox(
                        child: Divider(
                          color: Colors.white,
                          height: 2.0,
                          thickness: 4,
                          indent: dividerWidth,
                          endIndent: dividerWidth,
                        ),
                      ),
                    ),
                    Row(
                      // mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Padding(
                        //   padding:
                        //       const EdgeInsetsDirectional.fromSTEB(32, 0, 0, 0),
                        //   child: Text(
                        //     'Оплатить: ${state.totalPrice.toInt() == state.totalPrice ? state.totalPrice.toInt() : state.totalPrice} р.',
                        //     style:
                        //         Theme.of(context).textTheme.bodyLarge?.copyWith(
                        //               color: Colors.white,
                        //               fontSize: 32,
                        //               fontWeight: FontWeight.w300,
                        //             ),
                        //   ),
                        // ),
                        TextButton(
                            onPressed: () {
                              showModalBottomSheet(
                                constraints:
                                    const BoxConstraints.expand(height: 600),
                                context: context,
                                elevation: 10,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(40),
                                  ),
                                ),
                                builder: (BuildContext context) {
                                  return Payment();
                                },
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 0),
                              child: Text(
                                'Оплатить: ${state.totalPrice.toInt() == state.totalPrice ? state.totalPrice.toInt() : state.totalPrice} р.',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      color: Colors.white,
                                      fontSize: 32,
                                      fontWeight: FontWeight.w300,
                                    ),
                              ),

                              // Text(
                              //   'ОПЛАТИТЬ',
                              //   style: TextStyle(
                              //       color: Colors.white, fontSize: 28),
                              // ),
                            ))
                      ],
                    ),
                  ],
                )),
          ],
        ));
      }),
      // bottomSheet: Container(
      //   height: 100,
      //   color: Colors.cyan,
      // ),
    );
  }
}

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(builder: (context, state) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CartTopWidget(),
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
                        Builder(builder: (context) {
                          switch (state.status) {
                            case CartStatus.initial:
                              return ListView.builder(
                                itemBuilder: (BuildContext context, int index) {
                                  return Dismissible(
                                    background: Container(
                                      color: Colors.red,
                                    ),
                                    key: ValueKey<int>(
                                        state.items[index].product.code),
                                    child: CartProductItem(state.items[index]),
                                    onDismissed: (direction) => context
                                        .read<CartBloc>()
                                        .add(DeleteProduct(state.items[index])),
                                  );
                                },
                                itemCount: state.items.length,
                                //ProductListItem(product: state.products[index])
                              );
                            case CartStatus.success:
                              // TODO: Handle this case.
                              break;
                            case CartStatus.error:
                              // TODO: Handle this case.
                              break;
                            case CartStatus.pay:
                              // TODO: Handle this case.
                              break;
                            case CartStatus.empty:
                              return const Center(
                                  child: Text(
                                'Корзина пуста',
                                style: TextStyle(fontSize: 24),
                              ));
                            case CartStatus.cancel:
                              // TODO: Handle this case.
                              break;
                          }
                          return const SizedBox();
                        }),
                        Align(
                          alignment: const AlignmentDirectional(0, 0),
                          child: SvgPicture.asset(
                            'assets/images/2703080_cart_basket_ecommerce_shop_icon.svg',
                            width: MediaQuery.of(context).size.width * 0.1,
                            fit: BoxFit.cover,
                            color: const Color.fromARGB(12, 0, 0, 0),
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
              onTap: () => Navigator.pushNamed(context, CartPageRoute),
              child: const SaleTotalWidget(),
            ),
          ),
        ],
      );
    });
  }
}

class CartTopWidget extends StatelessWidget {
  const CartTopWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final _cartBloc = context.read<CartBloc>();

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
              ))),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
            child: Text(
              'Корзина',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.delete_outline,
              color: Color(0xFFE83333),
              size: 30,
            ),
            onPressed: () {
              _showDialogClearCart(context);
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
    final _cartBloc = context.watch<CartBloc>();
    return Container(
      width: MediaQuery.of(context).size.width * 0.29, //width?.toDouble(),
      height: 65,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 5, 128, 46), //Color(0xFFF90C0C),
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
                    '${_cartBloc.state.totalPrice} р.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w300,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: non_constant_identifier_names
Widget CartProductItem(CartItem item,
    [bool extendet = false, BuildContext? context]) {
  const noWidget = SizedBox();
  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: Material(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 90,
                    height: 90,
                    child: item.product.thumb != ''
                        ? Image.network(
                            item.product.thumb,
                            width: 90,
                          )
                        : Image.asset('assets/images/no-image.png'),
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.product.name,
                          maxLines: 5,
                          overflow: TextOverflow.clip,
                          style: PRODUCT_TEXT_STYLE.copyWith(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        extendet
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // const SizedBox(
                                  //   height: 10,
                                  // ),
                                  Text(
                                    'Цена: ${item.product.price.toString()} р.   ',
                                    maxLines: 1,
                                    overflow: TextOverflow.clip,
                                    textAlign: TextAlign.left,
                                    style: CART_TEXT_STYLE,
                                  ),
                                  Text('Где: ${item.product.storageCell}   ',
                                      maxLines: 1,
                                      overflow: TextOverflow.clip,
                                      textAlign: TextAlign.left,
                                      style: CART_TEXT_STYLE),
                                  Text('Наличие: ${item.product.quantityStore}',
                                      maxLines: 1,
                                      overflow: TextOverflow.clip,
                                      textAlign: TextAlign.left,
                                      style: CART_TEXT_STYLE)
                                ],
                              )
                            : noWidget
                      ],
                    ),
                  )),
                  extendet
                      ? SizedBox(
                          width: 132,
                          height: 45,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: CartStepperInt(
                              size: 33,
                              value: item.count,
                              stepper: 1,
                              style: const CartStepperStyle(
                                  activeForegroundColor:
                                      Color.fromARGB(255, 255, 255, 255),
                                  radius: Radius.circular(25)),
                              didChangeCount: (int value) {
                                if (value <= 0) {
                                  _showDialogDeleteProduct(context!, item);
                                } else {
                                  context!
                                      .read<CartBloc>()
                                      .add(ChangeCountProduct(item, value));
                                }
                              },
                            ),
                          ))
                      : noWidget,
                ],
              ),
              !extendet
                  ? const Divider(
                      height: 15.0,
                    )
                  : noWidget,
              !extendet
                  ? Row(
                      children: [
                        Expanded(
                            child: Text(
                          'Цена: ${item.product.price.toInt()} р.',
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                          textAlign: TextAlign.left,
                          style: CART_TEXT_STYLE,
                        )),
                        Expanded(
                            child: Text(
                          '${item.count} шт.',
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                          textAlign: TextAlign.center,
                          style: CART_TEXT_STYLE,
                        )),
                        Expanded(
                            child: Text(
                          '${item.price} р.',
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                          textAlign: TextAlign.right,
                          style: CART_TEXT_STYLE,
                        )),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Text(
                            'Всего: ${item.price.toInt()} р.',
                            style: CART_TEXT_STYLE.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        )
                      ],
                    ),
            ],
          ),
        )),
  );
}

Future<void> _showDialogClearCart(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      ButtonStyle actionButtonStyle = ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))));
      return AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        // <-- SEE HERE
        title: const Text('Очистка корзины'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text(
                'Вы уверены что хотите очистить корзину?',
                style: TextStyle(fontSize: 24),
              ),
            ],
          ),
        ),
        actionsOverflowButtonSpacing: 10,
        actions: <Widget>[
          ElevatedButton(
            style: actionButtonStyle.copyWith(
                backgroundColor: MaterialStateProperty.all(Colors.red)),
            child: const Text('Нет'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            style: actionButtonStyle.copyWith(
                backgroundColor: MaterialStateProperty.all(Colors.blue)),
            child: const Text(
              'Да',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              context.read<CartBloc>().add(ClearProduct());
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<void> _showDialogDeleteProduct(
    BuildContext context, CartItem item) async {
  final _padding = MediaQuery.of(context).size.width / 4;
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      ButtonStyle actionButtonStyle = ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))));
      return AlertDialog(
        insetPadding: EdgeInsets.only(left: _padding, right: _padding),
        //MediaQuery.of(context).size.width / 4,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        // <-- SEE HERE
        title: const Text('Удаление товара из корзины'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                'Вы уверены что хотите удалить из корзины "${item.product.name}" ?',
                maxLines: 5,
                overflow: TextOverflow.clip,
                style: const TextStyle(fontSize: 24),
              ),
            ],
          ),
        ),
        actionsOverflowButtonSpacing: 10,
        actions: <Widget>[
          ElevatedButton(
            style: actionButtonStyle.copyWith(
                backgroundColor: MaterialStateProperty.all(Colors.red)),
            child: const Text('Нет'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            style: actionButtonStyle.copyWith(
                backgroundColor: MaterialStateProperty.all(Colors.blue)),
            child: const Text(
              'Да',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              context.read<CartBloc>().add(DeleteProduct(item));
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
