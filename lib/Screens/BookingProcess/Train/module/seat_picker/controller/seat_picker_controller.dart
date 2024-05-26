import 'package:flutter/material.dart';
import '../../../state_util.dart';
import '../view/seat_picker_view.dart';

class SeatPickerController extends State<SeatPickerView> implements MvcController {
  static late SeatPickerController instance;
  late SeatPickerView view;

  int counter = 0;
  int tPrice = 0;
  int totalAmount = 0;
  String category = "";
  List<int> usedSeats = [];
  List<int> selectedSeats = [];

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) {
    return SeatPickerViewBody(controller: this);
  }

  void updateSeat(int index) {
    if (selectedSeats.contains(index)) return;

    setState(() {
      if (!usedSeats.contains(index)) {
        usedSeats.add(index);
        counter++;
      } else {
        usedSeats.remove(index);
        counter--;
      }
    });
  }
}
