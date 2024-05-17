import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:subtraingrad/Page/Screens/BookingProcess/Train/module/dashboard/view/dashboard_view.dart';
import 'package:subtraingrad/Style/app_layout.dart';
import 'package:subtraingrad/Style/app_styles.dart';
import 'package:subtraingrad/widgets/recent_trip_card.dart';
import 'package:subtraingrad/widgets/ticket_view.dart';

class TrainHome extends StatelessWidget {
  const TrainHome({super.key});

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);

    return Column(
      children: [
        const Gap(8),
        Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () {
              Navigator.push(context,MaterialPageRoute(builder: (context) => const DashboardView(),));
            },
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    Styles.mainColor,
                    Styles.main2Color,
                  ],
                ),
              ),
              child: Container(
                width: size.width * 0.80,
                height: 110,
                alignment: Alignment.center,
                child: const Text(
                  'Book Train Ticket',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        const Gap(20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Upcoming Trips", style: Styles.headLineStyle2),
              InkWell(
                onTap: () {},
                child: Text(
                  "View all",
                  style: Styles.textStyle.copyWith(color: Styles.mainColor),
                ),
              ),
            ],
          ),
        ),
        const Gap(20),
        const SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.only(left: 20),
          child: Row(
            children: [
              TicketView(
                sPoint: "CAI", // Start Point
                lsPoint: "Cairo", // Label Start Point
                ePoint: "ASW", // End Point
                lePoint: "Aswan", // Label End Point
                dur: "18H 30M", // Duration
                date: "1 AUG", // Date
                depTime: "08:00AM", // Departure Time
                tNum: "152", // Train Number
              ),
            ],
          ),
        ),
        const Gap(16),
        SizedBox(
          width: size.width * 0.90,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Recent Trips", style: Styles.headLineStyle2),
              InkWell(
                onTap: () {},
                child: Text(
                  "View all",
                  style: Styles.textStyle.copyWith(color: Styles.mainColor),
                ),
              ),
            ],
          ),
        ),
        const Gap(20),
        const RecentTripCard(),
      ],
    );
  }
}
