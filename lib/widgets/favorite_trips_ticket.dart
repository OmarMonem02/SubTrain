import 'package:flutter/material.dart';
import 'package:subtraingrad/widgets/thick_container.dart';
import 'package:ticket_widget/ticket_widget.dart';

// ignore: must_be_immutable
class FavoriteTripsTicket extends StatefulWidget {
  final String bookingDate;
  final String endPoint;
  final int fare;
  final String startPoint;
  final String status;
  bool favBtn;
  final Function(bool) onFavChanged; // Add this line

  FavoriteTripsTicket({
    Key? key,
    required this.bookingDate,
    required this.endPoint,
    required this.fare,
    required this.startPoint,
    required this.status,
    required this.favBtn,
    required this.onFavChanged, // Add this line
  }) : super(key: key);

  @override
  _FavoriteTripsTicketState createState() => _FavoriteTripsTicketState();
}

class _FavoriteTripsTicketState extends State<FavoriteTripsTicket> {
  @override
  Widget build(BuildContext context) {
    const Color color = Color.fromARGB(255, 212, 212, 212);

    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8, top: 8, left: 16, right: 16),
        child: TicketWidget(
          width: double.infinity,
          height: 150,
          isCornerRounded: true,
          color: color,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 16,
                  top: 20,
                  left: 30,
                  right: 30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const ThickContainer(color: Colors.black),
                        Expanded(
                          child: Stack(
                            children: [
                              SizedBox(
                                height: 24,
                                child: LayoutBuilder(
                                  builder: (BuildContext context,
                                      BoxConstraints constraints) {
                                    return Flex(
                                      direction: Axis.horizontal,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.max,
                                      children: List.generate(
                                        (constraints.constrainWidth() / 6)
                                            .floor(),
                                        (index) => const SizedBox(
                                          width: 3,
                                          height: 1,
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                                color: Colors.black),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const Center(
                                child: Icon(Icons.train, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        const ThickContainer(color: Colors.black),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.startPoint,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.endPoint,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: LayoutBuilder(
                              builder: (BuildContext context,
                                  BoxConstraints constraints) {
                                return Flex(
                                  direction: Axis.horizontal,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: List.generate(
                                    (constraints.constrainWidth() / 15).floor(),
                                    (index) => const SizedBox(
                                      width: 8,
                                      height: 1,
                                      child: DecoratedBox(
                                        decoration:
                                            BoxDecoration(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Price: ${widget.fare}LE',
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.normal),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  widget.favBtn = !widget.favBtn;
                                  widget.onFavChanged(
                                      widget.favBtn); // Add this line
                                });
                              },
                              icon: Icon(
                                widget.favBtn
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: widget.favBtn ? Colors.red : null,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
