import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class PaymentGetway extends StatefulWidget {
  const PaymentGetway({super.key});

  @override
  State<PaymentGetway> createState() => _PaymentGetwayState();
}

class _PaymentGetwayState extends State<PaymentGetway> {
  InAppWebViewController? _webViewController;

  void startPayment() {
    _webViewController?.loadUrl(
        urlRequest: URLRequest(
            url: Uri.parse(
                "https://accept.paymob.com/api/acceptance/iframes/832567?payment_token=paymentKey")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InAppWebView(
        initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(javaScriptEnabled: true)),
        onWebViewCreated: (controller) {
          _webViewController = controller;
          startPayment();
        },
      ),
    );
  }
}
