import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:subtraingrad/Style/app_layout.dart';
import 'package:subtraingrad/Style/app_styles.dart';

class SubwayQrTicket extends StatelessWidget {
  final String data;
  final String startPoint;
  final String endPoint;
  final int price;
  SubwayQrTicket(
      {super.key,
      required this.data,
      required this.startPoint,
      required this.endPoint,
      required this.price});
  final User? _user = FirebaseAuth.instance.currentUser;
  Future<void> _updateData() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(_user!.uid)
        .update({
      'balance': FieldValue.increment(price),
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: -15,
          child: Container(
            width: 60,
            height: 7,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          width: size.width * 1,
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              QrImageView(
                data: data,
                size: 200,
              ),
              const SizedBox(
                height: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'From: ${startPoint}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    'to: ${endPoint}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                style: buttonPrimary,
                child: const Text(
                  'Modify',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () {},
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                style: buttonRed,
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        contentPadding: EdgeInsets.all(20.0),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.sentiment_dissatisfied,
                              color: Color.fromARGB(255, 214, 196, 39),
                              size: 48.0,
                            ),
                          ],
                        ),
                        content: Text(
                          'Are you sure you want to cancel?',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        actions: [
                          TextButton(
                            child: Text(
                              'No',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromRGBO(26, 96, 122, 1),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text(
                              'Yes',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromRGBO(152, 152, 152, 1),
                              ),
                            ),
                            onPressed: () {
                              FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(_user?.uid)
                                  .collection("Subway_tickets")
                                  .doc(data)
                                  .delete()
                                  .then((_) {
                                _updateData();
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      contentPadding: EdgeInsets.all(24.0),
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.check_circle,
                                            color: Colors.green,
                                            size: 48.0,
                                          ),
                                        ],
                                      ),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'Your SubwayQrticket has been successfully canceled!',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(height: 16.0),
                                          ElevatedButton(
                                            child: Text(
                                              'Ok',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(
                                                Color.fromRGBO(
                                                    152, 152, 152, 1),
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              }).catchError((error) {
                                // Handle error (e.g., show an error dialog)
                                print("Failed to delete ticket: $error");
                              });
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
