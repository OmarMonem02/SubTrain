import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:subtraingrad/Admin_Pages/seats.dart';
import 'package:subtraingrad/Screens/Home/home_screen.dart';
import '../../booking_detail/view/booking_detail_view.dart';
import '../controller/seat_picker_controller.dart';

class SeatPickerView extends StatefulWidget {
  final Map<String, Map<String, bool>> seats;
  const SeatPickerView({
    super.key,
    required this.seats,
  });

  @override
  SeatPickerController createState() => SeatPickerController();

  build(BuildContext context, SeatPickerController seatPickerController) {}
}

class SeatPickerViewBody extends StatelessWidget {
  final SeatPickerController controller;

  const SeatPickerViewBody({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Select Seat",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [],
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, const HomeScreen());
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 24.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Gap(20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.square,
                    size: 24.0,
                    color: Color.fromARGB(255, 50, 200, 50),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    "Available",
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Icon(
                    Icons.square,
                    size: 24.0,
                    color: Color.fromARGB(255, 255, 191, 0),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    "Selected",
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Icon(
                    Icons.square,
                    size: 24.0,
                    color: Color.fromARGB(255, 142, 142, 142),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    "Unavailable",
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Gap(30),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 120,
                        width: MediaQuery.of(context).size.width * 0.6,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 240, 240, 240),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.elliptical(150.0, 300.0),
                            topRight: Radius.elliptical(150.0, 300.0),
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 40,
                              left: 30,
                              right: 30,
                              child: Container(
                                height: 60,
                                decoration: const BoxDecoration(
                                  color: Color(0xffd9d9d9),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.elliptical(200.0, 300.0),
                                    topRight: Radius.elliptical(200.0, 300.0),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 240, 240, 240),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 15.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: LayoutBuilder(builder: (context, raints) {
                                double spacing = 6;
                                var size = (raints.biggest.width / 5.8);
                                return Wrap(
                                  runSpacing: spacing,
                                  spacing: spacing,
                                  children: List.generate(
                                    60,
                                    (index) {
                                      var number = (index + 1)
                                          .toString()
                                          .padLeft(2, "0");
                                      bool selected =
                                          controller.usedSeats.contains(index);
                                      bool selectedSeatByOther = controller
                                          .selectedSeats
                                          .contains(index);
                                      bool unclickable = controller
                                          .unclickableSeats
                                          .contains(index);

                                      var color =
                                          Color.fromARGB(255, 50, 200, 50);
                                      if (selectedSeatByOther) {
                                        color =
                                            Color.fromARGB(255, 142, 142, 142);
                                      } else if (selected) {
                                        color =
                                            Color.fromARGB(255, 255, 191, 0);
                                      } else if (unclickable) {
                                        color =
                                            Color.fromARGB(255, 142, 142, 142);
                                      }

                                      return InkWell(
                                        onTap: unclickable
                                            ? null
                                            : () {
                                                print(Seats());
                                                controller.updateSeat(
                                                    context, index);
                                              },
                                        child: Container(
                                          height: size,
                                          width: size,
                                          margin: EdgeInsets.only(
                                              right: (index + 1) % 2 == 0 &&
                                                      (index + 1) % 4 != 0
                                                  ? 20
                                                  : 0),
                                          decoration: BoxDecoration(
                                            color: color,
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(8.0),
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              number,
                                              style: TextStyle(
                                                  color: unclickable
                                                      ? Colors.grey[500]
                                                      : selected
                                                          ? const Color(
                                                              0xff393e48)
                                                          : Colors.white,
                                                  fontSize: 16),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Gap(50),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Gap(50),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "A",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ), //1
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "B",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ), //2
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "C",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ), //3
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "D",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ), //4
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "E",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ), //5
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "F",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ), //6
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Wrap(
        runSpacing: 10,
        spacing: 10,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Color(0xfffdc620),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(12.0),
                topLeft: Radius.circular(12.0),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total: \$${controller.counter * 200}",
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Color(0xff383d47),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Selected Seats: ${controller.usedSeats.join(', ')}",
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Color(0xff383d47),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff383d47),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BookingDetailView(),
                        ),
                      );
                    },
                    child: const Text(
                      "Proceed to Pay",
                      style: TextStyle(
                        color: Color(0xfffdc620),
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
