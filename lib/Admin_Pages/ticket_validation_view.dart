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
  Future<void> _fetchData() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userID)
        .collection('Subway_tickets')
        .doc(widget.data)
        .get();
    final ticketData = snapshot.data();
    if (ticketData != null) {
      setState(() {
        startPoint = ticketData['startPoint'];
        endPoint = ticketData['endPoint'];
        fare = ticketData['fare'];
        status = ticketData['status'];
      });
    }
  }

  Future<void> _updateData() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userID)
        .collection('Subway_tickets')
        .doc(widget.data)
        .update({
      'status': status,
    });
  }

  Future<void> addTicketPrivouseTrip(useriD) async {
    final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    final String date = dateFormat.format(DateTime.now());
    String ticketId = randomAlphaNumeric(20);
    Map<String, dynamic> privouseTripInfoMap = {
      'subwayTicketID': ticketId,
      "userID": useriD,
      "bookingDate": date,
      "startPoint": startPoint,
      "endPoint": endPoint,
      "fare": fare,
      "status": status,
    };
    await DatabaseMethod()
        .addPrivouseTrip(privouseTripInfoMap, ticketId, useriD);
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Start Point: ${startPoint}",
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  "End Point: ${endPoint}",
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  "Price: ${fare}",
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  "Status: ${status}",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  if (status == "New") {
                    setState(() {
                      status = "Checked";
                    });
                    _updateData();
                    Navigator.pop(context);
                  } else if (status == "Checked") {
                    addTicketPrivouseTrip(widget.userID);
                    FirebaseFirestore.instance
                        .collection("users")
                        .doc(widget.userID)
                        .collection("Subway_tickets")
                        .doc(widget.data)
                        .delete();
                    Navigator.pop(context);
                  }
                },
                child: Text("Check"))
          ],
        ),
      ),
    );
  }
}
