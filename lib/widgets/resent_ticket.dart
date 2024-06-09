import 'package:flutter/material.dart';
import 'package:subtraingrad/Style/app_styles.dart';
import 'package:subtraingrad/widgets/thick_container.dart';
import 'package:ticket_widget/ticket_widget.dart';

// ignore: must_be_immutable
class ResentTripsTicket extends StatefulWidget {
  final String bookingDate;
  final String endPoint;
  final int fare;
  final String startPoint;
  final String status;

  ResentTripsTicket({
    Key? key,
    required this.bookingDate,
    required this.endPoint,
    required this.fare,
    required this.startPoint,
    required this.status, // Add this line
  }) : super(key: key);

  @override
  _ResentTripsTicketState createState() => _ResentTripsTicketState();
}

class _ResentTripsTicketState extends State<ResentTripsTicket> {
  @override
  Widget build(BuildContext context) {
    Color color = Styles.primaryColor;

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
                        const ThickContainer(color: Colors.white),
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
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const Center(
                                child: Icon(Icons.train, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        const ThickContainer(color: Colors.white),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.startPoint,
                          style: MyFonts.font16White.copyWith(fontSize: 14),
                        ),
                        Text(
                          widget.endPoint,
                          style: MyFonts.font16White.copyWith(fontSize: 14),
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
                                            BoxDecoration(color: Colors.white),
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
                              'Date: ${widget.bookingDate}',
                              style: MyFonts.font16White.copyWith(fontSize: 12),
                            ),
                            Text(
                              'Price: ${widget.fare}LE',
                              style: MyFonts.font16White.copyWith(fontSize: 12),
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
