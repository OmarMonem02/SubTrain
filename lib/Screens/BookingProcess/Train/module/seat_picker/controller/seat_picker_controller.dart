import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import '../../../state_util.dart';
import '../view/seat_picker_view.dart';

class SeatPickerController extends State<SeatPickerView>
    implements MvcController {
  static late SeatPickerController instance;
  late SeatPickerView view;

  int counter = 0;
  int tPrice = 0;
  int totalAmount = 0;
  String category = "";
  List<int> usedSeats = [];
  List<int> selectedSeats = [];
  List<int> unclickableSeats = [];
  static const int maxSeats = 4;

  String selectedRow = "A"; // Default row

  @override
  void initState() {
    instance = this;
    super.initState();

    // Initialize usedSeats and unclickableSeats based on the seats map
    widget.seats.forEach((rowKey, rowValue) {
      rowValue.forEach((seatKey, seatValue) {
        int seatIndex = int.parse(seatKey) - 1; // Adjust index to start from 0
        if (!seatValue) {
          unclickableSeats.add(seatIndex);
        }
      });
    });
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) {
    view = widget;
    return SeatPickerViewBody(controller: this);
  }

  void updateSeat(BuildContext context, int index) {
    if (selectedSeats.contains(index) || unclickableSeats.contains(index))
      return;

    setState(() {
      if (!usedSeats.contains(index)) {
        if (usedSeats.length < maxSeats) {
          usedSeats.add(index);
          counter++;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('You can select a maximum of $maxSeats seats.'),
            ),
          );
        }
      } else {
        usedSeats.remove(index);
        counter--;
      }
    });
  }


  void selectRow(String row) {
    setState(() {
      selectedRow = row;
    });
  }

  List<int> getAvailableSeatsForRow(String row) {
    List<int> availableSeats = [];
    if (widget.seats.containsKey(row)) {
      widget.seats[row]!.forEach((seatKey, seatValue) {
        int seatIndex = int.parse(seatKey) - 1; // Adjust index to start from 0
        if (seatValue) {
          availableSeats.add(seatIndex);
        }
      });
    }
    return availableSeats;
  }
}
