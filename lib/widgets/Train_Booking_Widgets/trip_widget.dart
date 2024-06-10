import 'package:flutter/material.dart';
import 'package:subtraingrad/Style/app_styles.dart';

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
  final int price;
  const TrainTrip({
    super.key,
    required this.trainID,
    required this.availableSeats,
    required this.departureStation,
    required this.departureTime,
    required this.arrivalStation,
    required this.arrivalTime,
    required this.price,
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
              Expanded(
                  child:
                      Text("Train no: ${trainID}", style: MyFonts.font16Black)),
              Expanded(
                  child: Text("Seats: ${availableSeats}",
                      style: MyFonts.font16Black)),
              Expanded(child: Text("price: ${price}")),
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: Text(
                "From: ${departureStation}\n${departureTime}",
                style: MyFonts.font16Black,
              )),
              Expanded(
                  child: Text("To: ${arrivalStation}\n${arrivalTime}",
                      style: MyFonts.font16Black)),
            ],
          ),
        ],
      ),
    );
  }
}
