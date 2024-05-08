import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:subtraingrad/Page/Screens/Profile/settings_screen.dart';
import 'package:subtraingrad/Style/app_layout.dart';
import 'package:subtraingrad/Style/app_styles.dart';
import 'package:subtraingrad/widgets/setting_button.dart';
import 'package:subtraingrad/widgets/add_money.dart';

int balance = 300;
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
        child: AddMoney(
          addAmountToBalance: (int amount) {
            balance += amount;
          },
        ),
      ),
    ),
  );
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void addAmountToBalance(int amount) {
    setState(() {
      balance += amount; // Add amount to the balance
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: Column(
              children: [
                Text(
                  "Balance",
                  style: Styles.headLineStyle1
                      .copyWith(color: Colors.black, fontSize: 38),
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
                          Styles.secColor,
                          Styles.sec2Color,
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
      appBar: AppBar(
        toolbarHeight: 60,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
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
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingPage(),
                  ),
                );
              },
              icon: const Icon(FluentSystemIcons.ic_fluent_settings_filled),
              iconSize: 40,
              color: Styles.mainColor,
            ),
          ],
        ),
      ),
    );
  }
}
