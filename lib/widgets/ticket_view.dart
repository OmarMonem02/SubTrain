import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:subtraingrad/Style/app_layout.dart';
import 'package:subtraingrad/Style/app_styles.dart';
import 'package:subtraingrad/widgets/thick_container.dart';

class TicketView extends StatelessWidget {
  final String sPoint;
  final String lsPoint;
  final String ePoint;
  final String lePoint;
  final String dur;
  final String date;
  final String tNum;
  final String depTime;

  const TicketView(
      {super.key,
      required this.sPoint,
      required this.lsPoint,
      required this.ePoint,
      required this.lePoint,
      required this.dur,
      required this.date,
      required this.tNum,
      required this.depTime});

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return SizedBox(
      width: size.width * 0.85,
      height: 200,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        margin: const EdgeInsets.only(right: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Top Part Of The Card
            Container(
              decoration: BoxDecoration(
                  color: Styles.primaryColor,
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(21),
                      topLeft: Radius.circular(21))),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        sPoint,
                        style:
                            Styles.headLineStyle3.copyWith(color: Colors.white),
                      ),
                      Expanded(child: Container()),
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
                                          )),
                                );
                              },
                            ),
                          ),
                          const Center(
                              child: Icon(Icons.train_outlined,
                                  color: Colors.white)),
                        ],
                      )),
                      const ThickContainer(color: Colors.white),
                      Expanded(child: Container()),
                      Text(
                        ePoint,
                        style:
                            Styles.headLineStyle3.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                  const Gap(3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 100,
                        child: Text(
                          lsPoint,
                          style: Styles.headLineStyle4
                              .copyWith(color: Colors.white),
                        ),
                      ),
                      Text(
                        dur,
                        style:
                            Styles.headLineStyle4.copyWith(color: Colors.white),
                      ),
                      SizedBox(
                        width: 100,
                        child: Text(
                          lePoint,
                          textAlign: TextAlign.end,
                          style: Styles.headLineStyle4
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Mid Part Of The Card
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Styles.primaryColor,
                    Styles.secondaryColor,
                  ],
                ),
              ),
              // color: Color(0xFFF37B67),
              child: Row(
                children: [
                  SizedBox(
                    height: 20,
                    width: 10,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          )),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: LayoutBuilder(
                        builder:
                            (BuildContext context, BoxConstraints constraints) {
                          return Flex(
                            direction: Axis.horizontal,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: List.generate(
                                (constraints.constrainWidth() / 15).floor(),
                                (index) => const SizedBox(
                                      width: 5,
                                      height: 1,
                                      child: DecoratedBox(
                                        decoration:
                                            BoxDecoration(color: Colors.white),
                                      ),
                                    )),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                    width: 10,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          )),
                    ),
                  ),
                ],
              ),
            ),

            // Bottom Part Of The Card
            Container(
              decoration: BoxDecoration(
                color: Styles.secondaryColor,
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(21),
                  bottomLeft: Radius.circular(21),
                ),
              ),
              padding: const EdgeInsets.only(
                  left: 16, top: 10, bottom: 16, right: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            date,
                            style: Styles.headLineStyle3
                                .copyWith(color: Colors.black),
                          ),
                          const Gap(5),
                          Text(
                            "DATE",
                            style: Styles.headLineStyle4
                                .copyWith(color: Colors.black),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            depTime,
                            style: Styles.headLineStyle3
                                .copyWith(color: Colors.black),
                          ),
                          const Gap(5),
                          Text(
                            "Departure Time",
                            style: Styles.headLineStyle4
                                .copyWith(color: Colors.black),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            tNum,
                            style: Styles.headLineStyle3
                                .copyWith(color: Colors.black),
                          ),
                          const Gap(5),
                          Text(
                            "Number",
                            style: Styles.headLineStyle4
                                .copyWith(color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
