import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grpc_server/bloc/cart/cart_bloc.dart';
import 'package:grpc_server/config/config.dart';
import 'package:grpc_server/core/model/cart.dart';

class CartPage extends StatelessWidget {
  const CartPage({required this.blocContext, super.key});

  final BuildContext blocContext;

  @override
  Widget build(BuildContext context) {
    final cartBloc = blocContext.watch<CartBloc>();
    return BlocProvider<CartBloc>(
        create: (blocContext) => cartBloc,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Корзина',
              style: TextStyle(fontSize: 24),
            ),
            elevation: 3,
            actions: [
              IconButton(
                  onPressed: () => cartBloc.add(ClearProduct()),
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Color(0xFFE83333),
                    size: 30,
                  ))
            ],
          ),
          body: BlocBuilder<CartBloc, CartState>(builder: (context, state) {
            return SafeArea(
              child: Column(
                children: [
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Builder(builder: (blocContext) {
                            switch (cartBloc.state.status) {
                              case CartStatus.initial:
                                return ListView.builder(
                                  itemBuilder:
                                      (BuildContext blocContext, int index) {
                                    return Text(cartBloc
                                        .state.items[index].product.name);
                                  },
                                  itemCount: cartBloc.state.items.length,
                                );
                              default:
                                return const SizedBox();
                            }
                          }))),
                  Container(
                    height: 60,
                    color: Colors.red,
                  )
                ],
              ),
            );
          }),
        ));
    // });
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
                                  return CartProductItem(state.items[index]);
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
                            case CartStatus.clear:
                              // TODO: Handle this case.
                              break;
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
                            color: Colors.black12,
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
    });
  }
}

class CartTopWidget extends StatelessWidget {
  const CartTopWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final _cartBloc = context.read<CartBloc>();

    Future<void> _showDialogClearCart() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            // <-- SEE HERE
            title: const Text('Очистка корзины'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('Вы уверены что хотите очистить корзину?'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Нет'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text(
                  'Да',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  _cartBloc.add(ClearProduct());
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

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
              'Корзина',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
              _showDialogClearCart();
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

Widget CartProductItem(CartItem item) {
  //const TextStyle styleTextPrice = TextStyle(fontWeight: FontWeight.w600);

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
                  Expanded(
                      child: Text(
                    item.product.name,
                    maxLines: 5,
                    overflow: TextOverflow.clip,
                    style: PRODUCT_TEXT_STYLE,
                  )),
                ],
              ),
              const Divider(
                height: 15.0,
              ),
              Row(
                children: [
                  Expanded(
                      child: Text(
                    'Цена: ${item.product.price.toString()} р.',
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
            ],
          ),
        )),
  );
}
