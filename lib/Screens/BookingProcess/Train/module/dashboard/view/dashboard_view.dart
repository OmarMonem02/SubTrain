import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:subtraingrad/Screens/BookingProcess/Train/data/train_stations.dart';
import 'package:subtraingrad/Style/app_layout.dart';
import 'package:subtraingrad/Style/app_styles.dart';

import '../../../shared/widgets/datepicker.dart';
import '../../../shared/widgets/dropdown.dart';
import '../../seat_picker/view/seat_picker_view.dart';
import '../controller/dashboard_controller.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  Widget build(context, DashboardController controller) {
    controller.view = this;
    final size = AppLayout.getSize(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Styles.bdColor,
        title: const Text(
          "Booking",
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(color: Styles.bdColor),
          height: size.height * 0.90,
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Gap(60),
              const Text(
                "Book Your Ticket Today",
                style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Theme(
                data: ThemeData.light(),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(15.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: QDropdownField(
                              label: "From",
                              value: "", // validator: Validator.required,
                              items: TrainData.trainData,
                              onChanged: (value, label) {},
                            ),
                          ),
                          Expanded(
                            child: QDropdownField(
                              label: "To",
                              value: "", // validator: Validator.required,
                              items: TrainData.trainData,
                              onChanged: (value, label) {},
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: QDatePicker(
                              label: "Date",
                              value: DateTime.now(),
                              // validator: Validator.required,
                              onChanged: (value) {},
                            ),
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          const Text(
                            "-",
                            style: TextStyle(
                                fontSize: 22.0, color: Color(0xff393e48)),
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Expanded(
                            child: QDropdownField(
                              label: "Train Classes",
                              value: "",
                              // validator: Validator.required,
                              items: const [
                                {
                                  "label": "Executive",
                                  "value": "Executive",
                                },
                                {
                                  "label": "Business",
                                  "value": "Business",
                                },
                                {
                                  "label": "Economy",
                                  "value": "Economy",
                                }
                              ],
                              onChanged: (value, label) {},
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      SizedBox(
                        height: 48,
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xfffdc620),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const SeatPickerView())),
                          child: const Text(
                            "Search",
                            style: TextStyle(
                              color: Color(0xff383d47),
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  State<DashboardView> createState() => DashboardController();
}
