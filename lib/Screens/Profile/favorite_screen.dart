import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:subtraingrad/Style/app_styles.dart';
import 'package:subtraingrad/widgets/favorite_trips_ticket.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
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
            .collection("Favorite_Trips")
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
          .delete();
    } else {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(_user!.uid)
          .collection("Favorite_Trips")
          .doc(documentSnapshot.id)
          .set(documentSnapshot.data() as Map<String, dynamic>);
    }
  }

  bool _isFavorite(
      DocumentSnapshot documentSnapshot, List<DocumentSnapshot> favoriteTrips) {
    return favoriteTrips
        .any((favoriteTrip) => favoriteTrip.id == documentSnapshot.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.backGroundColor,
      appBar: AppBar(
        backgroundColor: Styles.backGroundColor,
        title: Text(
          "Favorites",
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
            final favoriteTrips = streamSnapshot.data!.docs;

            return ListView.builder(
              itemCount: favoriteTrips.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot = favoriteTrips[index];
                bool isFavorite = _isFavorite(documentSnapshot, favoriteTrips);

                return FavoriteTripsTicket(
                  bookingDate: documentSnapshot['bookingDate'],
                  startPoint: documentSnapshot['startPoint'],
                  endPoint: documentSnapshot['endPoint'],
                  fare: documentSnapshot['fare'],
                  status: documentSnapshot['status'],
                  favBtn: isFavorite,
                  onFavChanged: (isFavorite) {
                    // This is where we handle the favorite change
                    _handleFavoriteChange(!isFavorite, documentSnapshot);
                  },
                );
              },
            );
          } else {
            return Center(
                child: Text(
              "You do not have Favorites",
              style: MyFonts.font16Black,
            ));
          }
        },
      ),
    );
  }
}
