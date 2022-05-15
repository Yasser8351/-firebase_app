import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../student/login.dart';
import '../student/tab_screen_student.dart';

class Auth extends StatefulWidget {
  const Auth({Key? key, this.id = 0}) : super(key: key);
  static const routeName = "Auth";
  final int id;

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // var pref = SharedPrefUser();

  // int id = 0;
  // @override
  // void initState() {
  //   super.initState();
  //   getUserStatus();
  // }

  // int userStatus = 0;

  // getUserStatus() async {
  //   SharedPrefUser prefs = SharedPrefUser();
  //   int currentStatus = await prefs.getID();
  //   setState(() {
  //     userStatus = currentStatus;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    if (_auth.currentUser != null) {
      return const TabScreenStudent();
      // return const TabScreenStudent();
    } else {
      return const Login();
    }
    // if (_auth.currentUser != null) {
    //   return widget.id == 1 ? const TabScreenStudent() : const MainNav();
    // } else {
    //   return const Login();
    // }
  }
}
