import 'package:flutter/material.dart';
import 'package:subtraingrad/Style/app_styles.dart';

class TrainBooking extends StatelessWidget {
  const TrainBooking({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.amber,
    );
  }
}

class SubwayBooking extends StatelessWidget {
  const SubwayBooking({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.bdColor,
      body: SafeArea(
          child: ListView(
        children: const [
          Column(
            children: [],
          )
        ],
      )),
    );
  }
}
