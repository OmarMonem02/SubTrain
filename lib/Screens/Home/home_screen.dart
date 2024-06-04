// ignore_for_file: avoid_print, unnecessary_string_interpolations

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart';
import 'package:subtraingrad/Chat_Bot/chat_screen.dart';
import 'package:subtraingrad/Screens/Home/subway_home.dart';
import 'package:subtraingrad/Screens/Home/train_home.dart';
import 'package:subtraingrad/Style/app_styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String username = "";
  final User? _user = FirebaseAuth.instance.currentUser;
  bool scanning = true;
  String? address, coordinates;
  // Fetch data on initialization
  @override
  void initState() {
    super.initState();
    _fetchData();
    checkPermission();
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

  bool _isTypeSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.backGroundColor,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                const Gap(8),
                Row(
                  children: [
                    Column(
                      children: [
                        Text('Hello $username', style: MyFonts.font24Black),
                      ],
                    ),
                  ],
                ),
                const Gap(16),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isTypeSelected = true;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: _isTypeSelected
                                    ? Styles.primaryColor
                                    : Colors.white,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(16),
                                    topLeft: Radius.circular(16),
                                    bottomRight: Radius.circular(16),
                                    topRight: Radius.circular(16))),
                            padding: EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.train,
                                  color: _isTypeSelected
                                      ? Colors.white
                                      : Colors.grey,
                                ),
                                Text(
                                  'Subway',
                                  style: TextStyle(
                                      color: _isTypeSelected
                                          ? Colors.white
                                          : Colors.grey,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isTypeSelected = false;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: !_isTypeSelected
                                  ? Styles.primaryColor
                                  : Colors.white,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(16),
                                  topLeft: Radius.circular(16),
                                  bottomRight: Radius.circular(16),
                                  topRight: Radius.circular(16))),
                          padding: EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.subway,
                                color: !_isTypeSelected
                                    ? Colors.white
                                    : Colors.grey,
                              ),
                              SizedBox(width: 8.0),
                              Text(
                                'Train',
                                style: TextStyle(
                                    color: !_isTypeSelected
                                        ? Colors.white
                                        : Colors.grey,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ))
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Gap(15),
          _isTypeSelected ? const SubwayHome() : const TrainHome(),
        ],
      ),
      appBar: AppBar(
        backgroundColor: Styles.backGroundColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'SubTrain',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Styles.primaryColor,
              ),
            ),
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
          tooltip: "Chat with SubBot",
          child: Image.asset(
            "assets/logoblue.png",
            height: double.infinity,
          )),
    );
  }

  checkPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: "Request Denied !");
        return;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(msg: "Request Denied Forever !");
      return;
    }
  }
}
