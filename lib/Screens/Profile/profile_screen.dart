import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:subtraingrad/Screens/auth/auth_page.dart';
import 'package:subtraingrad/Style/app_layout.dart';
import 'package:subtraingrad/Style/app_styles.dart';
import 'package:subtraingrad/widgets/setting_button.dart';
import 'package:subtraingrad/widgets/add_money.dart';

int? balance;
Future<void> addMoneySheet(BuildContext context) async {
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
      initialChildSize: 0.65,
      maxChildSize: 0.65,
      minChildSize: 0.63,
      builder: (context, scrollController) => SingleChildScrollView(
        controller: scrollController,
        child: const AddMoney(),
      ),
    ),
  );
}

bool? st;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, st});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final User? _user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    if (_user != null) {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(_user.uid)
          .get();
      final userData = snapshot.data();
      if (userData != null) {
        setState(() {
          balance = userData['balance'];
        });
      }
    }
  }

  void addAmountToBalance(int amount) {
    setState(() {
      // Add amount to the balance
    });
  }

  Future onRefresh() async {
    await _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return Scaffold(
      body: LiquidPullToRefresh(
        onRefresh: onRefresh,
        animSpeedFactor: 10,
        showChildOpacityTransition: false,
        height: 90,
        backgroundColor: Styles.primaryColor,
        color: Styles.secondaryColor,
        child: ListView(scrollDirection: Axis.vertical, children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: Column(
                  children: [
                    const Gap(20),
                    Text(
                      "Wallet",
                      style: Styles.headLineStyle1.copyWith(fontSize: 38),
                    ),
                    const Gap(20),
                    SizedBox(
                      height: 130,
                      width: size.width * 0.75,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: [
                              Styles.secondaryColor,
                              Styles.secondary2Color,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "$balance L.E",
                                style: Styles.headLineStyle1.copyWith(
                                  color: Colors.white,
                                  fontSize: 38,
                                ),
                              ),
                              const Gap(10),
                              InkWell(
                                onTap: () {
                                  addMoneySheet(context);
                                },
                                child: Text(
                                  "Add Money",
                                  style: Styles.headLineStyle4.copyWith(
                                    color: Colors.white,
                                    fontSize: 27,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Gap(50),
                    Column(
                      children: [
                        const SettingButton(
                          text: "Personal Information",
                          bKey: 0,
                        ),
                        Divider(
                          color: Colors.grey.shade500,
                          endIndent: 50,
                          indent: 50,
                          thickness: 1.3,
                        ),
                        const SettingButton(
                          text: "Announcements",
                          bKey: 1,
                        ),
                        Divider(
                          color: Colors.grey.shade500,
                          endIndent: 50,
                          indent: 50,
                          thickness: 1.3,
                        ),
                        const SettingButton(
                          text: "Favorite",
                          bKey: 2,
                        ),
                        Divider(
                          color: Colors.grey.shade500,
                          endIndent: 50,
                          indent: 50,
                          thickness: 1.3,
                        ),
                        const SettingButton(
                          text: "Previous Trips",
                          bKey: 3,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ]),
      ),
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Profile',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(26, 96, 122, 1),
              ),
            ),
            TextButton(
              child: Text(
                "Logout",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AuthPage(),
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
