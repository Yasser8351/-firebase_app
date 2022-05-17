import 'package:flutter/material.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';

import '../user_share_pref.dart';
import 'auth.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    getUserStatus();
  }

  int userStatus = 0;

  getUserStatus() async {
    SharedPrefUser prefs = SharedPrefUser();
    int currentStatus = await prefs.getID();
    setState(() {
      userStatus = currentStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.10),
        child: EasySplashScreen(
          durationInSeconds: 3,
          navigator: Auth(id: userStatus),
          logo: Image.asset(
            'assets/logo.png',
            fit: BoxFit.fill,
          ),
          logoSize: 220,
          backgroundColor: Colors.white,
          loaderColor: Colors.white,
        ),
      ),
    );
  }
}
