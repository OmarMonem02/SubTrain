import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:subtraingrad/Style/app_styles.dart';
import 'package:subtraingrad/widgets/previous_trips_ticket.dart';

class PreviousTrips extends StatefulWidget {
  const PreviousTrips({super.key});

  @override
  State<PreviousTrips> createState() => _PreviousTripsState();
}

class _PreviousTripsState extends State<PreviousTrips> {
  final User? _user = FirebaseAuth.instance.currentUser;
  Stream<QuerySnapshot>? _ticketsStream;

  @override
  void initState() {
    super.initState();
    _initializeStream();
  }

  void _initializeStream() {
    if (_user != null) {
      setState(() {
        _ticketsStream = FirebaseFirestore.instance
            .collection("users")
            .doc(_user.uid)
            .collection("Privouse_Trip")
            .orderBy('bookingDate', descending: false)
            .snapshots();
      });
    }
  }

  Future<void> _handleFavoriteChange(
      bool isFavorite, DocumentSnapshot documentSnapshot) async {
    if (isFavorite) {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(_user!.uid)
          .collection("Favorite_Trips")
          .doc(documentSnapshot.id)
          .set(documentSnapshot.data() as Map<String, dynamic>);
    } else {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(_user!.uid)
          .collection("Favorite_Trips")
          .doc(documentSnapshot.id)
          .delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.backGroundColor,
      appBar: AppBar(
        backgroundColor: Styles.backGroundColor,
        title: Text(
          "Previous Trips",
          style: MyFonts.appbar,
        ),
      ),
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
                bool isFavorite =
                    false; // Add logic to check if it's a favorite

                return PreviousTripsTicket(
                  bookingDate: documentSnapshot['bookingDate'],
                  startPoint: documentSnapshot['startPoint'],
                  endPoint: documentSnapshot['endPoint'],
                  fare: documentSnapshot['fare'],
                  status: documentSnapshot['status'],
                  favBtn: isFavorite,
                  onFavChanged: (isFavorite) {
                    _handleFavoriteChange(isFavorite, documentSnapshot);
                  },
                );
              },
            );
          } else {
            return Center(
                child: Text(
              "You do not have subway tickets",
              style: MyFonts.font16BlackFaded,
            ));
          }
        },
      ),
    );
  }
}
