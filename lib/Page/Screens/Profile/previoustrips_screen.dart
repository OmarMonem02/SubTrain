import 'package:flutter/material.dart';
import 'package:subtraingrad/Style/app_styles.dart';

class PreviousTrips extends StatelessWidget {
  const PreviousTrips({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Previous Trips",
              style: Styles.headLineStyle2,
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.abc_rounded))
          ],
        ),
      ),
    );
  }
}
