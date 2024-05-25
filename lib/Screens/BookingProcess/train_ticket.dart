// import 'package:dropdownfield2/dropdownfield2.dart';
// import 'package:flutter/material.dart';

// class TrainTicket extends StatefulWidget {
//   const TrainTicket({super.key});

//   @override
//   State<TrainTicket> createState() => TrainTicketState();
// }

// class TrainTicketState extends State<TrainTicket> {
//   final List<String> suggestions = [
//     'Andhra Pradesh',
//     'Assam',
//     'Arunachal Pradesh',
//     'Bihar',
//     'Goa',
//     'Gujarat',
//     'Jammu and Kashmir',
//     'Jharkhand',
//     'West Bengal',
//     'Karnataka',
//     'Kerala',
//     'Madhya Pradesh',
//     'Maharashtra',
//     'Manipur',
//     'Meghalaya',
//     'Mizoram',
//     'Nagaland',
//     'Orissa',
//     'Punjab',
//     'Rajasthan',
//     'Sikkim',
//     'Tamil Nadu',
//     'Tripura',
//     'Uttaranchal',
//     'Uttar Pradesh',
//     'Haryana',
//     'Himachal Pradesh',
//     'Chhattisgarh'
//   ];
//   final statesStartContolar = TextEditingController();
//   final statesEndContolar = TextEditingController();
//   String selectState = "";

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           DropDownField(
//             controller: statesStartContolar,
//             hintText: 'Search',
//             enabled: true,
//             itemsVisibleInDropdown: 6,
//             items: suggestions,
//             onValueChanged: (value) {
//               setState(() {
//                 selectState = value;
//               });
//             },
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           DropDownField(
//             controller: statesEndContolar,
//             hintText: 'Search',
//             enabled: true,
//             itemsVisibleInDropdown: 6,
//             items: suggestions,
//             onValueChanged: (value) {
//               setState(() {
//                 selectState = value;
//               });
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
