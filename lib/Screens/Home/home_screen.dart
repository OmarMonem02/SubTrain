// ignore_for_file: avoid_print, unnecessary_string_interpolations

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
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
  // Print the nearest station
  // print('Nearest station: ${nearestStation.city}');
  String username = ""; // Initialize an empty username
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
                          'Hello $username,',
                          style: Styles.headLineStyle3,
                        ),
                        Text(
                          'Select Ticket Mode',
                          style: Styles.headLineStyle2,
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
              'SubTrain',
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
            "assets/logo3.png",
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
    getLocation();
  }

  getLocation() async {
    setState(() {
      scanning = true;
    });
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      coordinates =
          'Latitude : ${position.latitude}\nLongitude : ${position.longitude}';
      List<Placemark> result =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      if (result.isEmpty) {
        address =
            '${result[0].name},${result[0].locality},${result[0].administrativeArea}';
      }
      print(position);
      print(address);
    } catch (e) {
      Fluttertoast.showToast(msg: "${e.toString()}");
    }
  }
}
