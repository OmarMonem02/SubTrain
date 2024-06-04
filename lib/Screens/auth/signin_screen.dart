// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:subtraingrad/Screens/auth/main_page.dart';
import 'package:subtraingrad/Screens/auth/welcome_screen.dart';
import 'package:subtraingrad/Style/app_layout.dart';
import 'package:subtraingrad/Style/app_styles.dart';

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
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Welcome()),
                );
              },
            ),
            Text(
              'Sign in',
              style: MyFonts.font24Black.copyWith(
                  fontWeight: FontWeight.bold, color: Styles.primaryColor),
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
                    'assets/logoblue.png',
                    alignment: Alignment.center,
                    height: 250,
                    width: 250,
                  ),
                ),
                const SizedBox(height: 16),
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
                      child: Text(
                        "Forget Password?",
                        style: MyFonts.font16BlackFaded,
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.only(
                      bottom: 8, left: 32, right: 32, top: 8),
                  child: InkWell(
                    onTap: () => signIn(),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Styles.primaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'Sign In',
                          style: MyFonts.font18White,
                        ),
                      ),
                    ),
                  ),
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
                          style: MyFonts.font16GrayFaded,
                        ),
                        const SizedBox(width: 2),
                        GestureDetector(
                          onTap: widget.showSignUpPage,
                          child: Text(
                            "Sign Up",
                            style: MyFonts.font16BlackFaded,
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
