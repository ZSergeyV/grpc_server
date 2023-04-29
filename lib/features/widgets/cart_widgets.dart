import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grpc_server/core/utils.dart';

class Payment extends StatelessWidget {
  Payment({super.key});
  static const TextStyle stylePayCaption =
      TextStyle(fontSize: 26, color: Colors.black87);

  final PageController controller = PageController();

  final Map<String, dynamic> payData = {
    'paymentType': null,
    'bayerType': null,
    'checkAmount': 0
  };

  @override
  Widget build(BuildContext context) {
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
      if (step == StepsPayment.back) {
        controller.previousPage(
            duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
      } else {
        controller.nextPage(
            duration: const Duration(milliseconds: 100), curve: Curves.easeIn);
      }
    }

    _pageChoisePaymentType() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25, top: 15, right: 25),
            child: Column(
              children: [
                const Text(
                  'Выберите способ оплаты',
                  style: TextStyle(fontSize: 30),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 20),
                OutlinedButton.icon(
                  onPressed: () => changePageOnPay(
                      StepsPayment.choosPaymentMethod, CheckPaymentType.cash),
                  icon: const Icon(
                    Icons.money_rounded,
                    size: 70,
                    color: Colors.black26,
                  ),
                  label: Row(
                    children: const [Text('Наличными', style: stylePayCaption)],
                  ),
                  style: OutlinedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)))),
                ),
                const SizedBox(height: 20),
                OutlinedButton.icon(
                  onPressed: () => changePageOnPay(
                      StepsPayment.choosPaymentMethod, CheckPaymentType.card),
                  icon: const Icon(
                    Icons.credit_card_rounded,
                    size: 70,
                    color: Colors.black26,
                  ),
                  label: Row(
                    children: const [
                      Text('Банковской картой', style: stylePayCaption)
                    ],
                  ),
                  style: OutlinedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)))),
                ),
                const SizedBox(height: 20),
                OutlinedButton.icon(
                  onPressed: () => changePageOnPay(StepsPayment.back, null),
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 70,
                    color: Colors.black26,
                  ),
                  label: Row(
                    children: const [Text('Назад', style: stylePayCaption)],
                  ),
                  style: OutlinedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)))),
                ),
              ],
            ),
          ),
        ],
      );
    }

    _pageChoiseBayerType() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25, top: 15, right: 25),
            child: Column(
              children: [
                const Text(
                  'Выберите тип покупателя',
                  style: TextStyle(fontSize: 30),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 20),
                OutlinedButton.icon(
                  onPressed: () => changePageOnPay(
                      StepsPayment.choosTypeBuyer, BuyerType.person),
                  icon: const Icon(
                    Icons.person,
                    size: 70,
                    color: Colors.black26,
                  ),
                  label: Row(
                    children: const [
                      Text('Частное лицо', style: stylePayCaption)
                    ],
                  ),
                  style: OutlinedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)))),
                ),
                const SizedBox(height: 20),
                OutlinedButton.icon(
                  onPressed: () => changePageOnPay(
                      StepsPayment.choosTypeBuyer, BuyerType.juridicalPerson),
                  icon: const Icon(
                    Icons.business,
                    size: 70,
                    color: Colors.black26,
                  ),
                  label: Row(
                    children: const [
                      Text('Юридическое лицо', style: stylePayCaption)
                    ],
                  ),
                  style: OutlinedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)))),
                ),
              ],
            ),
          )
        ],
      );
    }

    _pageamountMoneyReceived() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25, top: 15, right: 25),
            child: Column(
              children: [
                const Text(
                  'Сумма к оплате',
                  style: TextStyle(fontSize: 30),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 20),
                TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration:
                      const InputDecoration(border: OutlineInputBorder()),
                  style: stylePayCaption,
                ),
                const SizedBox(height: 20),
                OutlinedButton(
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    changePageOnPay(
                        StepsPayment.choosTypeBuyer, BuyerType.juridicalPerson);
                  },
                  style: OutlinedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      backgroundColor: Colors.green),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('ОПЛАТИТЬ',
                          style: TextStyle(fontSize: 26, color: Colors.white)),
                      SizedBox(
                        height: 70,
                        width: 1,
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                OutlinedButton.icon(
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    changePageOnPay(StepsPayment.back, null);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 70,
                    color: Colors.black26,
                  ),
                  label: Row(
                    children: const [Text('Назад', style: stylePayCaption)],
                  ),
                  style: OutlinedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)))),
                ),
              ],
            ),
          )
        ],
      );
    }

    return PageView(
      controller: controller,
      physics: const NeverScrollableScrollPhysics(),
      children: <Widget>[
        _pageChoiseBayerType(),
        _pageChoisePaymentType(),
        _pageamountMoneyReceived(),
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
