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
import 'package:subtraingrad/Screens/BookingProcess/Subway/data/station_location_view.dart';
import 'package:subtraingrad/Screens/BookingProcess/Subway/data/subway_stations.dart';
import 'package:subtraingrad/Screens/auth/add_new_data.dart';
import 'package:subtraingrad/Style/app_styles.dart';
import 'package:subtraingrad/nearestStation.dart';
import 'package:subtraingrad/widgets/bottom_nav_bar.dart';
import 'package:subtraingrad/widgets/path_finder.dart';
import 'package:subtraingrad/widgets/search.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SubwayBookingScreen extends StatefulWidget {
  const SubwayBookingScreen({super.key});

  @override
  State<SubwayBookingScreen> createState() => _SubwayBookingScreenState();
}

class _SubwayBookingScreenState extends State<SubwayBookingScreen> {
  int _counter = 1;
  int _value = 0;
  bool scanning = true;
  String? address, coordinates;
  bool _isLoading = false; // Add this line

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
  final startFocus = FocusNode();
  final TextEditingController endSearchController = TextEditingController();
  final endFocus = FocusNode();

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
    startFocus.dispose();
    endSearchController.dispose();
    endFocus.dispose();

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
        physics: PageScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.all(14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      CustomSearchField(
                        focusNode: startFocus,
                        hint: 'Start Station',
                        suggestions: suggestions,
                        controller: startSearchController,
                        onSearchTextChanged: (query) {
                          final filter = suggestions
                              .where((element) => element
                                  .toLowerCase()
                                  .contains(query.toLowerCase()))
                              .toList();
                          return filter
                              .map((e) => SearchFieldListItem<String>(e,
                                  child: searchChild(e)))
                              .toList();
                        },
                        onSuggestionTap: (SearchFieldListItem<String> x) {},
                      ),
                      IconButton(
                        onPressed: () {
                          _startOpenMap();
                        },
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Styles.primaryColor),
                        icon: const Icon(Icons.map_outlined),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      CustomSearchField(
                        focusNode: endFocus,
                        hint: 'End Station',
                        suggestions: suggestions,
                        controller: endSearchController,
                        onSearchTextChanged: (query) {
                          final filter = suggestions
                              .where((element) => element
                                  .toLowerCase()
                                  .contains(query.toLowerCase()))
                              .toList();
                          return filter
                              .map((e) => SearchFieldListItem<String>(e,
                                  child: searchChild(e)))
                              .toList();
                        },
                        onSuggestionTap: (SearchFieldListItem<String> x) {
                          calculatePath();
                        },
                      ),
                      IconButton(
                        onPressed: () {
                          _endOpenMap();
                        },
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Styles.primaryColor),
                        icon: const Icon(Icons.map_outlined),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          getLocationAndNearestStation();
                          setState(() {
                            startSearchController.text = nearestStationName;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Styles.primaryColor),
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.red,
                            ),
                            Text(
                              'Auto Locate',
                              style: MyFonts.font18White,
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          showPathFinder(context);
                        },
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Styles.primaryColor),
                        child: Text(
                          'Show Path',
                          style: MyFonts.font18White,
                        ),
                      ),
                      SizedBox(height: 8),
                      SizedBox(height: 8),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Total Amount: ${_counter * price}LE',
                          style: MyFonts.font22Black,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: _counter == 0 ? null : _decrementCounter,
                            child: Container(
                              margin: const EdgeInsets.only(
                                right: 20.0,
                              ),
                              decoration: BoxDecoration(
                                color: (_counter == 0)
                                    ? const Color(0xffdedede)
                                    : Styles.primaryColor,
                              ),
                              child: const Icon(
                                Icons.remove,
                                size: 25.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            "${_counter}",
                            style: const TextStyle(
                              fontSize: 18.0,
                              color: Color(0xff393e48),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          InkWell(
                            onTap: () => _incrementCounter(),
                            child: Container(
                              margin: const EdgeInsets.only(
                                left: 20.0,
                              ),
                              decoration: BoxDecoration(
                                color: Styles.primaryColor,
                              ),
                              child: const Icon(
                                Icons.add,
                                size: 25.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          )
                        ],
                      )
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(height: 16.0),
                      RadioListTile<int>(
                        activeColor: Styles.primaryColor,
                        title: Row(
                          children: [
                            Icon(
                              Icons.credit_card,
                              color: Styles.primaryColor,
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              "Pay With Paymob",
                              style: MyFonts.font18Black,
                            ),
                          ],
                        ),
                        value: 1,
                        groupValue: _value,
                        onChanged: (value) {
                          setState(() {
                            _value = value!;
                          });
                        },
                      ),
                      RadioListTile<int>(
                        activeColor: Styles.primaryColor,
                        title: Row(
                          children: [
                            Icon(
                              Icons.wallet,
                              color: Styles.primaryColor,
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              "Pay By Your Wallet",
                              style: MyFonts.font18Black,
                            ),
                          ],
                        ),
                        value: 2,
                        groupValue: _value,
                        onChanged: (value) {
                          setState(() {
                            _value = value!;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                ],
              ),
              SizedBox(
                height: 48,
                width: MediaQuery.of(context).size.width * 0.4,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Styles.contrastColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    if (startSearchController.text.isEmpty ||
                        endSearchController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Please select both start and end stations.'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return; // Exit early if fields are not filled
                    }

                    if (_value == 1) {
                      setState(() {
                        _isLoading = true; // Show loading indicator
                      });
                      _pay();
                    } else if (_value == 2) {
                      if (balance! < (price * _counter)) {
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.error,
                          text: "You don't have enough balance!",
                          onConfirmBtnTap: () async {
                            Navigator.pop(context);
                          },
                        );
                      } else if (balance! >= (price * _counter)) {
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.confirm,
                          text:
                              'Are you sure you want to buy it with your Wallet?',
                          confirmBtnText: 'Yes',
                          cancelBtnText: 'No',
                          confirmBtnColor: Styles.primaryColor,
                          animType: QuickAlertAnimType.slideInUp,
                          onCancelBtnTap: () async {
                            Navigator.pop(context);
                          },
                          onConfirmBtnTap: () async {
                            Navigator.pop(context);
                            int count = _counter;
                            for (count; count > 0; count--) {
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
                                  ),
                                );
                              },
                            );
                          },
                        );
                      }
                    }
                    print(_value);
                  },
                  child: _isLoading
                      ? // Conditionally show loading indicator
                      Center(
                          child: CircularProgressIndicator(
                          color: Styles.thirdColor,
                        ))
                      : Text(
                          "Pay",
                          style: MyFonts.font18White,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Subway Booking',
          style: MyFonts.appbar,
        ),
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
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Payment failed! Please try again.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
    ).whenComplete(() {
      setState(() {
        _isLoading = false; // Hide loading indicator
      });
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

  Future<void> _startOpenMap() async {
    Map<String, String> locationData = LocationLink.locationLink;
    String? selectedLocationKey = startSearchController.text;
    String? url = locationData[selectedLocationKey];
    if (url != null && await canLaunchUrlString(url)) {
      await launchUrlString(url);
    }
  }

  Future<void> _endOpenMap() async {
    Map<String, String> locationData = LocationLink.locationLink;
    String? selectedLocationKey = endSearchController.text;
    String? url = locationData[selectedLocationKey];
    if (url != null && await canLaunchUrlString(url)) {
      await launchUrlString(url);
    }
  }
}
