import 'package:flutter/material.dart';
import 'package:subtraingrad/Style/app_styles.dart';
import 'package:subtraingrad/widgets/thick_container.dart';
import 'package:ticket_widget/ticket_widget.dart';

class Favorite extends StatelessWidget {
  const Favorite({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Fevorites",
              style: Styles.headLineStyle2.copyWith(color: Colors.black),
            ),
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.favorite_border_rounded))
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(14),
              child: TicketWidget(
                width: double.infinity,
                height: 180,
                isCornerRounded: true,
                color: Color.fromARGB(255, 56, 88, 103).withOpacity(0.5),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Expanded(
                            child:
                                Container()), // Add expanded container to push the heart icon to the bottom
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.refresh),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'EGP',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Expanded(child: Container()),
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
                                                        decoration:
                                                            BoxDecoration(
                                                                color: Colors
                                                                    .black)),
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
                              Expanded(child: Container()),
                              Text(
                                'NYC',
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 40,
                              ),
                              Text(
                                  '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -')
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Date: 7/9/24',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Price: 20.0LE ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Tickets: 1',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
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
          ],
        ),
      ),
    );
  }
}
