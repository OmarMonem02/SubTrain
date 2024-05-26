import 'package:flutter/material.dart';

class TrainTrip extends StatelessWidget {
  // final String arrivalStation;
  // final String departureStation;
  // final String tripDate;
  final String arrivalTime;
  final String departureTime;
  final String departureStation;
  final String arrivalStation;
  final String trainID;
  final int availableSeats;
  const TrainTrip({
    super.key,
    // required this.arrivalStation,
    // required this.tripDate,
    // required this.departureStation,
    required this.trainID,
    required this.availableSeats,
    required this.departureStation,
    required this.departureTime,
    required this.arrivalStation,
    required this.arrivalTime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color.fromARGB(255, 225, 225, 225),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: Text("Train no: ${trainID}")),
              Expanded(child: Text("Seats: ${availableSeats}")),
              // Expanded(child: Text("Date: ${tripDate}")),
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: Text("From\n${departureStation}\n${departureTime}")),
              Expanded(child: Text("To\n${arrivalStation}\n${arrivalTime}")),
            ],
          ),
        ],
      ),
    );
  }
}
