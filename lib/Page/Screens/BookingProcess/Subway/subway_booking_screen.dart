import 'package:flutter/material.dart';

class Subway extends StatefulWidget {
  const Subway({super.key});

  @override
  State<Subway> createState() => _SubwayState();
}

class _SubwayState extends State<Subway> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
      appBar: AppBar(
        elevation: 0,
        title: const Text('Subway Booking'),
      ),
    );
  }
}
