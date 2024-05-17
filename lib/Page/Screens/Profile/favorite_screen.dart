import 'package:flutter/material.dart';
import 'package:subtraingrad/Style/app_styles.dart';

class Favorite extends StatelessWidget {
  const Favorite({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Fevorites",
              style: Styles.headLineStyle2.copyWith(color: Colors.black),
            ),
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.favorite_border_rounded))
          ],
        ),
      ),
    );
  }
}
