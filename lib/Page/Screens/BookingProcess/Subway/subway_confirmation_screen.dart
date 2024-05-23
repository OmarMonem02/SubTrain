import 'package:flutter/material.dart';

class SubwayConfirmationScreen extends StatelessWidget {
  final String startStation;
  final String endStation;
  final int ticketPrice;
  final int numberOfTickets;

  const SubwayConfirmationScreen({
    Key? key,
    required this.startStation,
    required this.endStation,
    required this.ticketPrice,
    required this.numberOfTickets,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ticket Confirmation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Start Station: $startStation', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('End Station: $endStation', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Ticket Price: \$${ticketPrice * numberOfTickets}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Number of Tickets: $numberOfTickets', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Confirm', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
