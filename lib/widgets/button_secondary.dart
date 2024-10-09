// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors
import 'package:flutter/material.dart';

class ButtonSecondary extends StatelessWidget {
  final VoidCallback onTap;
  final String text;

  const ButtonSecondary({
    Key? key,
    required this.onTap,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.all(
        Radius.circular(50.0),
      ),
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.all(
          Radius.circular(50.0),
        ),
        child: SizedBox(
          width: double.infinity,
          height: 52,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0XFF070623),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
