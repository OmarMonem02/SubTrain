import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Styles {
  static Color backGroundColor = const Color(0xFFF6F6F6);
  static Color primaryColor = const Color(0xFF023246);
  static Color secondaryColor = const Color(0xFF0C7B63);
  static Color secondary2Color = Color.fromARGB(255, 160, 160, 160);
  static Color thirdColor = const Color(0xFF005566);
  static Color contrastColor = const Color(0xFFF58F00);
  static Color primary2Color = const Color(0xFF11A786);
}

class MyFonts {
  static TextStyle get font30White => GoogleFonts.fredoka(
      color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold);
  static TextStyle get font30Black => GoogleFonts.fredoka(
      color: Color(0xFF2B2B2B), fontSize: 30, fontWeight: FontWeight.bold);

  //
  static TextStyle get appbar => GoogleFonts.fredoka(
      color: Color(0xFF2B2B2B), fontSize: 30, fontWeight: FontWeight.w500);
  static TextStyle get font24White => GoogleFonts.fredoka(
      color: Colors.white, fontSize: 24, fontWeight: FontWeight.w500);
  static TextStyle get font22White =>
      GoogleFonts.fredoka(color: Colors.white, fontSize: 22);
  static TextStyle get font18White =>
      GoogleFonts.fredoka(color: Colors.white, fontSize: 18);
  static TextStyle get font16White =>
      GoogleFonts.fredoka(color: Colors.white, fontSize: 16);
  static TextStyle get font24Black => GoogleFonts.fredoka(
      color: Color(0xFF2B2B2B), fontSize: 24, fontWeight: FontWeight.w500);
  static TextStyle get font22Black =>
      GoogleFonts.fredoka(color: Color(0xFF2B2B2B), fontSize: 22);
  static TextStyle get font18Black =>
      GoogleFonts.fredoka(color: Color(0xFF2B2B2B), fontSize: 18);
  static TextStyle get font16Black =>
      GoogleFonts.fredoka(color: Color(0xFF2B2B2B), fontSize: 16);
  static TextStyle get font16WhiteFaded =>
      GoogleFonts.fredoka(color: Colors.white, fontSize: 16);
  static TextStyle get font16GrayFaded =>
      GoogleFonts.fredoka(color: Colors.grey.withOpacity(0.6), fontSize: 16);
  static TextStyle get font16BlackFaded =>
      GoogleFonts.fredoka(color: Color(0xEE2B2B2B), fontSize: 16);
}

final ButtonStyle buttonPrimary = ElevatedButton.styleFrom(
  minimumSize: const Size(230, 55),
  backgroundColor: Styles.primaryColor,
  elevation: 0,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(50),
    ),
  ),
);

final ButtonStyle buttonRed = ElevatedButton.styleFrom(
  minimumSize: const Size(230, 55),
  backgroundColor: Styles.contrastColor,
  elevation: 10,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(50),
    ),
  ),
);

class SubTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String textLabel;
  final TextInputType textInputType;
  final bool enable;

  const SubTextField(
      {super.key,
      required this.controller,
      required this.hint,
      required this.textLabel,
      required this.textInputType,
      required this.enable});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            enabled: enable,
            keyboardType: textInputType,
            controller: controller,
            style: MyFonts.font16Black,
            decoration: InputDecoration(
              hintText: hint,
              labelText: textLabel,
              labelStyle: MyFonts.font16Black,
              hintStyle: MyFonts.font16GrayFaded,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Styles.primaryColor,
                  width: 2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  width: 2,
                  color: Styles.secondaryColor,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SubPassField extends StatelessWidget {
  final TextEditingController controller;
  final String textLabel;
  final bool obscureText;
  final Function() onPressed;
  final String hintText;

  const SubPassField({
    super.key,
    required this.controller,
    required this.textLabel,
    required this.obscureText,
    required this.onPressed,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        color: Colors.transparent,
        child: TextField(
          controller: controller,
          style: MyFonts.font16Black,
          obscureText: obscureText,
          decoration: InputDecoration(
            labelText: textLabel,
            labelStyle: MyFonts.font16Black,
            suffixIcon: IconButton(
              onPressed: onPressed,
              icon: Icon(
                obscureText
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
              ),
            ),
            hintText: hintText,
            hintStyle: MyFonts.font16GrayFaded,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color.fromRGBO(26, 96, 122, 1),
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                width: 2,
                color: Color.fromRGBO(236, 186, 0, 1),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
