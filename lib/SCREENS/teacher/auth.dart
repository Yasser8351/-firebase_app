import 'package:firebase_app/SCREENS/student/tab_screen_student.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../student/login.dart';

class Auth extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Auth({Key? key}) : super(key: key);
  static const routeName = "Auth";

  @override
  Widget build(BuildContext context) {
    if (_auth.currentUser != null) {
      return const TabScreenStudent();
    } else {
      return const Login();
    }
  }
}
