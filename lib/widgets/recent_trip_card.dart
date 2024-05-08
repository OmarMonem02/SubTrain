import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:subtraingrad/Style/app_layout.dart';
import 'package:subtraingrad/Style/app_styles.dart';
import 'package:subtraingrad/widgets/thick_container.dart';

class RecentTripCard extends StatefulWidget {
  const RecentTripCard({super.key});

  @override
  State<RecentTripCard> createState() => _RecentTripCardState();
}

class _RecentTripCardState extends State<RecentTripCard> {
  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return Stack(
      children: [
        Container(
          width: size.width * 0.90,
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.train_outlined, size: 40),
                const Gap(12),
                Text('Cairo',
                    style: Styles.headLineStyle3.copyWith(color: Colors.black)),
                const ThickContainer(color: Colors.black),
                Expanded(
                    child: Stack(
                  children: [
                    SizedBox(
                      height: 24,
                      child: LayoutBuilder(
                        builder:
                            (BuildContext context, BoxConstraints constraints) {
                          return Flex(
                            direction: Axis.horizontal,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: List.generate(
                                (constraints.constrainWidth() / 6).floor(),
                                (index) => const SizedBox(
                                      width: 3,
                                      height: 1,
                                      child: DecoratedBox(
                                        decoration:
                                            BoxDecoration(color: Colors.black),
                                      ),
                                    )),
                          );
                        },
                      ),
                    ),
                  ],
                )),
                const ThickContainer(color: Colors.black),
                Text('Luxor',
                    style: Styles.headLineStyle3.copyWith(color: Colors.black)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
