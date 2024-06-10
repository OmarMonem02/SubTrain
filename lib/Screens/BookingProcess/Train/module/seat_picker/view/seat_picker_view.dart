import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:subtraingrad/Admin_Pages/seats.dart';
import 'package:subtraingrad/Style/app_styles.dart';
import '../../booking_detail/view/booking_detail_view.dart';
import '../controller/seat_picker_controller.dart';

class SeatPickerView extends StatefulWidget {
  final Map<String, Map<String, bool>> seats;
  final String tripID;

  const SeatPickerView({
    super.key,
    required this.seats,
    required this.tripID,
  });

  @override
  SeatPickerController createState() => SeatPickerController();
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
        title: Text(
          "Select Seat",
          style: MyFonts.appbar,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Gap(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.square,
                    size: 24.0,
                    color: Color.fromARGB(255, 40, 150, 40),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    "Available",
                    style: MyFonts.font16Black,
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
                    style: MyFonts.font16Black,
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
                    style: MyFonts.font16Black,
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
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
                                  var number =
                                      (index).toString().padLeft(2, "0");
                                  bool selected =
                                      controller.usedSeats.contains(index);
                                  bool selectedSeatByOther =
                                      controller.selectedSeats.contains(index);
                                  bool unclickable = controller.unclickableSeats
                                      .contains(index);

                                  var color = Color.fromARGB(255, 40, 150, 40);
                                  if (selectedSeatByOther) {
                                    color = Color.fromARGB(255, 142, 142, 142);
                                  } else if (selected) {
                                    color = Color.fromARGB(255, 255, 191, 0);
                                  } else if (unclickable) {
                                    color = Color.fromARGB(255, 142, 142, 142);
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
                                        borderRadius: const BorderRadius.all(
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
                                                      ? const Color(0xff393e48)
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
              Gap(30),
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
            decoration: BoxDecoration(
                color: Styles.primaryColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Selected Seats: ${controller.usedSeats.join(', ')}",
                          style: MyFonts.font16White
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Styles.contrastColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookingDetailView(
                            tripID: controller.view.tripID,
                            selectedSeats: controller.usedSeats,
                            seatCount: controller.counter,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      "Confirm",
                      style: MyFonts.font18White
                          .copyWith(fontWeight: FontWeight.bold),
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
