import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:subtraingrad/Screens/BookingProcess/Train/module/dashboard/view/dashboard_view.dart';
import 'package:subtraingrad/Screens/Profile/previoustrips_screen.dart';
import 'package:subtraingrad/Style/app_layout.dart';
import 'package:subtraingrad/Style/app_styles.dart';
import 'package:subtraingrad/widgets/resent_ticket.dart';

class TrainHome extends StatefulWidget {
  const TrainHome({super.key});

  @override
  State<TrainHome> createState() => _TrainHomeState();
}

class _TrainHomeState extends State<TrainHome> {
  final User? _user = FirebaseAuth.instance.currentUser;
  Stream<QuerySnapshot>? _searchStream;

  @override
  void initState() {
    super.initState();
    initialData();
  }

  initialData() {
    _searchStream = FirebaseFirestore.instance
        .collection("users")
        .doc(_user!.uid)
        .collection("Privouse_Trip")
        .where("type", isEqualTo: "Train_tickets")
        .orderBy('validateDate')
        .limit(4)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);

    return Column(
      children: [
        const Gap(8),
        Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DashboardView(),
                  ));
            },
            child: Ink(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Styles.primaryColor),
              child: Container(
                width: size.width * 0.80,
                height: 110,
                alignment: Alignment.center,
                child: Text(
                  'Book Train Ticket',
                  textAlign: TextAlign.center,
                  style: MyFonts.font24White,
                ),
              ),
            ),
          ),
        ),
        const Gap(16),
        SizedBox(
          width: size.width * 0.90,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Recent Trips", style: MyFonts.font18Black),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PreviousTrips(),
                      ));
                },
                child: Text(
                  "View all",
                  style: MyFonts.font16Black,
                ),
              ),
            ],
          ),
        ),
        StreamBuilder<QuerySnapshot>(
          stream: _searchStream,
          builder: (context, streamSnapshot) {
            if (streamSnapshot.hasData) {
              if (streamSnapshot.data!.docs.isEmpty) {
                return const Center(child: Text("No results found"));
              }

              return ListView.builder(
                shrinkWrap: true,
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                  return Center(
                    child: ResentTripsTicket(
                      bookingDate: documentSnapshot['bookingDate'],
                      endPoint: documentSnapshot['endPoint'],
                      fare: documentSnapshot['fare'],
                      startPoint: documentSnapshot['startPoint'],
                      status: documentSnapshot['status'],
                    ),
                  );
                },
              );
            } else if (streamSnapshot.hasError) {
              return Center(child: Text("Error: ${streamSnapshot.error}"));
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ],
    );
  }
}
