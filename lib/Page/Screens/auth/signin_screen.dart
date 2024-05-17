// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:subtraingrad/Page/Screens/auth/auth_service.dart';
import 'package:subtraingrad/Page/Screens/auth/main_page.dart';
import 'package:subtraingrad/Page/Screens/auth/welcome_screen.dart';
import 'package:subtraingrad/Style/app_layout.dart';
import 'package:subtraingrad/Style/app_styles.dart';
import 'package:subtraingrad/widgets/square_button.dart';

class SignIn extends StatefulWidget {
  final VoidCallback showSignUpPage;

  const SignIn({super.key, required this.showSignUpPage});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool passwordObscured = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            BackButton(
              color: const Color.fromRGBO(26, 96, 122, 1),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Welcome()),
                );
              },
            ),
            const Text(
              'SIGN IN',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(26, 96, 122, 1),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Center(
                  child: Image.asset(
                    'assets/logo3.png',
                    alignment: Alignment.center,
                    height: 250,
                    width: 250,
                  ),
                ),
                SubTextField(
                  enable: true,
                  controller: _emailController,
                  hint: 'Email',
                  textInputType: TextInputType.emailAddress,
                  textLabel: 'Email',
                ),
                const SizedBox(height: 20),
                SubPassField(
                  controller: _passwordController,
                  textLabel: 'Password',
                  obscureText: passwordObscured,
                  onPressed: () {
                    setState(() {
                      passwordObscured = !passwordObscured;
                    });
                  },
                  hintText: 'Password',
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () async {
                        await FirebaseAuth.instance
                            .sendPasswordResetEmail(
                                email: _emailController.text)
                            .then((value) {
                          Fluttertoast.showToast(
                              msg: 'The link sent to your email');
                        });
                      },
                      child: const Text("Forget Password?"),
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
                const SizedBox(height: 18),
                InkWell(
                  onTap: () {
                    signIn();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Styles.mainColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        'Sign In',
                        style:
                            Styles.headLineStyle1.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Center(
                  child: Text(
                    'or',
                    style: Styles.headLineStyle1.copyWith(color: Colors.grey),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareButton(
                      imagePath: "assets/search.png",
                      onTap: () async {
                        await AuthService().signInWithGoogle();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Center(
                  child: SizedBox(
                    width: size.width * 0.6,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account? ',
                          style: Styles.headLineStyle4.copyWith(
                            color: Theme.of(context).colorScheme.onSecondary,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(width: 2),
                        GestureDetector(
                          onTap: widget.showSignUpPage,
                          child: Text(
                            "Sign Up",
                            style: Styles.textStyle.copyWith(
                              color: Styles.secColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signIn() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          )
          .then(
            (value) => {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MainPage()),
              ),
              Fluttertoast.showToast(msg: 'Login Successfully')
            },
          );
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
        msg: e.message.toString(),
      );
    }
  }
}
