import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';
import 'package:subtraingrad/Screens/auth/add_new_data.dart';

class TicketValidationView extends StatefulWidget {
  final String data;
  final String userID;

  const TicketValidationView({
    Key? key,
    required this.data,
    required this.userID,
  }) : super(key: key);

  @override
  State<TicketValidationView> createState() => _TicketValidationViewState();
}

class _TicketValidationViewState extends State<TicketValidationView> {
  String startPoint = "";
  String endPoint = "";
  int fare = 0;
  String status = "";
  String collection = "";

  Future<void> _fetchData() async {
    try {
      final subwaySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userID)
          .collection('Subway_tickets')
          .doc(widget.data)
          .get();
      if (subwaySnapshot.exists) {
        final ticketData = subwaySnapshot.data();
        setState(() {
          startPoint = ticketData!['startPoint'];
          endPoint = ticketData['endPoint'];
          fare = ticketData['fare'];
          status = ticketData['status'];
          collection = 'Subway_tickets';
        });
        return;
      }

      final trainSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userID)
          .collection('Train_tickets')
          .doc(widget.data)
          .get();
      if (trainSnapshot.exists) {
        final ticketData = trainSnapshot.data();
        setState(() {
          startPoint = ticketData!['startPoint'];
          endPoint = ticketData['endPoint'];
          fare = ticketData['fare'];
          status = ticketData['status'];
          collection = 'Train_tickets';
        });
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ticket data not found')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching ticket data: $e')),
      );
    }
  }

  Future<void> _updateData() async {
    if (collection.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userID)
          .collection(collection)
          .doc(widget.data)
          .update({
        'status': status,
      });
    }
  }

  Future<void> addTicketPreviousTrip(String userID) async {
    final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    final String date = dateFormat.format(DateTime.now());
    String ticketId = randomAlphaNumeric(20);
    Map<String, dynamic> previousTripInfoMap = {
      'subwayTicketID': ticketId,
      "userID": userID,
      "bookingDate": date,
      "startPoint": startPoint,
      "endPoint": endPoint,
      "fare": fare,
      "status": status,
    };
    await DatabaseMethod().addPrivouseTrip(previousTripInfoMap, ticketId, userID);
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ticket Validation"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(vertical: 20),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Start Point: $startPoint",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "End Point: $endPoint",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Price: $fare",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Status: $status",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () async {
                if (status == "New") {
                  setState(() {
                    status = "Checked";
                  });
                  await _updateData();
                } else if (status == "Checked") {
                  await addTicketPreviousTrip(widget.userID);
                  await FirebaseFirestore.instance
                      .collection("users")
                      .doc(widget.userID)
                      .collection(collection)
                      .doc(widget.data)
                      .delete();
                }
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              ),
              child: Text(
                "Check",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
