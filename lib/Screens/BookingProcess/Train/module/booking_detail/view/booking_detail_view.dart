import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quickalert/quickalert.dart';
import 'package:random_string/random_string.dart';
import 'package:subtraingrad/Payments/Paymob_Manager/paymob_manager.dart';
import 'package:subtraingrad/Payments/withdraw_payment_getway.dart';
import 'package:subtraingrad/Screens/auth/add_new_data.dart';
import 'package:subtraingrad/widgets/bottom_nav_bar.dart';
import '../../../../../../widgets/Train_Booking_Widgets/separator.dart';

class BookingDetailView extends StatefulWidget {
  final String tripID;
  final List<int> selectedSeats;
  final int seatCount;

  const BookingDetailView({
    super.key,
    required this.tripID,
    required this.selectedSeats,
    required this.seatCount,
  });

  @override
  _BookingDetailViewState createState() => _BookingDetailViewState();
}

class _BookingDetailViewState extends State<BookingDetailView> {
  bool loading = false;
  int _selectedPaymentMethod = 0;
  String departureStation = "";
  String arrivalStation = "";
  String startPoint = "";
  String endPoint = "";
  String departureTime = "";
  String arrivalTime = "";
  String trainClass = "";
  String trainNum = "";
  String tripDate = "";
  List<String> words = [];
  List<String> words2 = [];
  int price = 0;
  final User? _user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  Future<void> _fetchData() async {
    setState(() {
      loading = true;
    });
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('Train_Schedule')
          .doc(widget.tripID)
          .get();
      final tripData = snapshot.data();
      if (tripData != null) {
        setState(() {
          departureStation = tripData['departureStation'];
          arrivalStation = tripData['arrivalStation'];
          startPoint = tripData['startPoint'];
          endPoint = tripData['endPoint'];
          departureTime = tripData['departureTime'];
          arrivalTime = tripData['arrivalTime'];
          trainClass = tripData['trainClass'];
          trainNum = tripData['trainID'];
          tripDate = tripData['tripDate'];
          price = tripData['price'];
          words = departureTime.split(' ');
          words2 = arrivalTime.split(' ');
        });
      } else {
        _showError('Failed to fetch trip data');
      }
    } catch (e) {
      _showError('An error occurred while fetching data');
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> _updateData() async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_user!.uid)
          .update({
        'balance': FieldValue.increment(-(price * widget.seatCount)),
      });
    } catch (e) {
      _showError('An error occurred while updating data');
    }
  }

  Future<void> addTicket(String userId) async {
    final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    final String date = dateFormat.format(DateTime.now());
    String ticketId = randomAlphaNumeric(20);
    Map<String, dynamic> ticketInfoMap = {
      'trainTicketID': ticketId,
      'userId': userId,
      "bookingDate": date,
      "departureStation": departureStation,
      "arrivalStation": arrivalStation,
      "startPoint": startPoint,
      "endPoint": endPoint,
      "departureTime": departureTime,
      "arrivalTime": arrivalTime,
      "fare": price,
      "tripDate": tripDate,
      "trainID": trainNum,
      "trainClass": trainClass,
      "status": "New",
    };

    try {
      await DatabaseMethod().addTrainTicket(ticketInfoMap, ticketId, userId);
    } catch (e) {
      _showError('An error occurred while adding the ticket');
    }
  }

  void _pay() async {
    int amount = price * widget.seatCount;

    try {
      String paymentKey = await PaymobManager().getPaymentKey(amount, "EGP");
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
        for (int i = 0; i < widget.seatCount; i++) {
          addTicket(_user!.uid);
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Payment Successful.'),
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
    } catch (e) {
      _showError('An error occurred while processing payment');
    }
  }

  void _showError(String message) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      text: message,
      onConfirmBtnTap: () => Navigator.pop(context),
    );
  }

  Widget _buildTicketDetails(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 220, 220, 220),
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
      ),
      child: Stack(
        children: [
          const Positioned(
            top: 64,
            left: -18,
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          const Positioned(
            top: 64,
            right: -18,
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          const Positioned(
            top: 80,
            left: 18,
            right: 18,
            child: Separator(),
          ),
          _buildTicketInfo(context),
        ],
      ),
    );
  }

  Widget _buildTicketInfo(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      margin: const EdgeInsets.all(30.0),
      child: Column(
        children: [
          const _TicketInfoRow(),
          const SizedBox(height: 60.0),
          _TicketDetailSection(
            label1: "From",
            value1: startPoint,
            label2: "To",
            value2: endPoint,
          ),
          const SizedBox(height: 20.0),
          _TicketDetailSection(
            label1: "From",
            value1: arrivalStation,
            label2: "To",
            value2: departureStation,
          ),
          const SizedBox(height: 20.0),
          _TicketDetailSection(
            label1: "Depature",
            value1: words.join('\n'),
            label2: "Arrival",
            value2: words2.join('\n'),
          ),
          const SizedBox(height: 20.0),
          _TicketDetailSection(
            label1: "Class",
            value1: trainClass,
            label2: "Train No.",
            value2: trainNum,
          ),
          const SizedBox(height: 20.0),
          _TicketDetailSection(
            label1: "Price Per seat",
            value1: "${price} LE",
            label2: "Selected Seats",
            value2: widget.selectedSeats.join(', '),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOptions(BuildContext context) {
    return Column(
      children: [
        RadioListTile<int>(
          title: const Text("Pay With Paymob"),
          value: 1,
          groupValue: _selectedPaymentMethod,
          onChanged: (value) {
            setState(() {
              _selectedPaymentMethod = value!;
            });
          },
        ),
        RadioListTile<int>(
          title: const Text("Pay By Your Wallet"),
          value: 2,
          groupValue: _selectedPaymentMethod,
          onChanged: (value) {
            setState(() {
              _selectedPaymentMethod = value!;
            });
          },
        ),
      ],
    );
  }

  Widget _buildDoneButton(BuildContext context) {
    return SizedBox(
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
          if (_selectedPaymentMethod == 0) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Pleas Select Payment Method'),
                backgroundColor: Colors.red,
              ),
            );
          } else if (_selectedPaymentMethod == 1) {
            _pay();
          } else if (_selectedPaymentMethod == 2) {
            int balance = await _getUserBalance();
            if (balance < (price * widget.seatCount)) {
              _showError("You don't have enough balance!");
            } else {
              QuickAlert.show(
                context: context,
                type: QuickAlertType.confirm,
                text: 'Are you sure you want to buy it by Wallet?',
                confirmBtnText: 'Yes',
                cancelBtnText: 'No',
                confirmBtnColor: Colors.lightGreen,
                animType: QuickAlertAnimType.slideInUp,
                onCancelBtnTap: () => Navigator.pop(context),
                onConfirmBtnTap: () async {
                  Navigator.pop(context);
                  for (int i = 0; i < widget.seatCount; i++) {
                    await addTicket(_user!.uid);
                  }
                  await _updateData();
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.success,
                    text: "Your Ticket is Purchased!",
                    onConfirmBtnTap: () {
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
        },
        child: const Text(
          "Done",
          style: TextStyle(
            color: Color(0xff383d47),
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Future<int> _getUserBalance() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(_user!.uid)
          .get();
      return snapshot['balance'];
    } catch (e) {
      _showError('An error occurred while fetching user balance');
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Ticket",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Expanded(
                    child: _buildTicketDetails(context),
                  ),
                  const SizedBox(height: 35.0),
                  _buildPaymentOptions(context),
                  const SizedBox(height: 35.0),
                  _buildDoneButton(context),
                  const SizedBox(height: 60.0),
                ],
              ),
            ),
    );
  }
}

class _TicketInfoRow extends StatelessWidget {
  const _TicketInfoRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Confirm Your Ticket",
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Color(0xff393e48),
          ),
        ),
      ],
    );
  }
}

class _TicketDetailSection extends StatelessWidget {
  final String label1;
  final String value1;
  final String label2;
  final String value2;

  const _TicketDetailSection({
    required this.label1,
    required this.value1,
    required this.label2,
    required this.value2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label1,
                style: const TextStyle(
                  color: Color.fromARGB(255, 144, 144, 144),
                  fontSize: 12.0,
                ),
              ),
              Text(
                value1,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Color(0xff393e48),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                label2,
                style: const TextStyle(
                  color: Color.fromARGB(255, 144, 144, 144),
                  fontSize: 12.0,
                ),
              ),
              Text(
                value2,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Color(0xff393e48),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
