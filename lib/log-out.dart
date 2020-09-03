import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogOut extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LogOutState();
  }
}

class LogOutState extends State<LogOut> {
  Future<SharedPreferences> prefs;

  @override
  void initState() {
    prefs = SharedPreferences.getInstance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'You are about to logout',
        style: TextStyle(
          fontSize: 20.0,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
      )),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(10.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Are you sure ?',
                style: TextStyle(
                  //fontFamily: 'Pacifico',
                  fontSize: 40.0,
                  color: Colors.amber,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                  height: 60,
                  width: 180,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.amber),
                  child: FlatButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut().then((value) {
                        prefs.then((sharedPref) => sharedPref.clear());
                        Navigator.of(context).pushReplacementNamed('/login');
                      }).catchError((e) {
                        print(e);
                      });
                    },
                    child: Text(
                      'Yes',
                      style: TextStyle(
                        //fontFamily: 'Pacifico',
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )),
            ]),
      ),
    );
  }
}
