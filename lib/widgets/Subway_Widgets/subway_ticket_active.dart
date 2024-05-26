import 'package:flutter/material.dart';
import 'package:subtraingrad/widgets/thick_container.dart';
import 'package:ticket_widget/ticket_widget.dart';

class SubwayTicketActive extends StatelessWidget {
  final String bookingDate;
  final String endPoint;
  final int fare;
  final String startPoint;
  final String status;
  const SubwayTicketActive({
    super.key,
    required this.bookingDate,
    required this.endPoint,
    required this.fare,
    required this.startPoint,
    required this.status,
  });
  @override
  Widget build(BuildContext context) {
    Color color = Color.fromARGB(255, 212, 212, 212);
    if (status == "New") {
      color = Color.fromARGB(255, 220, 220, 220);
    } else if (status == "Checked") {
      color = Color.fromARGB(255, 255, 100, 100);
    }
    return Center(
      child: Padding(
        padding: EdgeInsets.only(bottom: 8, top: 8, left: 16, right: 16),
        child: TicketWidget(
          width: double.infinity,
          height: 150,
          isCornerRounded: true,
          color: color,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 16, top: 20, left: 30, right: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ThickContainer(color: Colors.black),
                        Expanded(
                          child: Stack(children: [
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
                                        (constraints.constrainWidth() /
                                                6) // Adjusts the dots acording to the phone
                                            .floor(),
                                        (index) => SizedBox(
                                              width: 3,
                                              height: 1,
                                              child: DecoratedBox(
                                                  decoration: BoxDecoration(
                                                      color: Colors.black)),
                                            )),
                                  );
                                },
                              ),
                            ),
                            Center(
                              child: Icon(
                                Icons.train,
                                color: Colors.black,
                              ),
                            )
                          ]),
                        ),
                        ThickContainer(color: Colors.black),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          startPoint,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          endPoint,
                          style: TextStyle(
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
                                      (constraints.constrainWidth() / 15)
                                          .floor(),
                                      (index) => const SizedBox(
                                            width: 8,
                                            height: 1,
                                            child: DecoratedBox(
                                              decoration: BoxDecoration(
                                                  color: Colors.black),
                                            ),
                                          )),
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
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Date: ${bookingDate}',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.normal),
                            ),
                            Text(
                              'Price: ${fare}LE ',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.normal),
                            ),
                            Text(
                              'Status: ${status}',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.normal),
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




// Color.fromARGB(255, 212, 212, 212)