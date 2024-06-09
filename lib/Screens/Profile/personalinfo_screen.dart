// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gap/gap.dart';
import 'package:subtraingrad/Style/app_styles.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({super.key});

  @override
  _PersonalInfoState createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  bool passwordObscured = true;
  bool _confirmPasswordObscured = true;
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _genderController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final User? _user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _fetchData() async {
    if (_user != null) {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(_user.uid)
          .get();
      final userData = snapshot.data();
      if (userData != null) {
        setState(() {
          _firstNameController.text = userData['firstName'];
          _lastNameController.text = userData['lastName'];
          _genderController.text = userData['gender'];
          _emailController.text = userData['email'];
          _phoneController.text = userData['phone'];
        });
      }
    }
  }

  Future<void> _updateData() async {
    if (!_passwordConfirmed()) {
      _showErrorDialog('Passwords do not match.');
      return;
    }
    await FirebaseFirestore.instance
        .collection('users')
        .doc(_user!.uid)
        .update({
      'firstName': _firstNameController.text,
      'lastName': _lastNameController.text,
      'phone': _phoneController.text,
    });

    if (_passwordController.text.isNotEmpty) {
      await _user.updatePassword(_passwordController.text);
    }
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
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Profile',
        style: MyFonts.appbar,
      )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SubTextField(
                enable: false,
                controller: _emailController,
                textLabel: 'Email',
                hint: 'Email',
                textInputType: TextInputType.emailAddress,
              ),
              const Gap(24),
              SubTextField(
                enable: false,
                controller: _genderController,
                textLabel: 'Gender',
                hint: 'Gender',
                textInputType: TextInputType.text,
              ),
              const Gap(24),
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
                controller: _phoneController,
                textLabel: 'Phone',
                hint: 'Phone',
                textInputType: TextInputType.number,
              ),
              const Gap(24),
              SubPassField(
                  controller: _passwordController,
                  textLabel: "New Password",
                  obscureText: passwordObscured,
                  onPressed: () {
                    setState(() {
                      passwordObscured = !passwordObscured;
                    });
                  },
                  hintText: "New Password"),
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
              const Gap(24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: _updateData,
                child: Ink(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromRGBO(26, 96, 122, 1),
                        Color.fromRGBO(71, 126, 148, 1.0),
                      ],
                    ),
                  ),
                  child: Container(
                    width: 300,
                    height: 75,
                    alignment: Alignment.center,
                    child: Text('Update Profile',
                        style: MyFonts.font24White
                            .copyWith(fontWeight: FontWeight.bold)
                        // fontFamily: GoogleFonts.manrope().fontFamily,

                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
