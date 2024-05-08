import 'package:flutter/material.dart';

import 'Page/Screens/BookingProcess/Train/module/dashboard/view/dashboard_view.dart';
import 'Page/Screens/auth/auth_page.dart';
import 'widgets/bottom_nav_bar.dart';

final Map<String, WidgetBuilder> routes = {
  'auth': (context) => const AuthPage(),
  'home': (context) => const BottomNavBar(),
  'trainBook': (context) => const DashboardView(),
};
