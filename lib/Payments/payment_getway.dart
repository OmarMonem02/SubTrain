import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:quickalert/quickalert.dart';

class PaymentGetway extends StatefulWidget {
  final String paymentToken;
  final int amount;

  const PaymentGetway(
      {super.key, required this.paymentToken, required this.amount});

  @override
  State<PaymentGetway> createState() => _PaymentGetwayState();
}

class _PaymentGetwayState extends State<PaymentGetway> {
  bool isLoading = false;
  InAppWebViewController? _webViewController;

  final User? _user = FirebaseAuth.instance.currentUser;

  void startPayment() {
    _webViewController?.loadUrl(
      urlRequest: URLRequest(
        url: Uri.parse(
            "https://accept.paymob.com/api/acceptance/iframes/832567?payment_token=${widget.paymentToken}"),
      ),
    );
  }

  Future<void> _updateData() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(_user!.uid)
        .update({
      'balance': FieldValue.increment(widget.amount),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Payment Gateway")),
      body: InAppWebView(
        initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(javaScriptEnabled: true)),
        onWebViewCreated: (controller) {
          _webViewController = controller;
          startPayment();
        },
        onLoadStop: (controller, url) {
          if (url != null &&
              url.queryParameters.containsKey('success') &&
              url.queryParameters['success'] == 'true') {
            QuickAlert.show(
                context: context,
                type: QuickAlertType.success,
                text: "Your Balance Increased",
                onConfirmBtnTap: () async {
                  Navigator.pop(context);
                });
            _updateData();
            log('payment success');
          } else if (url != null &&
              url.queryParameters.containsKey('success') &&
              url.queryParameters['success'] == 'false') {
            log('payment not success');
          }
        },
      ),
    );
  }
}
