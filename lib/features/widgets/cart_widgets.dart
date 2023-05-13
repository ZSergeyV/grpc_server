import 'package:flutter/material.dart';
import 'package:grpc_server/core/utils.dart';

class Payment extends StatelessWidget {
  Payment({super.key});
  static const TextStyle stylePayCaption =
      TextStyle(fontSize: 26, color: Colors.black87);

  final PageController controller = PageController(viewportFraction: 0.82);

  // final Map<String, dynamic> payData = {
  //   'paymentType': null,
  //   'bayerType': null,
  //   'checkAmount': 0
  // };

  @override
  Widget build(BuildContext context) {
    double marginTopStack = 55;

    Widget pagePayBuyer(BuyerType buyerType) {
      String captionPage = buyerType == BuyerType.person
          ? 'Физическое лицо'
          : 'Юридическое лицо';
      String imageName =
          buyerType == BuyerType.person ? 'buyer.png' : 'legal-buyer.png';
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Stack(
            children: [
              Positioned(
                top: 8,
                left: MediaQuery.of(context).size.width / 3.7,
                child: Text(
                  captionPage,
                  style: const TextStyle(
                      fontSize: 30, color: Color.fromARGB(255, 104, 104, 104)),
                ),
              ),
              Positioned(
                right: 40,
                top: marginTopStack,
                height: 350,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          shape: ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          side: const BorderSide(
                            color: Color.fromARGB(255, 211, 211, 211),
                          ),
                        ),
                        child: const Icon(
                          Icons.money_rounded,
                          size: 165,
                          color: Color.fromARGB(255, 182, 141, 27),
                        )
                        //   Image.asset('assets/images/money.png',
                        //       width: 200, height: 150, fit: BoxFit.fitHeight),
                        ),
                    OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          shape: ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          side: const BorderSide(
                            color: Color.fromARGB(255, 211, 211, 211),
                          ),
                        ),
                        child: const Icon(
                          Icons.credit_card,
                          size: 165,
                          color: Color.fromARGB(255, 41, 43, 175),
                        )
                        //   Image.asset('assets/images/credit_card.png',
                        //       width: 200, height: 150, fit: BoxFit.cover),
                        ),
                  ],
                ),
              ),
              Positioned(
                left: 24,
                top: marginTopStack,
                height: 350,
                child:
                    Image.asset('assets/images/$imageName', fit: BoxFit.cover),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: [
        const SizedBox(
          height: 5.0,
        ),
        const Text(
          'Выберите тип покупателя и способ оплаты',
          style: TextStyle(fontSize: 32),
          textAlign: TextAlign.left,
        ),
        Expanded(
          child: PageView(
            controller: controller,
            physics: const AlwaysScrollableScrollPhysics(),
            children: <Widget>[
              pagePayBuyer(BuyerType.person),
              pagePayBuyer(BuyerType.juridicalPerson),
            ],
          ),
        ),
      ],
    );
  }
}


// Widget PageChoisePaymentType(BuildContext context) {
//   return Column()
// }
