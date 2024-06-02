import 'package:flutter/material.dart';
class Styles {
  static Color backGroundColor = const Color(0xFFF6F6F6);
  static Color primaryColor = const Color(0xFF287094);
  static Color secondaryColor = const Color(0xFFD4D4CE);
  static Color primary2Color = const Color(0xFF287094);
  static Color secondary2Color = const Color(0xFFD4D4CE);
  static Color thirdColor = const Color(0xFF023246);
  static Color textColor = const Color(0xFF3B3B3B);

  static TextStyle textStyle =
      TextStyle(fontSize: 16, color: textColor, fontWeight: FontWeight.w500);
  static TextStyle headLineStyle1 =
      TextStyle(fontSize: 26, color: textColor, fontWeight: FontWeight.bold);
  static TextStyle headLineStyle2 =
      TextStyle(fontSize: 21, color: textColor, fontWeight: FontWeight.bold);
  static TextStyle headLineStyle3 =
      const TextStyle(fontSize: 17, fontWeight: FontWeight.w500);
  static TextStyle headLineStyle4 =
      const TextStyle(fontSize: 14, fontWeight: FontWeight.w500);
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
  backgroundColor: const Color.fromRGBO(128, 84, 84, 1.0),
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
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            decoration: InputDecoration(
              hintText: hint,
              labelText: textLabel,
              labelStyle: TextStyle(fontSize: 15),
              hintStyle: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
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
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
          obscureText: obscureText,
          decoration: InputDecoration(
            labelText: textLabel,
            labelStyle: TextStyle(fontSize: 15),
            suffixIcon: IconButton(
              onPressed: onPressed,
              icon: Icon(
                obscureText
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
              ),
            ),
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
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
