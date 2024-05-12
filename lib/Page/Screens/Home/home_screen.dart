import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:subtraingrad/Page/Chat_Bot/chat_screen.dart';
import 'package:subtraingrad/Page/Screens/Home/subway_home.dart';
import 'package:subtraingrad/Page/Screens/Home/train_home.dart';
import 'package:subtraingrad/Style/app_styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  bool _isTypeSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                const Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Good Morning',
                          style: Styles.headLineStyle3,
                        ),
                        Text(
                          'Book Your Ticket',
                          style: Styles.headLineStyle1,
                        ),
                      ],
                    ),
                    LiteRollingSwitch(
                      onSwipe: () {},
                      onDoubleTap: () {},
                      onTap: () {},
                      width: 120,
                      textSize: 16,
                      value: _isTypeSelected,
                      textOn: 'Train',
                      textOnColor: Colors.white,
                      iconOn: Icons.train_outlined,
                      colorOn: Styles.mainColor,
                      textOff: 'Subway',
                      textOffColor: Colors.black,
                      colorOff: Styles.secColor,
                      animationDuration: const Duration(milliseconds: 400),
                      iconOff: Icons.subway_outlined,
                      onChanged: (isSelected) {
                        setState(() {
                          _isTypeSelected = isSelected;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Gap(15),
          _isTypeSelected ? const TrainHome() : const SubwayHome(),
        ],
      ),
      appBar: AppBar(
        toolbarHeight: 60,
        automaticallyImplyLeading: false,
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
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const ChatScreen();
            }));
          },
          elevation: 10,
          backgroundColor: Colors.white,
          tooltip: "Chat with Broxi",
          child: Image.asset(
            "assets/Logo.png",
            width: 33,
          )),
    );
  }
}
