import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:subtraingrad/widgets/Train_Widgets/train_qr_ticket.dart';
import 'package:subtraingrad/widgets/Train_Widgets/train_ticket_active.dart';

class TrainTicketsScreen extends StatefulWidget {
  const TrainTicketsScreen({super.key});

  @override
  State<TrainTicketsScreen> createState() => _TrainTicketsScreenState();
}

class _TrainTicketsScreenState extends State<TrainTicketsScreen> {
  String ticketID = "";
  String startPoint = "";
  String endPoint = "";
  String bookingDate = "";
  int seat = 0;
  int price = 0;
  final User? _user = FirebaseAuth.instance.currentUser;
  late final Stream<QuerySnapshot> _ticketsStream;

  @override
  void initState() {
    super.initState();
    if (_user != null) {
      _ticketsStream = FirebaseFirestore.instance
          .collection("users")
          .doc(_user.uid)
          .collection("Train_tickets")
          .snapshots();
    }
  }

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
          child: TrainQrTicket(
            userID: _user!.uid,
            price: price,
            endPoint: endPoint,
            startPoint: startPoint,
            data: ticketID,
            seat: seat,
            bookingDate: bookingDate,
          ),
        ),
      ),
    );
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
                      ticketID = documentSnapshot['trainTicketID'];
                      startPoint = documentSnapshot['startPoint'];
                      endPoint = documentSnapshot['endPoint'];
                      bookingDate = documentSnapshot['bookingDate'];
                      seat = documentSnapshot['Seat'];
                      price = documentSnapshot['fare'];
                    });
                    showTicketBottomSheet(context);
                  },
                  child: TrainTicketActive(
                    bookingDate: documentSnapshot['bookingDate'],
                    startPoint: documentSnapshot['startPoint'],
                    endPoint: documentSnapshot['endPoint'],
                    fare: documentSnapshot['fare'],
                    status: documentSnapshot['status'],
                    departureStation: documentSnapshot['departureStation'],
                    arrivalStation: documentSnapshot['arrivalStation'],
                    seat: documentSnapshot['Seat'],
                  ),
                );
              },
            );
          } else {
            return Center(child: Text("You do not have train tickets"));
          }
        },
      ),
    );
  }
}
