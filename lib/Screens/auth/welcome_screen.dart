import 'package:flutter/material.dart';
import 'package:subtraingrad/Screens/auth/auth_page.dart';
import 'package:subtraingrad/Style/app_styles.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 80,
                ),
                const Text(
                  "Welcome",
                  style: TextStyle(
                      fontSize: 33,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(26, 96, 122, 1)),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Image(
                  alignment: Alignment.center,
                  image: AssetImage('assets/logoblue.png'),
                  height: 350,
                ),
                const SizedBox(
                  height: 70,
                ),
                Container(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 20, top: 60),
                  decoration: BoxDecoration(
                    color: Styles.primaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35),
                    ),
                  ),
                  height: 450.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(
                        height: 32,
                      ),
                      // Sign In Button
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AuthPage()),
                            );
                          },
                          child: Ink(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Styles.contrastColor,
                            ),
                            child: Container(
                              width: 300,
                              height: 80,
                              alignment: Alignment.center,
                              child: Text(
                                'Get Start',
                                style: MyFonts.font30White,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40.0),
                      const SizedBox(
                        height: 15.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
