import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:subtraingrad/Screens/Tickets/tickets_screen.dart';
import 'package:subtraingrad/Screens/Home/home_screen.dart';
import 'package:subtraingrad/Screens/Profile/profile_screen.dart';

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
        showElevation: true,
        onItemSelected: _onItemTapped,
        items: [
          FlashyTabBarItem(
            icon: Icon(FluentSystemIcons.ic_fluent_home_filled),
            title: Text('Home'),
            activeColor: Color.fromRGBO(26, 96, 122, 1),
            inactiveColor: Color.fromRGBO(26, 96, 122, 1),
          ),
          FlashyTabBarItem(
            icon: Icon(FluentSystemIcons.ic_fluent_ticket_filled),
            title: Text('Tickets'),
            activeColor: Color.fromRGBO(26, 96, 122, 1),
            inactiveColor: Color.fromRGBO(26, 96, 122, 1),
          ),
          FlashyTabBarItem(
            icon: Icon(FluentSystemIcons.ic_fluent_person_filled),
            title: Text('Profile'),
            activeColor: Color.fromRGBO(26, 96, 122, 1),
            inactiveColor: Color.fromRGBO(26, 96, 122, 1),
          ),
        ],
      ),
    );
  }
}
