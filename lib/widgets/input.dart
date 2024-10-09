// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors

import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final String icon;
  final String hint;
  final TextEditingController editingController;
  final bool? obsecure;
  final bool enable;
  final VoidCallback? onTapBox;

  const Input({
    Key? key,
    required this.icon,
    required this.hint,
    required this.editingController,
    this.obsecure,
    this.enable = true,
    this.onTapBox,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapBox,
      child: TextField(
        controller: editingController,
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          color: Color(0XFF070623),
        ),
        obscureText: obsecure ?? false,
        decoration: InputDecoration(
          enabled: enable,
          hintText: hint,
          hintStyle: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
            color: Color(0XFF070623),
          ),
          fillColor: Colors.white, // background field
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(
              color: Color(0XFF4A1DFF),
              width: 2,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: 14,
            horizontal: 16,
          ),
          isDense: true,
          prefixIcon: UnconstrainedBox(
            // Menyesuaikan dengan ukuran field
            alignment: Alignment(0.4, 0),
            child: Image.asset(
              icon,
              height: 24,
            ),
          ),
        ),
      ),
    );
  }
}
