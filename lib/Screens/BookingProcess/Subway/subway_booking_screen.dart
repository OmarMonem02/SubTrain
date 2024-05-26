// ignore_for_file: avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';
import 'package:searchfield/searchfield.dart';
import 'package:subtraingrad/Payments/Paymob_Manager/paymob_manager.dart';
import 'package:subtraingrad/Payments/withdraw_payment_getway.dart';
import 'package:subtraingrad/Screens/BookingProcess/Subway/data/station_location.dart';
import 'package:subtraingrad/Screens/BookingProcess/Subway/data/subway_stations.dart';
import 'package:subtraingrad/Screens/auth/add_new_data.dart';
import 'package:subtraingrad/test.dart';
import 'package:subtraingrad/widgets/path_finder.dart';

class SubwayBookingScreen extends StatefulWidget {
  const SubwayBookingScreen({super.key});

  @override
  State<SubwayBookingScreen> createState() => _SubwayBookingScreenState();
}

class _SubwayBookingScreenState extends State<SubwayBookingScreen>
//animation
    with
        SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

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
  final TextEditingController startSearchController = TextEditingController();
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
      pathLength = path.length; // Calculate path length (stations - 1)
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

//animation
  @override
  void initState() {
    checkPermission();
    _fetchData();
    _animationController = AnimationController.unbounded(vsync: this)
      ..repeat(min: -0.5, max: 1.5, period: Duration(seconds: 1));
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

    _animationController.dispose();
    super.dispose();
  }

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
              SearchField(
                suggestionDirection: SuggestionDirection.flex,
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
                controller: startSearchController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || !suggestions.contains(value.trim())) {
                    return 'Enter a valid Station Name';
                  }
                  return null;
                },
                onSubmit: (x) {},
                autofocus: false,
                key: const Key('searchfield'),
                hint: 'Start Station',
                itemHeight: 50,
                onTapOutside: (x) {},
                suggestionStyle:
                    const TextStyle(fontSize: 18, color: Colors.black),
                searchStyle: const TextStyle(fontSize: 18, color: Colors.black),
                suggestionItemDecoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey.shade200,
                      width: 1,
                    ),
                  ),
                ),
                searchInputDecoration: InputDecoration(
                  hintStyle: const TextStyle(fontSize: 18, color: Colors.grey),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: const BorderSide(
                      width: 1,
                      color: Color.fromARGB(255, 56, 88, 103),
                      style: BorderStyle.solid,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: const BorderSide(
                      width: 1,
                      color: Colors.black,
                      style: BorderStyle.solid,
                    ),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 18,
                  ),
                ),
                suggestionsDecoration: SuggestionDecoration(
                  elevation: 8.0,
                  selectionColor: Colors.grey.shade100,
                  hoverColor: Colors.purple.shade100,
                  gradient: const LinearGradient(
                    colors: [
                      Colors.white,
                      Colors.white,
                    ],
                    stops: [0.25, 0.75],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                suggestions: suggestions
                    .map((e) =>
                        SearchFieldListItem<String>(e, child: searchChild(e)))
                    .toList(),
                focusNode: focus,
                suggestionState: Suggestion.expand,
                onSuggestionTap: (SearchFieldListItem<String> x) {
                  calculatePath();
                },
              ),
              const SizedBox(height: 16),
              //Search Feild 2
              SearchField(
                suggestionDirection: SuggestionDirection.flex,
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
                controller: endSearchController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || !suggestions.contains(value.trim())) {
                    return 'Enter a valid Station Name';
                  }
                  return null;
                },
                onSubmit: (x) {},
                autofocus: false,
                key: const Key('searchfield2'),
                hint: 'End Station',
                itemHeight: 50,
                onTapOutside: (x) {},
                suggestionStyle:
                    const TextStyle(fontSize: 18, color: Colors.black),
                searchStyle: const TextStyle(fontSize: 18, color: Colors.black),
                suggestionItemDecoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey.shade200,
                      width: 1,
                    ),
                  ),
                ),
                searchInputDecoration: InputDecoration(
                  hintStyle: const TextStyle(fontSize: 18, color: Colors.grey),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: const BorderSide(
                      width: 1,
                      color: Color.fromARGB(255, 56, 88, 103),
                      style: BorderStyle.solid,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: const BorderSide(
                      width: 1,
                      color: Colors.black,
                      style: BorderStyle.solid,
                    ),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 18,
                  ),
                ),
                suggestionsDecoration: SuggestionDecoration(
                  elevation: 8.0,
                  selectionColor: Colors.grey.shade100,
                  hoverColor: Colors.purple.shade100,
                  gradient: const LinearGradient(
                    colors: [
                      Colors.white,
                      Colors.white,
                    ],
                    stops: [0.25, 0.75],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                suggestions: suggestions
                    .map((e) =>
                        SearchFieldListItem<String>(e, child: searchChild(e)))
                    .toList(),
                focusNode: focus2,
                suggestionState: Suggestion.expand,
                onSuggestionTap: (SearchFieldListItem<String> x) {
                  calculatePath();
                },
              ),
              SizedBox(
                height: 16,
              ),

              //Auto locate and path buttons

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {},
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

              //Ticket Counter
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

              //Payment Options

              Column(
                children: [
                  SizedBox(height: 16),

                  //Paymob

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

                  //App Wallet

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
              // // animation test
              // AnimatedBuilder(
              //   animation: _animationController,
              //   builder: (_, child) {
              //     return ShaderMask(
              //       shaderCallback: (bounds) => LinearGradient(
              //         begin: Alignment.topCenter,
              //         end: Alignment.bottomCenter,
              //         transform: _Slide(percent: -_animationController.value),
              //         colors: [Colors.white10, Colors.white, Colors.white10],
              //       ).createShader(bounds),
              //       child: Column(
              //         children: [
              //           Align(
              //             heightFactor: 0.5,
              //             child: Icon(Icons.arrow_drop_down),
              //           ),
              //           Align(
              //             heightFactor: 0.5,
              //             child: Icon(Icons.arrow_drop_down),
              //           ),
              //           Align(
              //             heightFactor: 0.5,
              //             child: Icon(Icons.arrow_drop_down),
              //           )
              //         ],
              //       ),
              //     );
              //   },
              // ),

              //Confirm Button
              SizedBox(
                height: 8,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_value == 1) {
                    _pay();
                    _updateData();
                  } else if (_value == 2) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          contentPadding: EdgeInsets.all(20.0),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.sentiment_satisfied_rounded,
                                color: Colors.green,
                                size: 48.0,
                              ),
                            ],
                          ),
                          content: Text(
                            'Are you sure you want buy it by Wallet',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          actions: [
                            TextButton(
                              child: Text(
                                'No',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  Colors.red,
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text(
                                'Yes',
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  Colors.green,
                                ),
                              ),
                              onPressed: () {
                                if (balance! < (price * _counter)) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        contentPadding: EdgeInsets.all(24.0),
                                        title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.error_outline_outlined,
                                              color: Colors.red,
                                              size: 48.0,
                                            ),
                                          ],
                                        ),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'Your balance in wallet is not enough!',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.center,
                                            ),
                                            SizedBox(height: 16.0),
                                            ElevatedButton(
                                              child: Text(
                                                'Ok',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                        Color>(
                                                  Color.fromRGBO(
                                                      152, 152, 152, 1),
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                } else if (balance! >= (price * _counter)) {
                                  int count = _counter;
                                  for (count; 0 < count; count--) {
                                    addTicket(_user!.uid);
                                  }

                                  _updateData();
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        contentPadding: EdgeInsets.all(24.0),
                                        title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.check_circle,
                                              color: Colors.green,
                                              size: 48.0,
                                            ),
                                          ],
                                        ),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'Your ticket has been successfully Purchased!',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.center,
                                            ),
                                            SizedBox(height: 16.0),
                                            ElevatedButton(
                                              child: Text(
                                                'Ok',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                        Color>(
                                                  Color.fromRGBO(
                                                      152, 152, 152, 1),
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                }
                              },
                            ),
                          ],
                        );
                      },
                    );
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
    int amount = price;

    PaymobManager().getPaymentKey(amount, "EGP").then(
      (String paymentKey) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WithdrawPaymentGetway(
              paymentToken: paymentKey,
              amount: amount,
            ),
          ),
        );
      },
    ).whenComplete(
      () {},
    );
  }

  List<String> findShortestPath(
      Map<String, Map<String, int>> graph, String start, String end) {
    // Store distances to each node (initially infinite except for the start node)
    Map<String, double> distances = {};

    // Store previous nodes along the shortest path
    Map<String, String?> previous = {};

    // Set of unvisited nodes
    Set<String> unvisited = Set.from(graph.keys);

    // Initialize distances
    for (var node in graph.keys) {
      distances[node] = double.infinity;
    }
    distances[start] = 0;

    while (unvisited.isNotEmpty) {
      // Find node with the smallest distance among unvisited nodes
      String? currentNode =
          unvisited.reduce((a, b) => distances[a]! < distances[b]! ? a : b);

      unvisited.remove(currentNode);

      if (currentNode == end) {
        // Destination reached - reconstruct the path
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
          // Add null check
          distances[neighbor] = altDistance;
          previous[neighbor] = currentNode;
        }
      }
    }
    return [];
  }

  checkPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: "Request Denied !");
        return;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(msg: "Request Denied Forever !");
      return;
    }
    getLocation();
  }

  getLocation() async {
    setState(() {
      scanning = true;
    });
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      coordinates =
          'Latitude : ${position.latitude}\nLongitude : ${position.longitude}';
      List<Placemark> result =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      if (result.isEmpty) {
        address =
            '${result[0].name},${result[0].locality},${result[0].administrativeArea}';
      }
      final List<TestLocation> locations = StationLocation.locations;


      // Get the nearest station
      final nearestStation = getNearestStation(
        locations: locations,
        deviceLatitude: position.latitude,
        deviceLongitude: position.longitude,
      );
      print(position);
      print(address);
    } catch (e) {
      Fluttertoast.showToast(msg: "${e.toString()}");
    }
  }
}

// //animation
// class _Slide extends GradientTransform {
//   final double percent;

//   _Slide({required this.percent});
//   @override
//   Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
//     return Matrix4.translationValues(0, -bounds.height * percent, 0);
//   }
// }
