// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../common/info.dart';
import '../source/auth_source.dart';
import '../widgets/button_primary.dart';
import '../widgets/input.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final editEmail = TextEditingController();
  final editPassword = TextEditingController();

  signIn() {
    if (editEmail.text == '') return Info.error('Email must be filled');
    if (editPassword.text == '') return Info.error('Password must be filled');

    Info.netral('Loading...');
    AuthSource.signIn(
      editEmail.text,
      editPassword.text,
    ).then(
      (message) {
        if (message != 'success') return Info.error(message);

        // Success
        Info.success('Success Sign In');
        Future.delayed(
          Duration(milliseconds: 1500),
          () {
            Navigator.pushReplacementNamed(context, '/list-chat');
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 0),
        children: [
          Gap(100),
          Image.asset(
            "assets/logo_text.png",
            width: 171.0,
            height: 38.0,
          ),
          Gap(70),
          Text(
            "Sign In Account",
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Color(0XFF070623),
            ),
          ),
          Gap(30),
          Text(
            "Email Address",
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: Color(0XFF070623),
            ),
          ),
          Gap(12),
          Input(
            icon: 'assets/ic_email.png',
            hint: 'Write your real email',
            editingController: editEmail,
          ),
          Gap(20),
          Text(
            "Password",
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: Color(0XFF070623),
            ),
          ),
          Gap(12),
          Input(
            icon: 'assets/ic_key.png',
            hint: 'Write your password',
            editingController: editPassword,
            obsecure: true,
          ),
          Gap(30),
          ButtonPrimary(
            text: 'Sign In',
            onTap: signIn,
          ),
          Gap(30),
        ],
      ),
    );
  }
}
