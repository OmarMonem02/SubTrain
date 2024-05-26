import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AnnouncementPost extends StatelessWidget {
  final String date;
  final String massage;
  final String header;
  const AnnouncementPost(
      {super.key,
      required this.date,
      required this.massage,
      required this.header});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(
        bottom: 0,
        left: 8,
        right: 8,
        top: 8,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        // color: Colors.amberAccent,
        color: const Color.fromARGB(255, 240, 240, 240),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                header,
                style: TextStyle(fontSize: 16),
              ),
              Text(
                date,
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
          const Gap(8),
          Text(
            massage,
            style: TextStyle(fontSize: 16),
          )
        ],
      ),
    );
  }
}
