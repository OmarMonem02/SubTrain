import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:subtraingrad/%D9%90Admin_Pages/add_train_schedule.dart';
import 'package:subtraingrad/Page/Screens/auth/welcome_screen.dart';
import 'package:subtraingrad/widgets/bottom_nav_bar.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});
  final userData = FirebaseFirestore.instance.collection("users");
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (user?.email == "admin@gmail.com") {
              return const AddTrainSchedule();
            } else {
              return const BottomNavBar();
            }
          } else {
            return const Welcome();
          }
        },
      ),
    );
  }
}
