import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Info {
  static error(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.red,
      gravity: ToastGravity.CENTER,
      toastLength: Toast.LENGTH_LONG,
    );
  }

  static success(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.green,
      gravity: ToastGravity.CENTER,
      toastLength: Toast.LENGTH_LONG,
    );
  }

  static netral(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.blue,
      gravity: ToastGravity.CENTER,
      toastLength: Toast.LENGTH_LONG,
    );
  }
}
