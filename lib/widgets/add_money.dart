import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:subtraingrad/Payments/Paymob_Manager/paymob_manager.dart';
import 'package:subtraingrad/Payments/payment_getway.dart';
import 'package:subtraingrad/Screens/Profile/profile_screen.dart';
import 'package:subtraingrad/Style/app_styles.dart';

final User? _user = FirebaseAuth.instance.currentUser;

class AddMoney extends StatefulWidget {
  const AddMoney({
    super.key,
  });

  @override
  State<AddMoney> createState() => AddMoneyState();
}

class AddMoneyState extends State<AddMoney> {
  Future<void> _fetchData() async {
    if (_user != null) {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(_user!.uid)
          .get();
      final userData = snapshot.data();
      if (userData != null && userData.containsKey('balance')) {
        // Check for 'balance'
        setState(() {
          balance = userData['balance'];
        });
      }
    }
  }

  TextEditingController amountController = TextEditingController();
  bool isLoading = false;
  bool isTextFieldEmpty = true;

  @override
  void initState() {
    super.initState();
    _fetchData();

    amountController.addListener(() {
      setState(() {
        isTextFieldEmpty = amountController.text.isEmpty;
      });
    });
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
                        style: Styles.headLineStyle1.copyWith(),
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

  void _pay() async {
    setState(() {
      isLoading = true; // Set loading state to true
    });

    int amount = int.tryParse(amountController.text) ?? 0;

    PaymobManager().getPaymentKey(amount, "EGP").then(
      (String paymentKey) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentGetway(
              paymentToken: paymentKey,
              amount: amount,
            ),
          ),
        );
      },
    ).whenComplete(
      () {
        setState(
          () {
            isLoading = false;
          },
        );
      },
    );
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }
}
