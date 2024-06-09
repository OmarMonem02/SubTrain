import 'package:flutter/material.dart';
import 'package:subtraingrad/Screens/Tickets/subway_tickets_screen.dart';
import 'package:subtraingrad/Screens/Tickets/train_tickets_screen.dart';
import 'package:subtraingrad/Style/app_styles.dart';

class TicketsScreen extends StatefulWidget {
  const TicketsScreen({super.key});

  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Tickets",
                style: MyFonts.appbar,
              ),
            ],
          ),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Styles.primaryColor,
            tabs: [
              Tab(
                child: Text(
                  "Train Tickets",
                  style: MyFonts.font16Black,
                ),
                icon: Icon(
                  Icons.train_outlined,
                  size: 30,
                  color: Styles.primaryColor,
                ),
              ),
              Tab(
                child: Text(
                  "Subway Tickets",
                  style: MyFonts.font16Black,
                ),
                icon: Icon(
                  Icons.subway_outlined,
                  size: 30,
                  color: Styles.primaryColor,
                ),
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            TrainTicketsScreen(),
            SubwayTicketsScreen(),
          ],
        ),
      ),
    );
  }
}
