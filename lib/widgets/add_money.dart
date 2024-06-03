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
  const AddMoney({super.key});

  @override
  State<AddMoney> createState() => _AddMoneyState();
}

class _AddMoneyState extends State<AddMoney> {
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

  Future<void> _fetchData() async {
    if (_user != null) {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(_user!.uid)
          .get();
      final userData = snapshot.data();
      if (userData != null && userData.containsKey('balance')) {
        setState(() {
          balance = userData['balance'];
        });
      }
    }
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  Future<void> _pay() async {
    setState(() {
      isLoading = true;
    });

    try {
      int amount = int.tryParse(amountController.text) ?? 0;

      if (amount <= 0) {
        // Show an error if the amount is invalid
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please enter a valid amount")),
        );
        setState(() {
          isLoading = false;
        });
        return;
      }

      String paymentKey = await PaymobManager().getPaymentKey(amount, "EGP");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentGetway(
            paymentToken: paymentKey,
            amount: amount,
          ),
        ),
      );
    } catch (e) {
      // Handle errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error processing payment: $e")),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
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
              _buildHandleIndicator(),
              _buildContent(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHandleIndicator() {
    return Positioned(
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
    );
  }

  Widget _buildContent(BuildContext context) {
    return Container(
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
                      color: Styles.primaryColor,
                      backgroundColor: Styles.secondaryColor,
                    )
                  : const Text(
                      'Add Money',
                      style: TextStyle(color: Colors.white, fontSize: 20),
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
            ),
          ],
        ),
      ),
    );
  }
}
