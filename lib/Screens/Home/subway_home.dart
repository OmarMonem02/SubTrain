import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:subtraingrad/Screens/BookingProcess/Subway/subway_booking_screen.dart';
import 'package:subtraingrad/Style/app_layout.dart';
import 'package:subtraingrad/Style/app_styles.dart';
import 'package:subtraingrad/widgets/recent_trip_card.dart';

class SubwayHome extends StatelessWidget {
  const SubwayHome({super.key});

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return Column(
      children: [
        const Gap(8),
        // Button Part
        Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SubwayBookingScreen()),
              );
            },
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    Styles.secondary2Color,
                    Styles.secondaryColor,
                  ],
                ),
              ),
              child: Container(
                width: size.width * 0.80,
                height: 110,
                alignment: Alignment.center,
                child: Text(
                  'Book Subway Ticket',
                  textAlign: TextAlign.center,
                  style: MyFonts.font24Black,
                ),
              ),
            ),
          ),
        ),
        const Gap(16),
        SizedBox(
          width: size.width * 0.90,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Recent Trips", style: MyFonts.font18Black),
              InkWell(
                onTap: () {},
                child: Text(
                  "View all",
                  style: MyFonts.font18Black,
                ),
              ),
            ],
          ),
        ),
        const Gap(20),
        const RecentTripCard(),
        const Gap(16),
      ],
    );
  }
}
