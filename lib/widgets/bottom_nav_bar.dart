import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:subtraingrad/Screens/Tickets/tickets_screen.dart';
import 'package:subtraingrad/Screens/Home/home_screen.dart';
import 'package:subtraingrad/Screens/Profile/profile_screen.dart';
import 'package:subtraingrad/Style/app_styles.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({
    super.key,
  });

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const TicketsScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions[_selectedIndex],
      ),
      bottomNavigationBar: FlashyTabBar(
        selectedIndex: _selectedIndex,
        height: 70,
        showElevation: true,
        onItemSelected: _onItemTapped,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 300),
        items: [
          FlashyTabBarItem(
            icon: Icon(FluentSystemIcons.ic_fluent_home_filled),
            title: Text(
              'Home',
              style: MyFonts.font18Black.copyWith(color: Styles.primaryColor),
            ),
            activeColor: Styles.primaryColor,
            inactiveColor: Styles.primaryColor,
          ),
          FlashyTabBarItem(
            icon: Icon(FluentSystemIcons.ic_fluent_ticket_filled),
            title: Text(
              'Tickets',
              style: MyFonts.font18Black.copyWith(color: Styles.primaryColor),
            ),
            activeColor: Styles.primaryColor,
            inactiveColor: Styles.primaryColor,
          ),
          FlashyTabBarItem(
            icon: Icon(FluentSystemIcons.ic_fluent_person_filled),
            title: Text(
              'Profile',
              style: MyFonts.font18Black.copyWith(color: Styles.primaryColor),
            ),
            activeColor: Styles.primaryColor,
            inactiveColor: Styles.primaryColor,
          ),
        ],
      ),
    );
  }
}
