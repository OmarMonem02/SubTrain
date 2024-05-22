// ignore_for_file: unused_element

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:random_string/random_string.dart';
import 'package:subtraingrad/%D9%90Admin_Pages/admin_home_screen.dart';
import 'package:subtraingrad/Page/Screens/BookingProcess/Train/data/train_stations.dart';
import 'package:subtraingrad/Page/Screens/BookingProcess/Train/shared/widgets/dropdown.dart';
import 'package:subtraingrad/Page/Screens/auth/add_new_user.dart';
import 'package:subtraingrad/Page/Screens/auth/auth_page.dart';
import 'package:subtraingrad/Style/app_styles.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class AddTrainSchedule extends StatefulWidget {
  const AddTrainSchedule({super.key});

  @override
  State<AddTrainSchedule> createState() => _AddTrainScheduleState();
}

final TextEditingController arrivalStation = TextEditingController();
final TextEditingController departureStation = TextEditingController();
final TextEditingController trainID = TextEditingController();
final TextEditingController tripDate = TextEditingController();
String _startPoint = 'Select Start Point';
String _endPoint = 'Select End Point';
String _arrivalTime = "Arrival Time";
String _departureTime = 'Departure Time';
Future<void> addTrainTrip() async {
  String trainScheduleID = randomAlphaNumeric(10);
  Map<String, dynamic> scheduleInfoMap = {
    "trainScheduleID": trainScheduleID,
    "arrivalStation": arrivalStation.text,
    "departureStation": departureStation.text,
    "trainID": trainID.text,
    "tripDate": tripDate.text,
    "startPoint": _startPoint,
    "endPoint": _endPoint,
    "arrivalTime": _arrivalTime,
    "departureTime": _departureTime,
  };
  await DatabaseMethod().addTrainSchedule(scheduleInfoMap, trainScheduleID);
}

@override
void dispose() {
  arrivalStation.dispose();
  departureStation.dispose();
  trainID.dispose();
  tripDate.dispose();
}

class _AddTrainScheduleState extends State<AddTrainSchedule> {
  showArrivalTimePicker() async {
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
      minutesInterval: 1,
      secondsInterval: 1,
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
    setState(() {
      _arrivalTime = dateTime.toString();
    });
  }

  showDepartureTimePicker() async {
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
      minutesInterval: 1,
      secondsInterval: 1,
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
    setState(() {
      _departureTime = dateTime.toString();
    });
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
                      value: _startPoint, // validator: Validator.required,
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
                      value: _endPoint, // validator: Validator.required,
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
                        child: Text(_arrivalTime))),
                Expanded(
                    child: TextButton(
                        onPressed: () {
                          showDepartureTimePicker();
                        },
                        child: Text(_departureTime))),
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: SubTextField(
                        controller: arrivalStation,
                        hint: "Misr",
                        textLabel: "arrivalStation",
                        textInputType: TextInputType.text,
                        enable: true)),
                Expanded(
                    child: SubTextField(
                        controller: departureStation,
                        hint: "Luxor",
                        textLabel: "Departure Station",
                        textInputType: TextInputType.text,
                        enable: true)),
              ],
            ),
            Gap(16),
            Row(
              children: [
                Expanded(
                    child: SubTextField(
                        controller: tripDate,
                        hint: "15/6/2024",
                        textLabel: "Trip Date",
                        textInputType: TextInputType.text,
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
