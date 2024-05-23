import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:subtraingrad/widgets/Ticket.dart';
import 'package:subtraingrad/widgets/ticket_booked.dart';

class SubwayTicketsScreen extends StatefulWidget {
  const SubwayTicketsScreen({super.key});

  @override
  State<SubwayTicketsScreen> createState() => _SubwayTicketsScreenState();
}

class _SubwayTicketsScreenState extends State<SubwayTicketsScreen> {
  String ticketID = "";
  String startPoint = "";
  String endPoint = "";
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
          child: Ticket(
            endPoint: endPoint,
            startPoint: startPoint,
            data: ticketID,
          ),
        ),
      ),
    );
  }

  final CollectionReference fetchData =
      FirebaseFirestore.instance.collection("Subway_tickets");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: fetchData.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                  itemCount: streamSnapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot documentSnapshot =
                        streamSnapshot.data!.docs[index];
                    return InkWell(
                      onTap: () {
                        showTicketBottomSheet(context);
                        ticketID = documentSnapshot['subwayTicketID'];
                        startPoint = documentSnapshot['startPoint'];
                        endPoint = documentSnapshot['endPoint'];
                      },
                      child: SubwayTicketActive(
                        bookingDate: documentSnapshot['bookingDate'],
                        startPoint: documentSnapshot['startPoint'],
                        endPoint: documentSnapshot['endPoint'],
                        fare: documentSnapshot['fare'],
                        status: documentSnapshot['status'],
                      ),
                    );
                  });
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
