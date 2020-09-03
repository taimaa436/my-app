import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  FirebaseUser loggedUser;

  @override
  void initState() {
    Timer(
        Duration(seconds: 4),
        () => {
              FirebaseAuth.instance.currentUser().then((FirebaseUser user) {
                print(" The user " + user.toString());
                if (user != null) {
                  Navigator.of(context).pushReplacementNamed('/news');
                } else {
                  Navigator.of(context).pushReplacementNamed('/login');
                }
              })
            });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/back.jpg"),
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  colorFilter: ColorFilter.mode(
                      Colors.white.withAlpha(220), BlendMode.luminosity))),
          child: Text(
            'Khabar',
            style: TextStyle(
              fontFamily: 'Chomsky',
              fontSize: 80.0,
              color: Colors.amber,
              fontWeight: FontWeight.w500,
            ),
          )),
    );
  }
}
