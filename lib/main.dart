import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:subtraingrad/Page/Screens/auth/main_page.dart';
import 'package:subtraingrad/Theme/dark_theme.dart';
import 'package:subtraingrad/Theme/light_theme.dart';
import 'package:subtraingrad/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyBm_Xb6LVM20OLYCRhYne45-hOt9P6xrqU",
        appId: "1:198914408979:android:d7afd1361345d47fd4f5e6",
        messagingSenderId: "198914408979",
        projectId: "subtraingrad"),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      routes: routes,
      home: AnimatedSplashScreen(
        duration: 2500,
        backgroundColor: Theme.of(context).colorScheme.background,
        splashIconSize: 300,
        splash: Lottie.asset('assets/splash.json'),
        nextScreen: MainPage(),
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.fade,
      ),
    );
  }
}
