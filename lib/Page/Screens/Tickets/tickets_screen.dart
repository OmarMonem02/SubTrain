import 'package:flutter/material.dart';
import 'package:subtraingrad/Page/Screens/Tickets/subway_tickets_screen.dart';
import 'package:subtraingrad/Page/Screens/Tickets/train_tickets_screen.dart';

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
          title: const Text("Tickets"),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(
                text: "Train Tickets",
                icon: Icon(
                  Icons.train_outlined,
                ),
              ),
              Tab(
                text: "Subway Tickets",
                icon: Icon(Icons.subway_outlined),
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
