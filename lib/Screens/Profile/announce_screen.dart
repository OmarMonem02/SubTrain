import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:subtraingrad/Style/app_styles.dart';
import 'package:subtraingrad/widgets/announce_post.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class Announcements extends StatefulWidget {
  const Announcements({super.key});

  @override
  State<Announcements> createState() => _AnnouncementsState();
}

class _AnnouncementsState extends State<Announcements> {
  final CollectionReference fetchData =
      FirebaseFirestore.instance.collection("Announcement");
  Future onRefresh() async {
    await fetchData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LiquidPullToRefresh(
        onRefresh: onRefresh,
        animSpeedFactor: 10,
        showChildOpacityTransition: false,
        height: 90,
        backgroundColor: Styles.primaryColor,
        color: Styles.secondaryColor,
        child: StreamBuilder(
            stream: fetchData.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              if (streamSnapshot.hasData) {
                return ListView.builder(
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                          streamSnapshot.data!.docs[index];
                      return Material(
                        child: AnnouncementPost(
                          date: documentSnapshot['date'],
                          header: documentSnapshot['title'],
                          massage: documentSnapshot['body'],
                        ),
                      );
                    });
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
      appBar: AppBar(
        title: Text(
          "Announcements",
          style: MyFonts.appbar,
        ),
      ),
    );
  }
}
