import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:io';

import 'package:subtraingrad/Admin_Pages/ticket_validation_view.dart';

class TicketValidator extends StatefulWidget {
  const TicketValidator({Key? key}) : super(key: key);

  @override
  State<TicketValidator> createState() => _TicketValidatorState();
}

class _TicketValidatorState extends State<TicketValidator> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  String? data;
  String? userID;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
        ],
      ),
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Ticket Validate",
            ),
          ],
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        // Assuming the QR code data is in the format "data/userID"
        List<String> splitData = result!.code!.split('/');
        if (splitData.length == 2) {
          data = splitData[0];
          userID = splitData[1];

          // Navigate to TicketValidationView page
          controller.dispose();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TicketValidationView(
                data: data!,
                userID: userID!,
              ),
            ),
          );
        } else {
          data = null;
          userID = null;
        }
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
