// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_session/d_session.dart';

class AuthSource {
  static Future<String> signIn(
    String email,
    String password,
  ) async {
    final csDoc =
        await FirebaseFirestore.instance.collection('Admin').doc('cs').get();
    final cs = csDoc.data()!;
    if (email == cs['email'] && password == cs['password']) {
      DSession.setUser(cs);
      return 'success';
    }
    return 'Sign In Failed';
  }
}
