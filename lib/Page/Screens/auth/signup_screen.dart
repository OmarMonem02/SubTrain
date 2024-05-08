// ignore_for_file: use_build_context_synchronously, avoid_print, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:subtraingrad/Page/Screens/auth/add_new_user.dart';
import 'package:subtraingrad/Page/Screens/auth/main_page.dart';
import 'package:subtraingrad/Page/Screens/auth/welcome_screen.dart';
import 'package:subtraingrad/Style/app_layout.dart';
import 'package:subtraingrad/Style/app_styles.dart';
import 'package:gap/gap.dart';

class SignUp extends StatefulWidget {
  final VoidCallback showLoginPage;

  const SignUp({super.key, required this.showLoginPage});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _passwordObscured = true;
  bool _confirmPasswordObscured = true;
  String _gender = 'Select Gender';
  bool _signingUp = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    if (!_passwordConfirmed()) {
      _showErrorDialog('Passwords do not match.');
      return;
    }
    setState(
      () {
        _signingUp = true;
      },
    );
    try {
      // ignore: unused_local_variable
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      String userID = userCredential.user!.uid;

      await adduser(userID);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
      );
    } catch (e) {
      _showErrorDialog('$e');
    } finally {
      setState(() {
        _signingUp = false;
      });
    }
  }

  Future<void> adduser(useriD) async {
    Map<String, dynamic> userInfoMap = {
      "ID": useriD,
      "firstName": _firstNameController.text,
      "lastName": _lastNameController.text,
      "phone": _phoneNumberController.text,
      "email": _emailController.text,
      "gender": _gender,
      "password": _passwordController.text,
      "balance": 0,
    };
    await DatabaseMethod().addUserDetails(userInfoMap, useriD);
  }

  bool _passwordConfirmed() {
    return _passwordController.text.trim() ==
        _confirmPasswordController.text.trim();
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            BackButton(
              color: const Color.fromRGBO(26, 96, 122, 1),
              onPressed: () {
                Navigator.pop(
                  context,
                  MaterialPageRoute(builder: (context) => const Welcome()),
                );
              },
            ),
            const SizedBox(
              width: 0,
            ),
            const Text(
              'SIGN UP',
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
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(16),
                const Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text(
                    'Enter Your Information',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Gap(18),
                Row(
                  children: [
                    Expanded(
                      child: SubTextField(
                        enable: true,
                        controller: _firstNameController,
                        textLabel: 'First Name',
                        hint: 'First Name',
                        textInputType: TextInputType.name,
                      ),
                    ),
                    Expanded(
                      child: SubTextField(
                        enable: true,
                        controller: _lastNameController,
                        textLabel: 'Last Name',
                        hint: 'Last Name',
                        textInputType: TextInputType.name,
                      ),
                    ),
                  ],
                ),
                const Gap(24),
                SubTextField(
                  enable: true,
                  controller: _emailController,
                  textLabel: 'Email',
                  hint: 'Enter Your Email',
                  textInputType: TextInputType.emailAddress,
                ),
                const Gap(24),
                Row(
                  children: [
                    Expanded(
                      child: SubTextField(
                        enable: true,
                        controller: _phoneNumberController,
                        textLabel: 'Phone Number',
                        hint: 'Phone Number',
                        textInputType: TextInputType.phone,
                      ),
                    ),
                    Expanded(
                      child: DropdownButtonFormField(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        value: _gender,
                        icon: const Icon(Icons.menu),
                        onChanged: (value) {
                          setState(() {
                            _gender = value.toString();
                          });
                        },
                        items: const [
                          DropdownMenuItem(
                              value: 'Select Gender',
                              child: Text('Select Gender')),
                          DropdownMenuItem(value: 'Male', child: Text('Male')),
                          DropdownMenuItem(
                              value: 'Female', child: Text('Female')),
                        ],
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 17),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(26, 96, 122, 1),
                                width: 2),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              width: 2,
                              color: Color.fromRGBO(26, 96, 122, 1),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(24),
                SubPassField(
                  textLabel: 'Password',
                  controller: _passwordController,
                  obscureText: _passwordObscured,
                  hintText: 'Enter Your Password',
                  onPressed: () {
                    setState(() {
                      _passwordObscured = !_passwordObscured;
                    });
                  },
                ),
                const Gap(24),
                SubPassField(
                  textLabel: 'Confirm Password',
                  controller: _confirmPasswordController,
                  obscureText: _confirmPasswordObscured,
                  hintText: 'Confirm Password',
                  onPressed: () {
                    setState(() {
                      _confirmPasswordObscured = !_confirmPasswordObscured;
                    });
                  },
                ),
                const Gap(32),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: InkWell(
                    onTap: _signingUp ? null : _signUp,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Styles.mainColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'Sign Up',
                          style: Styles.headLineStyle1
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                const Gap(16),
                Center(
                  child: SizedBox(
                    width: size.width * 0.7,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: Styles.headLineStyle3.copyWith(
                            color: Theme.of(context).colorScheme.onSecondary,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        GestureDetector(
                          onTap: widget.showLoginPage,
                          child: Text(
                            "Sign In",
                            style: Styles.headLineStyle3
                                .copyWith(color: Styles.secColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Gap(24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
