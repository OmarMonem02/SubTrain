import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:quickalert/quickalert.dart';

class WithdrawPaymentGetway extends StatefulWidget {
  final String paymentToken;
  final int amount;

  const WithdrawPaymentGetway(
      {super.key, required this.paymentToken, required this.amount});

  @override
  State<WithdrawPaymentGetway> createState() => _WithdrawPaymentGetwayState();
}

class _WithdrawPaymentGetwayState extends State<WithdrawPaymentGetway> {
  bool isLoading = false;
  InAppWebViewController? _webViewController;

  void startPayment() {
    _webViewController?.loadUrl(
      urlRequest: URLRequest(
        url: Uri.parse(
            "https://accept.paymob.com/api/acceptance/iframes/832567?payment_token=${widget.paymentToken}"),
      ),
    );
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
