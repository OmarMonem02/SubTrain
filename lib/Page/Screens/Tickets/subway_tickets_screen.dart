import 'package:flutter/material.dart';
import 'package:subtraingrad/widgets/Ticket.dart';

class SubwayTicketsScreen extends StatefulWidget {
  const SubwayTicketsScreen({super.key});

  @override
  State<SubwayTicketsScreen> createState() => _SubwayTicketsScreenState();
}

class _SubwayTicketsScreenState extends State<SubwayTicketsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TicketActive(),
            TicketActive(),
            TicketActive(),
            TicketActive(),
            TicketActive(),
            TicketActive(),
          ],
        ),
      ),
      // body: StreamBuilder(stream: stream, builder: builder),
    );
  }
}
