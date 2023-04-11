import 'package:flutter/material.dart';
import 'package:grpc_server/core/utils.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});
  static const TextStyle stylePayCaption = TextStyle(fontSize: 26);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  final PageController controller = PageController();
  final Map<String, dynamic> payData = {
    'paymentType': null,
    'bayerType': null,
    'checkAmount': 0
  };

  @override
  Widget build(BuildContext context) {
    // @override
    // void initState() {
    //   super.initState();
    // }

    void changePageOnPay(StepsPayment step, dynamic param) {
      switch (step) {
        case StepsPayment.choosPaymentMethod:
          payData['paymentType'] = param;
          break;
        case StepsPayment.choosTypeBuyer:
          payData['bayerType'] = param;
          break;
        default:
          break;
      }
      //controller.jumpTo(value)
      controller.nextPage(
          duration: const Duration(milliseconds: 100), curve: Curves.easeIn);
    }

    _pageChoisePaymentType() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 25, top: 15),
            child: Text(
              'Выберите способ оплаты',
              style: TextStyle(fontSize: 30),
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(height: 20),
          ListTile(
              onTap: () => changePageOnPay(
                  StepsPayment.choosPaymentMethod, CheckPaymentType.cash),
              style: ListTileStyle.list,
              leading: const Icon(
                Icons.money_rounded,
                size: 70,
              ),
              title: const Text('Наличными', style: Payment.stylePayCaption),
              minVerticalPadding: 30),
          ListTile(
              onTap: () => changePageOnPay(
                  StepsPayment.choosPaymentMethod, CheckPaymentType.card),
              leading: const Icon(
                Icons.credit_card_rounded,
                size: 70,
              ),
              title: const Text('Банковской картой',
                  style: Payment.stylePayCaption),
              minVerticalPadding: 30)
        ],
      );
    }

    _pageChoiseBayerType() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 25, top: 15),
            child: Text(
              'Выберите тип покупателя',
              style: TextStyle(fontSize: 30),
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(height: 20),
          ListTile(
              onTap: () => changePageOnPay(
                  StepsPayment.choosTypeBuyer, BuyerType.person),
              style: ListTileStyle.list,
              leading: const Icon(
                Icons.person,
                size: 70,
              ),
              title: const Text('Частное лицо', style: Payment.stylePayCaption),
              minVerticalPadding: 30),
          ListTile(
              onTap: () => changePageOnPay(
                  StepsPayment.choosTypeBuyer, BuyerType.juridicalPerson),
              leading: const Icon(
                Icons.business,
                size: 70,
              ),
              title: const Text('Юридическое лицо',
                  style: Payment.stylePayCaption),
              minVerticalPadding: 30)
        ],
      );
    }

    return PageView(
      controller: controller,
      physics: const NeverScrollableScrollPhysics(),
      children: <Widget>[
        _pageChoiseBayerType(),
        _pageChoisePaymentType(),

        // Container(
        //   color: Colors.deepPurple,
        // ),
      ],
    );
  }
}

// Widget PageChoisePaymentType(BuildContext context) {
//   return Column()
// }
