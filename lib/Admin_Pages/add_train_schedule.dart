// ignore_for_file: unused_element

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';
import 'package:subtraingrad/Admin_Pages/ticket_validator.dart';
import 'package:subtraingrad/Admin_Pages/seats.dart';
import 'package:subtraingrad/Screens/BookingProcess/Train/data/train_stations.dart';
import 'package:subtraingrad/widgets/Train_Booking_Widgets/datepicker.dart';
import 'package:subtraingrad/widgets/Train_Booking_Widgets/dropdown.dart';
import 'package:subtraingrad/Screens/auth/add_new_data.dart';
import 'package:subtraingrad/Screens/auth/auth_page.dart';
import 'package:subtraingrad/Style/app_styles.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class AddTrainSchedule extends StatefulWidget {
  const AddTrainSchedule({super.key});

  @override
  State<AddTrainSchedule> createState() => _AddTrainScheduleState();
}

class _AddTrainScheduleState extends State<AddTrainSchedule> {
  final TextEditingController arrivalStation = TextEditingController();
  final TextEditingController departureStation = TextEditingController();
  final TextEditingController trainID = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  String tripDate = "";
  String _startPoint = 'Select Start Point';
  String _endPoint = 'Select End Point';
  String _arrivalTime = "Arrival Time";
  String _departureTime = 'Departure Time';
  String trainClass = 'Train Class';

  Map<String, Map<String, bool>> availableSeats = Seats.availableSeats;

  @override
  void dispose() {
    arrivalStation.dispose();
    departureStation.dispose();
    trainID.dispose();
    super.dispose();
  }

  Future<void> addTrainTrip() async {
    if (arrivalStation.text.isEmpty ||
        departureStation.text.isEmpty ||
        trainID.text.isEmpty ||
        tripDate.isEmpty ||
        _startPoint == 'Select Start Point' ||
        _endPoint == 'Select End Point' ||
        _arrivalTime == 'Arrival Time' ||
        _departureTime == 'Departure Time' ||
        trainClass == 'Train Class') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill all fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    String trainScheduleID = randomAlphaNumeric(20);
    Map<String, dynamic> scheduleInfoMap = {
      "trainScheduleID": trainScheduleID,
      "departureStation": departureStation.text,
      "arrivalStation": arrivalStation.text,
      "trainID": trainID.text,
      "tripDate": tripDate,
      "trainClass": trainClass,
      "startPoint": _startPoint,
      "endPoint": _endPoint,
      "arrivalTime": _arrivalTime,
      "departureTime": _departureTime,
      "availableSeats": availableSeats,
      "price": priceController,
    };

    try {
      await DatabaseMethod().addTrainSchedule(scheduleInfoMap, trainScheduleID);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Train trip added successfully'),
          backgroundColor: Colors.green,
        ),
      );
      // Reset all fields
      setState(() {
        arrivalStation.clear();
        departureStation.clear();
        trainID.clear();
        priceController.clear();
        tripDate = "";
        _startPoint = 'Select Start Point';
        _endPoint = 'Select End Point';
        _arrivalTime = "Arrival Time";
        _departureTime = 'Departure Time';
        trainClass = 'Train Class';
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to add train trip'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> showArrivalTimePicker() async {
    DateTime? dateTime = await showOmniDateTimePicker(
      context: context,
      separator: Text("Time"),
      type: OmniDateTimePickerType.dateAndTime,
      initialDate: DateTime.now(),
      firstDate: DateTime(1600).subtract(const Duration(days: 3652)),
      lastDate: DateTime.now().add(
        const Duration(days: 2024),
      ),
      is24HourMode: false,
      isForce2Digits: true,
      isShowSeconds: false,
      minutesInterval: 5,
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      constraints: const BoxConstraints(
        maxWidth: 350,
        maxHeight: 650,
      ),
      transitionBuilder: (context, anim1, anim2, child) {
        return FadeTransition(
          opacity: anim1.drive(
            Tween(
              begin: 0,
              end: 1,
            ),
          ),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: false,
    );

    if (dateTime != null) {
      setState(() {
        _departureTime = DateFormat('dd-MM-yyyy hh:mm:a').format(dateTime);
      });
    }
  }

  Future<void> showDepartureTimePicker() async {
    DateTime? dateTime = await showOmniDateTimePicker(
      context: context,
      separator: Text("Time"),
      type: OmniDateTimePickerType.dateAndTime,
      initialDate: DateTime.now(),
      firstDate: DateTime(1600).subtract(const Duration(days: 3652)),
      lastDate: DateTime.now().add(
        const Duration(days: 2024),
      ),
      is24HourMode: false,
      isForce2Digits: true,
      isShowSeconds: false,
      minutesInterval: 5,
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      constraints: const BoxConstraints(
        maxWidth: 350,
        maxHeight: 650,
      ),
      transitionBuilder: (context, anim1, anim2, child) {
        return FadeTransition(
          opacity: anim1.drive(
            Tween(
              begin: 0,
              end: 1,
            ),
          ),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: false,
    );

    if (dateTime != null) {
      setState(() {
        _arrivalTime = DateFormat('dd-MM-yyyy hh:mm:a').format(dateTime);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(bottom: 8, left: 8, right: 8, top: 4),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Start Point",
                      value: _startPoint,
                      items: TrainData.trainData,
                      onChanged: (value, label) {
                        setState(() {
                          _startPoint = value.toString();
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: QDropdownField(
                      label: "End Point",
                      value: _endPoint,
                      items: TrainData.trainData,
                      onChanged: (value, label) {
                        setState(() {
                          _endPoint = value.toString();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: TextButton(
                        onPressed: () {
                          showArrivalTimePicker();
                        },
                        child: Text(_departureTime))),
                Expanded(
                    child: TextButton(
                        onPressed: () {
                          showDepartureTimePicker();
                        },
                        child: Text(_arrivalTime))),
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: SubTextField(
                        controller: departureStation,
                        hint: "Misr",
                        textLabel: "Departure Station",
                        textInputType: TextInputType.text,
                        enable: true)),
                Expanded(
                    child: SubTextField(
                        controller: arrivalStation,
                        hint: "Luxor",
                        textLabel: "Arrival Station",
                        textInputType: TextInputType.text,
                        enable: true)),
              ],
            ),
            Gap(16),
            Row(
              children: [
                Expanded(
                    child: SubTextField(
                        controller: priceController,
                        hint: "Trip Price",
                        textLabel: "Trip Price",
                        textInputType: TextInputType.number,
                        enable: true)),
                Expanded(
                    child: SubTextField(
                        controller: trainID,
                        hint: "6",
                        textLabel: "Train ID",
                        textInputType: TextInputType.text,
                        enable: true)),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: QDropdownField(
                      label: "Train Classes",
                      value: "",
                      // validator: Validator.required,
                      items: const [
                        {
                          "label": "PLD Special",
                          "value": "PLD Special",
                        },
                        {
                          "label": "PLD Speed",
                          "value": "PLD Speed",
                        },
                        {
                          "label": "PLD TALGO",
                          "value": "PLD TALGO",
                        },
                      ],
                      onChanged: (value, label) {
                        setState(() {
                          trainClass = value;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 16),
                    child: QDatePicker(
                      label: "Date",
                      value: DateTime.now(),
                      onChanged: (value) {
                        setState(() {
                          tripDate = DateFormat('dd/MM/yyyy').format(value);
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(8),
              child: SizedBox(
                height: 48,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xfffdc620),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () async {
                    await addTrainTrip();
                  },
                  child: const Text(
                    "Add",
                    style: TextStyle(
                      color: Color(0xff383d47),
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const TicketValidator();
            }));
          },
          elevation: 10,
          backgroundColor: Colors.white,
          tooltip: "Valid Ticket",
          child: Icon(Icons.qr_code_scanner)),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Dashboard"),
            IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AuthPage(),
                    ));
              },
              icon: Icon(
                Icons.logout_rounded,
                color: Colors.red.shade700,
              ),
              iconSize: 35,
            ),
          ],
        ),
      ),
    );
  }
}
