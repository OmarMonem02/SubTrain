import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:quickalert/quickalert.dart';
import 'package:random_string/random_string.dart';
import 'package:searchfield/searchfield.dart';
import 'package:subtraingrad/Payments/Paymob_Manager/paymob_manager.dart';
import 'package:subtraingrad/Payments/withdraw_payment_getway.dart';
import 'package:subtraingrad/Screens/BookingProcess/Subway/data/station_location.dart';
import 'package:subtraingrad/Screens/BookingProcess/Subway/data/subway_stations.dart';
import 'package:subtraingrad/Screens/auth/add_new_data.dart';
import 'package:subtraingrad/test.dart';
import 'package:subtraingrad/widgets/bottom_nav_bar.dart';
import 'package:subtraingrad/widgets/path_finder.dart';
import 'package:subtraingrad/widgets/search.dart';

class SubwayBookingScreen extends StatefulWidget {
  const SubwayBookingScreen({super.key});

  @override
  State<SubwayBookingScreen> createState() => _SubwayBookingScreenState();
}

class _SubwayBookingScreenState extends State<SubwayBookingScreen> {
  int _counter = 1;
  int _value = 1;
  bool scanning = true;
  String? address, coordinates;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  String? start;
  String? end;
  int price = 0;
  int? balance;
  int totalPrice = 0;

  List<String> path = [];
  int pathLength = 0;
  List<String> suggestions = SubwayData.suggestions;
  Map<String, Map<String, int>> graph = SubwayData.graph;
  TextEditingController startSearchController = TextEditingController();
  final focus = FocusNode();
  final TextEditingController endSearchController = TextEditingController();
  final focus2 = FocusNode();

  showPathFinder(context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.45,
        maxChildSize: 0.63,
        minChildSize: 0.44,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          child: PathFinder(
            path: path,
            pathLength: pathLength,
          ),
        ),
      ),
    );
  }

  void calculatePath() {
    setState(() {
      start = startSearchController.text;
      end = endSearchController.text;
      path = findShortestPath(graph, start!, end!);
      pathLength = path.length;
      if (pathLength <= 9) {
        price = 6;
      } else if (pathLength <= 16) {
        price = 8;
      } else if (pathLength <= 23) {
        price = 12;
      } else if (pathLength > 23) {
        price = 15;
      }
    });
  }

  final User? _user = FirebaseAuth.instance.currentUser;

  Future<void> _fetchData() async {
    if (_user != null) {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(_user.uid)
          .get();
      final userData = snapshot.data();
      if (userData != null) {
        setState(() {
          balance = userData['balance'];
        });
      }
    }
  }

  bool _suggestionTapped = false;

  @override
  void initState() {
    _fetchData();
    getLocationAndNearestStation();
    super.initState();
  }

  Widget searchChild(x) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 12),
        child:
            Text(x, style: const TextStyle(fontSize: 18, color: Colors.black)),
      );
  @override
  void dispose() {
    startSearchController.dispose();
    focus.dispose();
    endSearchController.dispose();
    focus2.dispose();

    super.dispose();
  }

  String nearestStationName = '';

  Future<void> addTicket(useriD) async {
    final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    final String date = dateFormat.format(DateTime.now());
    String ticketId = randomAlphaNumeric(20);
    Map<String, dynamic> ticketInfoMap = {
      'subwayTicketID': ticketId,
      "userID": useriD,
      "bookingDate": date,
      "startPoint": startSearchController.text,
      "endPoint": endSearchController.text,
      "fare": price,
      "status": "New",
    };
    await DatabaseMethod().addSubwayTicket(ticketInfoMap, ticketId, useriD);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            children: [
              CustomSearchField(
                hint: 'Start Station',
                suggestions: suggestions,
                controller: startSearchController,
                onSearchTextChanged: (query) {
                  if (_suggestionTapped) {
                    _suggestionTapped = false;
                    return [];
                  }
                  final filter = suggestions
                      .where((element) =>
                          element.toLowerCase().contains(query.toLowerCase()))
                      .toList();
                  return filter
                      .map((e) =>
                          SearchFieldListItem<String>(e, child: searchChild(e)))
                      .toList();
                },
                onSuggestionTap: (SearchFieldListItem<String> x) {
                  setState(() {
                    _suggestionTapped = true;
                  });
                  calculatePath();
                },
              ),
              const SizedBox(height: 16),
              CustomSearchField(
                hint: 'End Station',
                suggestions: suggestions,
                controller: endSearchController,
                onSearchTextChanged: (query) {
                  final filter = suggestions
                      .where((element) =>
                          element.toLowerCase().contains(query.toLowerCase()))
                      .toList();
                  return filter
                      .map((e) =>
                          SearchFieldListItem<String>(e, child: searchChild(e)))
                      .toList();
                },
                onSuggestionTap: (SearchFieldListItem<String> x) {
                  calculatePath();
                },
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      getLocationAndNearestStation();
                      setState(() {
                        startSearchController.text = nearestStationName;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Color.fromRGBO(26, 96, 122, 1)),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.red,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Auto Locate',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showPathFinder(context);
                    },
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Color.fromRGBO(26, 96, 122, 1)),
                    child: const Text(
                      'Show My Path',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Text(
                    'Total Amount: ${_counter * price}LE',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OutlinedButton(
                          onPressed: _counter == 1 ? null : _decrementCounter,
                          style: ButtonStyle(
                            side: MaterialStateProperty.resolveWith<BorderSide>(
                              (Set<MaterialState> states) {
                                Color borderColor = Colors.black;
                                if (states.contains(MaterialState.pressed)) {
                                  borderColor =
                                      Color.fromARGB(255, 56, 88, 103);
                                }
                                return BorderSide(color: borderColor);
                              },
                            ),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            overlayColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(255, 56, 88, 103)
                                    .withOpacity(0.5)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                            ),
                            elevation: MaterialStateProperty.all<double>(0),
                          ),
                          child: Text(
                            '-',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Text(
                          '$_counter',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 16),
                        OutlinedButton(
                          onPressed: _incrementCounter,
                          style: ButtonStyle(
                            side: MaterialStateProperty.resolveWith<BorderSide>(
                              (Set<MaterialState> states) {
                                Color borderColor = Colors.black;
                                if (states.contains(MaterialState.pressed)) {
                                  borderColor =
                                      Color.fromARGB(255, 56, 88, 103);
                                }
                                return BorderSide(color: borderColor);
                              },
                            ),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            overlayColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(255, 56, 88, 103)
                                    .withOpacity(0.5)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                            ),
                            elevation: MaterialStateProperty.all<double>(0),
                          ),
                          child: Text(
                            '+',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      border: Border.all(
                        color: Color.fromRGBO(26, 96, 122, 1),
                        width: 2.5,
                      ),
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Radio(
                          value: 1,
                          groupValue: _value,
                          onChanged: (value) {
                            setState(() {
                              _value = value!;
                              print(_value);
                            });
                          },
                          activeColor: Color.fromRGBO(26, 96, 122, 1),
                        ),
                        Icon(Icons.credit_card, color: Colors.yellow),
                        SizedBox(width: 16.0),
                        Text(
                          'Pay with PayMob',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Container(
                    width: double.infinity,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      border: Border.all(
                        color: Color.fromRGBO(26, 96, 122, 1),
                        width: 2.5,
                      ),
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Radio(
                          value: 2,
                          groupValue: _value,
                          onChanged: (value) {
                            setState(() {
                              _value = value!;
                              print(_value);
                            });
                          },
                          activeColor: Color.fromRGBO(26, 96, 122, 1),
                        ),
                        Icon(Icons.account_balance_wallet,
                            color: Colors.yellow),
                        SizedBox(width: 16.0),
                        Text(
                          'Pay with App Wallet',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Spacer(),
                        Text(
                          balance.toString(),
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              SizedBox(
                height: 8,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_value == 1) {
                    _pay();
                  } else if (_value == 2) {
                    if (balance! < (price * _counter)) {
                      QuickAlert.show(
                          context: context,
                          type: QuickAlertType.error,
                          text: "You don't have balance!",
                          onConfirmBtnTap: () async {
                            Navigator.pop(context);
                          });
                    } else if (balance! >= (price * _counter)) {
                      QuickAlert.show(
                          context: context,
                          type: QuickAlertType.confirm,
                          text: 'Are you sure you want buy it by Wallet!',
                          confirmBtnText: 'Yes',
                          cancelBtnText: 'No',
                          confirmBtnColor: Colors.lightGreen,
                          animType: QuickAlertAnimType.slideInUp,
                          onCancelBtnTap: () async {
                            Navigator.pop(context);
                          },
                          onConfirmBtnTap: () async {
                            Navigator.pop(context);
                            int count = _counter;
                            for (count; 0 < count; count--) {
                              addTicket(_user!.uid);
                            }
                            _updateData();
                            QuickAlert.show(
                                context: context,
                                type: QuickAlertType.success,
                                text: "Your Ticket is Purchased!",
                                onConfirmBtnTap: () async {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => BottomNavBar(),
                                      ));
                                });
                          });
                    }
                  }
                  print(_value);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Color.fromRGBO(238, 238, 238, 1),
                ),
                child: const Text(
                  'Confirm',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        title: const Text('Subway Booking'),
      ),
    );
  }

  Future<void> _updateData() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(_user!.uid)
        .update({
      'balance': FieldValue.increment(-(price * _counter)),
    });
  }

  void _pay() async {
    int amount = price * _counter;

    PaymobManager().getPaymentKey(amount, "EGP").then(
      (String paymentKey) async {
        bool? paymentResult = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WithdrawPaymentGetway(
              paymentToken: paymentKey,
              amount: amount,
            ),
          ),
        );

        if (paymentResult != null && paymentResult) {
          // Handle successful payment
          int count = _counter;
          for (count; 0 < count; count--) {
            addTicket(_user!.uid);
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Payment Successfully.'),
              backgroundColor: Colors.green,
            ),
          );
          // You can add further actions like updating the UI or database
        } else {
          // Handle failed payment
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Payment failed! Please try again.'),
              backgroundColor: Colors.red,
            ),
          );
          // You can add further actions like showing an error message
        }
      },
    ).whenComplete(() {
      // Any cleanup code if necessary
    });
  }

  List<String> findShortestPath(
      Map<String, Map<String, int>> graph, String start, String end) {
    Map<String, double> distances = {};

    Map<String, String?> previous = {};

    Set<String> unvisited = Set.from(graph.keys);

    for (var node in graph.keys) {
      distances[node] = double.infinity;
    }
    distances[start] = 0;

    while (unvisited.isNotEmpty) {
      String? currentNode =
          unvisited.reduce((a, b) => distances[a]! < distances[b]! ? a : b);

      unvisited.remove(currentNode);

      if (currentNode == end) {
        List<String> path = [];
        while (previous[currentNode] != null) {
          path.insert(0, currentNode!);
          currentNode = previous[currentNode];
        }
        path.insert(0, start);
        return path;
      }

      for (var neighbor in graph[currentNode]!.keys) {
        double altDistance =
            distances[currentNode]! + graph[currentNode]![neighbor]!;
        if (altDistance < (distances[neighbor] ?? double.infinity)) {
          distances[neighbor] = altDistance;
          previous[neighbor] = currentNode;
        }
      }
    }
    return [];
  }

  Future<void> getLocationAndNearestStation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await Geolocator.openLocationSettings();
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      TestLocation nearestStation = getNearestStation(
        locations: StationLocation.locations,
        deviceLatitude: position.latitude,
        deviceLongitude: position.longitude,
      );

      setState(() {
        nearestStationName = nearestStation.stationName;
      });
    } catch (e) {
      print('Error: $e');
    }
  }
}
