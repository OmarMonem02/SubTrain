import 'package:flutter/material.dart';

Color primary = const Color(0xFFEEEdf2);

class DarkStyle {
  static Color primaryColor = primary;
  static Color textColor = const Color(0xFF3B3B3B);
  static Color bdColor = const Color.fromARGB(255, 249, 249, 249);
  static Color mainColor = const Color(0xFF1a5f7a);
  static Color main2Color = const Color(0xff1e8bb4);
  static Color secColor = const Color(0xFFECBA00);
  static Color sec2Color = const Color(0xFFECBA55);
  static TextStyle textStyle =
      TextStyle(fontSize: 16, color: textColor, fontWeight: FontWeight.w500);
  static TextStyle headLineStyle1 =
      TextStyle(fontSize: 26, color: textColor, fontWeight: FontWeight.bold);
  static TextStyle headLineStyle2 =
      TextStyle(fontSize: 21, color: textColor, fontWeight: FontWeight.bold);
  static TextStyle headLineStyle3 = TextStyle(
      fontSize: 17, color: Colors.grey.shade500, fontWeight: FontWeight.w500);
  static TextStyle headLineStyle4 = TextStyle(
      fontSize: 14, color: Colors.grey.shade500, fontWeight: FontWeight.w500);
}

class Styles {
  static Color primaryColor = primary;
  static Color textColor = const Color(0xFF3B3B3B);
  static Color bdColor = const Color.fromARGB(255, 249, 249, 249);
  static Color mainColor = const Color(0xFF1a5f7a);
  static Color main2Color = const Color(0xff1e8bb4);
  static Color secColor = const Color(0xFFECBA00);
  static Color sec2Color = const Color(0xFFECBA55);

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
  backgroundColor: Styles.mainColor,
  elevation: 0,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(50),
    ),
  ),
);

final ButtonStyle buttonSecondary = ElevatedButton.styleFrom(
  minimumSize: const Size(230, 55),
  backgroundColor: const Color.fromRGBO(71, 126, 148, 1.0),
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
            style: TextStyle(
                color: Styles.mainColor,
                fontSize: 18,
                fontWeight: FontWeight.w600),
            decoration: InputDecoration(
              hintText: hint,
              labelText: textLabel,
              labelStyle: TextStyle(color: Styles.mainColor, fontSize: 20),
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
                  color: Styles.mainColor,
                  width: 2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  width: 2,
                  color: Styles.secColor,
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
          style: const TextStyle(
            color: Color.fromRGBO(26, 96, 122, 1),
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          obscureText: obscureText,
          decoration: InputDecoration(
            labelText: textLabel,
            labelStyle: TextStyle(color: Styles.mainColor, fontSize: 20),
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
