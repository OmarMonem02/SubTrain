import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:subtraingrad/Page/Screens/Home/user_widget.dart';
import 'package:subtraingrad/Style/app_styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> userIDs = [];
  Future readUserdata() async {
    await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((collection) => collection.docs.forEach((decoment) {
              log(decoment.id);
              userIDs.add(decoment.id);
            }));
  }

  String username = ""; // Initialize an empty username
  final User? _user = FirebaseAuth.instance.currentUser;

  // Fetch data on initialization
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  // Function to fetch the username
  Future<void> _fetchData() async {
    if (_user != null) {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(_user.uid)
          .get();
      final userData = snapshot.data();
      if (userData != null) {
        setState(() {
          username = userData['firstName'] ?? 'User';
        });
      }
    }
  }

  final bool _isTypeSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: readUserdata(),
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: userIDs.length,
            itemBuilder: (context, index) {
              return UserWidget(docId: userIDs[index]);
            },
          );
        },
      ),
      appBar: AppBar(
        toolbarHeight: 60,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Welcome, $username',
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(26, 96, 122, 1),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications,
                color: Styles.secColor,
                size: 35,
              ),
            )
          ],
        ),
      ),
    );
  }
}








// ListView(
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 15),
//             child: Column(
//               children: [
//                 const Gap(20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Good Morning',
//                           style: Styles.headLineStyle3,
//                         ),
//                         Text(
//                           'Book Your Ticket',
//                           style: Styles.headLineStyle1,
//                         ),
//                       ],
//                     ),
//                     LiteRollingSwitch(
//                       onSwipe: () {},
//                       onDoubleTap: () {},
//                       onTap: () {},
//                       width: 120,
//                       textSize: 16,
//                       value: _isTypeSelected,
//                       textOn: 'Train',
//                       textOnColor: Colors.white,
//                       iconOn: Icons.train_outlined,
//                       colorOn: Styles.mainColor,
//                       textOff: 'Subway',
//                       textOffColor: Colors.black,
//                       colorOff: Styles.secColor,
//                       animationDuration: const Duration(milliseconds: 400),
//                       iconOff: Icons.subway_outlined,
//                       onChanged: (isSelected) {
//                         setState(() {
//                           _isTypeSelected = isSelected;
//                         });
//                       },
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           const Gap(15),
//           _isTypeSelected ? const TrainHome() : const SubwayHome(),

//           // Upcoming Trips Section
//         ],
//       ),