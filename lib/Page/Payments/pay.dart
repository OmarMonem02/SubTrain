import 'package:flutter/material.dart';
import 'package:subtraingrad/Page/Payments/Paymob_Manager/paymob_manager.dart';
import 'package:subtraingrad/Style/app_styles.dart';
import 'package:url_launcher/url_launcher.dart';

class Payments extends StatefulWidget {
  const Payments({super.key});

  @override
  State<Payments> createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments> {
  TextEditingController amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Paymob Integration"),
      ),
      body: Center(
        child: Column(
          children: [
            SubTextField(
              enable: true,
              controller: amountController,
              hint: "100",
              textLabel: 'Amount',
              textInputType: TextInputType.number,
            ),
            ElevatedButton(

              onPressed: () async => _pay(),
              child: Text('Pay ${amountController.text}'),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> _pay() async {
    int amount = int.tryParse(amountController.text) ?? 0;
    PaymobManager().getPaymentKey(amount, "EGP").then(
      (String paymentKey) {
        launchUrl(
          Uri.parse(
              "https://accept.paymob.com/api/acceptance/iframes/832567?payment_token=$paymentKey"),
        );
      },
    );
  }
}
