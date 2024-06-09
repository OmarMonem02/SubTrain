import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:subtraingrad/Style/app_styles.dart';
import 'package:subtraingrad/widgets/Subway_Widgets/subway_ticket_active.dart';
import 'package:subtraingrad/widgets/Subway_Widgets/subway_qr_ticket.dart';

class SubwayTicketsScreen extends StatefulWidget {
  const SubwayTicketsScreen({super.key});

  @override
  State<SubwayTicketsScreen> createState() => _SubwayTicketsScreenState();
}

class _SubwayTicketsScreenState extends State<SubwayTicketsScreen> {
  String ticketID = "";
  String startPoint = "";
  String endPoint = "";
  String status = "";
  int price = 0;
  final User? _user = FirebaseAuth.instance.currentUser;
  bool loading = false;

  void showTicketBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.45,
        maxChildSize: 0.63,
        minChildSize: 0.44,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          child: SubwayQrTicket(
            userID: _user!.uid,
            price: price,
            endPoint: endPoint,
            startPoint: startPoint,
            data: ticketID,
          ),
        ),
      ),
    );
  }

  Stream<QuerySnapshot>? _ticketsStream;

  @override
  void initState() {
    super.initState();
    _initializeStream();
  }

  void _initializeStream() {
    if (_user != null) {
      _ticketsStream = FirebaseFirestore.instance
          .collection("users")
          .doc(_user.uid)
          .collection("Subway_tickets")
          .snapshots();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _ticketsStream,
        builder: (context, streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (streamSnapshot.hasError) {
            return Center(child: Text("Error: ${streamSnapshot.error}"));
          } else if (streamSnapshot.hasData &&
              streamSnapshot.data!.docs.isNotEmpty) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return InkWell(
                  onTap: () {
                    setState(() {
                      ticketID = documentSnapshot['subwayTicketID'];
                      startPoint = documentSnapshot['startPoint'];
                      endPoint = documentSnapshot['endPoint'];
                      price = documentSnapshot['fare'];
                    });
                    showTicketBottomSheet(context);
                  },
                  child: SubwayTicketActive(
                    bookingDate: documentSnapshot['bookingDate'],
                    startPoint: documentSnapshot['startPoint'],
                    endPoint: documentSnapshot['endPoint'],
                    fare: documentSnapshot['fare'],
                    status: documentSnapshot['status'],
                  ),
                );
              },
            );
          } else {
            return Center(
                child: Text(
              "You do not have subway tickets",
              style: MyFonts.font18Black,
            ));
          }
        },
      ),
    );
  }
}
