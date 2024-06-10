import 'package:flutter/material.dart';
import 'package:subtraingrad/Style/app_styles.dart';
import 'package:subtraingrad/widgets/thick_container.dart';
import 'package:ticket_widget/ticket_widget.dart';

class TrainTicketActive extends StatelessWidget {
  final String bookingDate;
  final String endPoint;
  final int fare;
  final String startPoint;
  final String status;
  final String arrivalStation;
  final String departureStation;
  final int seat;
  const TrainTicketActive({
    super.key,
    required this.bookingDate,
    required this.endPoint,
    required this.fare,
    required this.startPoint,
    required this.status,
    required this.arrivalStation,
    required this.departureStation,
    required this.seat,
  });

  @override
  Widget build(BuildContext context) {
    Color color = Styles.primaryColor;
    if (status == "New") {
      color = Styles.primaryColor;
    } else if (status == "Checked") {
      color = Styles.primary2Color;
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
                        ThickContainer(color: Colors.white),
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
                                                      color: Colors.white)),
                                            )),
                                  );
                                },
                              ),
                            ),
                            Center(
                              child: Icon(
                                Icons.train,
                                color: Colors.white,
                              ),
                            )
                          ]),
                        ),
                        ThickContainer(color: Colors.white),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(startPoint,
                                style: MyFonts.font16White.copyWith(
                                    fontSize: 14, fontWeight: FontWeight.bold)),
                            Text(departureStation,
                                style: MyFonts.font16White.copyWith(
                                    fontSize: 14, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Column(
                          children: [
                            Text(endPoint,
                                style: MyFonts.font16White.copyWith(
                                    fontSize: 14, fontWeight: FontWeight.bold)),
                            Text(arrivalStation,
                                style: MyFonts.font16White.copyWith(
                                    fontSize: 14, fontWeight: FontWeight.bold)),
                          ],
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
                                                  color: Colors.white),
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Date: ${bookingDate}',
                              style: MyFonts.font16White.copyWith(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Price: ${fare}LE ',
                              style: MyFonts.font16White.copyWith(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Status: ${status}',
                              style: MyFonts.font16White.copyWith(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Seat: ${seat}',
                              style: MyFonts.font16White.copyWith(
                                  fontSize: 12, fontWeight: FontWeight.bold),
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
