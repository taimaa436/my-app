import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfileState();
  }
}

class ProfileState extends State<Profile> {
  Future<SharedPreferences> prefs;
  String email = "";
  List<String> categories = [];
  @override
  void initState() {
    prefs = SharedPreferences.getInstance();
    prefs.then((sharedPref) {
      setState(() {
        categories = sharedPref.getStringList("categories");
        categories.removeWhere((element) => element.contains(" false"));
        categories = categories.map((e) => e.split(" ")[0]).toList();
        FirebaseAuth.instance.currentUser().then((FirebaseUser user) {
          email = user.email;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Personal information',
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 30)),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Text('Email :',
                          style: TextStyle(
                            fontSize: 18,
                            //color: Colors.amber,
                            fontWeight: FontWeight.w500,
                          )),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(bottom: 30),
                      child: Text(email,
                          style: TextStyle(
                            fontSize: 20,
                            //color: Colors.amber,
                            fontWeight: FontWeight.w400,
                          )),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(bottom: 15),
                      child: Text('Selected Categories :',
                          style: TextStyle(
                            fontSize: 18,
                            //color: Colors.amber,
                            fontWeight: FontWeight.w500,
                            //fontFamily: 'Pacifico',
                          )),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(bottom: 15),
                      child: Text(categories.join(" , "),
                          style: TextStyle(
                            fontSize: 20,
                            //color: Colors.amber,
                            fontWeight: FontWeight.w400,
                            //fontFamily: 'Pacifico',
                          )),
                    )
                  ],
                ),
              ),
              Container(
                  alignment: Alignment.center,
                  height: 40,
                  width: MediaQuery.of(context).size.width * 0.7,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.amber),
                  child: FlatButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/filter');
                    },
                    child: Text(
                      'change category',
                      style: TextStyle(
                        //fontFamily: 'Pacifico',
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
