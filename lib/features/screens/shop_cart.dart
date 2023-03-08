import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grpc_server/bloc/cart/cart_bloc.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(builder: (context, state) {
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
              'Корзина',
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
