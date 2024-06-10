import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:subtraingrad/Screens/Profile/announce_screen.dart';
import 'package:subtraingrad/Screens/Profile/favorite_screen.dart';
import 'package:subtraingrad/Screens/Profile/personalinfo_screen.dart';
import 'package:subtraingrad/Screens/Profile/previoustrips_screen.dart';
import 'package:subtraingrad/Style/app_layout.dart';
import 'package:subtraingrad/Style/app_styles.dart';

class SettingButton extends StatelessWidget {
  final String text;
  final int bKey;

  const SettingButton({super.key, required this.text, required this.bKey});

  static final List<Widget> _widgetOptions = <Widget>[
    const PersonalInfo(),
    const Announcements(),
    const Favorite(),
    const PreviousTrips()
  ];

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);

    return SizedBox(
      height: 50,
      width: size.width * 0.90,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.rightToLeft,
                duration: const Duration(milliseconds: 500),
                isIos: true,
                child: _widgetOptions[bKey],
              ),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: MyFonts.font18Black
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Transform.flip(
                  flipX: true,
                  child: const Icon(Icons.arrow_back_ios_new_rounded)),
            ],
          ),
        ),
      ),
    );
  }
}
