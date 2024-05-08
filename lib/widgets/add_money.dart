import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:gap/gap.dart';
import 'package:subtraingrad/Page/Payments/Paymob_Manager/paymob_manager.dart';
import 'package:subtraingrad/Style/app_styles.dart';

class AddMoney extends StatefulWidget {
  final Function(int) addAmountToBalance; // Callback function

  const AddMoney({
    super.key,
    required this.addAmountToBalance,
  });

  @override
  State<AddMoney> createState() => AddMoneyState();
}

class AddMoneyState extends State<AddMoney> {
  InAppWebViewController? _webViewController;

  TextEditingController amountController = TextEditingController();
  bool isLoading = false; // Track loading state
  bool isTextFieldEmpty = true; // Track if text field is empty

  @override
  void initState() {
    super.initState();
    // Listen for changes in the text field
    amountController.addListener(() {
      setState(() {
        // Update the state based on whether the text field is empty
        isTextFieldEmpty = amountController.text.isEmpty;
      });
    });
  }

  void _pay() async {
    setState(() {
      isLoading = true; // Set loading state to true
    });

    int amount = int.tryParse(amountController.text) ?? 0;
    widget.addAmountToBalance(amount);
    // Call the callback function to add amount to balance

    PaymobManager().getPaymentKey(amount, "EGP").then(
      (String paymentKey) {
        _webViewController?.loadUrl(
            urlRequest: URLRequest(
          url: Uri.parse(
              "https://accept.paymob.com/api/acceptance/iframes/832567?payment_token=$paymentKey"),
        ));
      },
    ).whenComplete(() {
      setState(() {
        isLoading =
            false; // Set loading state to false when operation completes
      });
    });
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: SafeArea(
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: -20,
                child: Container(
                  width: 80,
                  height: 8,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Center(
                  child: Column(
                    children: [
                      const Gap(25),
                      Text(
                        "Add Money To Your Balance",
                        style: Styles.headLineStyle1.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary),
                      ),
                      const Gap(25),
                      SubTextField(
                        enable: true,
                        controller: amountController,
                        hint: "Enter Amount",
                        textLabel: "Amount",
                        textInputType: TextInputType.number,
                      ),
                      const Gap(20),
                      ElevatedButton(
                        style: buttonPrimary,
                        onPressed: isTextFieldEmpty || isLoading ? null : _pay,
                        child: isLoading
                            ? CircularProgressIndicator(
                                color: Styles.mainColor,
                                backgroundColor: Styles.secColor,
                              )
                            : const Text(
                                'Add Money',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                      ),
                      const Gap(90),
                      Text(
                        "Powered by",
                        style: Styles.headLineStyle4,
                      ),
                      const Gap(10),
                      const Image(
                        image: AssetImage("assets/logoC.png"),
                        width: 180,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
