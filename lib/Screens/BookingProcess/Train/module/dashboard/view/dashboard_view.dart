import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:subtraingrad/Screens/BookingProcess/Train/data/train_stations.dart';
import 'package:subtraingrad/Screens/BookingProcess/Train/module/seat_picker/view/seat_picker_view.dart';
import 'package:subtraingrad/Style/app_styles.dart';
import 'package:subtraingrad/widgets/Train_Booking_Widgets/datepicker.dart';
import 'package:subtraingrad/widgets/Train_Booking_Widgets/dropdown.dart';
import 'package:subtraingrad/widgets/Train_Booking_Widgets/trip_widget.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  Stream<QuerySnapshot>? _searchStream;
  String tripDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
  String trainClass = "";
  String from = "";
  String to = "";
  String departureStation = "";
  String arrivalStation = "";
  String departureTime = "";
  String arrivalTime = "";
  String tripID = "";
  int tripPrice = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Train Booking",
          style: MyFonts.appbar,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(15.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(12.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "From",
                        value: from,
                        items: TrainData.trainData,
                        onChanged: (value, label) {
                          setState(() {
                            from = value;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: QDropdownField(
                        label: "To",
                        value: to,
                        items: TrainData.trainData,
                        onChanged: (value, label) {
                          setState(() {
                            to = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Row(
                  children: [
                    Expanded(
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
                    const SizedBox(
                      width: 20.0,
                    ),
                    const Text(
                      "-",
                      style:
                          TextStyle(fontSize: 22.0, color: Color(0xff393e48)),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    Expanded(
                      child: QDropdownField(
                        label: "Train Classes",
                        value: trainClass,
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
                    )
                  ],
                ),
                const SizedBox(
                  height: 5.0,
                ),
                const SizedBox(
                  height: 5.0,
                ),
                SizedBox(
                  height: 48,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Styles.contrastColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _searchStream = FirebaseFirestore.instance
                            .collection("Train_Schedule")
                            .where("startPoint", isEqualTo: from)
                            .where("endPoint", isEqualTo: to)
                            .where("trainClass", isEqualTo: trainClass)
                            .where("tripDate", isEqualTo: tripDate)
                            .snapshots();
                      });
                    },
                    child: Text(
                      "Search",
                      style: MyFonts.font18White
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _searchStream,
              builder: (context, streamSnapshot) {
                if (streamSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (streamSnapshot.hasError) {
                  return Center(child: Text("Error: ${streamSnapshot.error}"));
                } else if (streamSnapshot.hasData) {
                  if (streamSnapshot.data!.docs.isEmpty) {
                    return const Center(child: Text("No results found"));
                  }

                  return ListView.builder(
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                          streamSnapshot.data!.docs[index];

                      // Calculate trueCount for this document
                      int documentTrueCount = 0;
                      Map<String, dynamic>? availableSeats =
                          documentSnapshot['availableSeats'];
                      Map<String, Map<String, bool>> seats = {};
                      if (availableSeats != null) {
                        availableSeats.forEach((key, value) {
                          if (value is Map<String, dynamic>) {
                            Map<String, bool> innerSeats = {};
                            value.forEach((innerKey, innerValue) {
                              if (innerValue is bool) {
                                innerSeats[innerKey] = innerValue;
                                if (innerValue) {
                                  documentTrueCount++;
                                }
                              }
                            });
                            seats[key] = innerSeats;
                          }
                        });
                      }

                      return InkWell(
                        onTap: () {
                          setState(() {
                            tripID = documentSnapshot['trainScheduleID'];
                            tripPrice = documentSnapshot['price'];
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SeatPickerView(
                                seats: seats,
                                tripID: tripID,
                              ),
                            ),
                          );
                        },
                        child: Center(
                          child: TrainTrip(
                            departureStation:
                                documentSnapshot['departureStation'],
                            arrivalStation: documentSnapshot['arrivalStation'],
                            departureTime: documentSnapshot['departureTime'],
                            arrivalTime: documentSnapshot['arrivalTime'],
                            trainID: documentSnapshot['trainID'],
                            availableSeats: documentTrueCount,
                            price: documentSnapshot['price'],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(child: Text("Select Your Trip Option"));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
