import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogIn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LogInState();
  }
}

class LogInState extends State<LogIn> {
  Future<SharedPreferences> prefs;
  String _email;
  String _password;
  double _width;
  String _err = "";
  @override
  void initState() {
    prefs = SharedPreferences.getInstance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/back.jpg"),
                fit: BoxFit.cover,
                alignment: Alignment.center,
                colorFilter: ColorFilter.mode(
                    Colors.white.withAlpha(220), BlendMode.luminosity))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              'Khabar',
              style: TextStyle(
                fontFamily: 'Chomsky',
                fontSize: 80.0,
                color: Colors.amber,
                fontWeight: FontWeight.w500,
              ),
            ),
            Container(
              padding: EdgeInsets.all(30.0),
              margin: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(235, 162, 9, 0.5),
                      blurRadius: 20,
                      offset: Offset(0, 10),
                    )
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                      child: TextField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.email),
                      hintText: 'Enter your Email',
                    ),
                    onChanged: (emailValue) {
                      setState(() {
                        _email = emailValue;
                      });
                    },
                  )),
                  Container(
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      child: TextField(
                        decoration: InputDecoration(
                          icon: Icon(Icons.lock),
                          hintText: 'Enter your password',
                        ),
                        onChanged: (passwordValue) {
                          setState(() {
                            _password = passwordValue;
                          });
                        },
                        obscureText: true,
                      )),
                  Visibility(
                    visible: _err != "" ? true : false,
                    child: Container(
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      child: Row(children: <Widget>[
                        Icon(
                          Icons.info_outline,
                          color: Colors.red,
                          size: 14,
                        ),
                        Padding(padding: EdgeInsets.only(left: 10)),
                        Flexible(
                            child: Text(
                          _err,
                          style: TextStyle(fontSize: 14, color: Colors.red),
                          textAlign: TextAlign.left,
                        ))
                      ]),
                    ),
                  ),
                  Container(
                      height: 40,
                      width: _width * 0.7,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: Colors.amber),
                      child: FlatButton(
                        onPressed: () {
                          setState(() {
                            _err = "";
                          });
                          FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: _email, password: _password)
                              .then((user) {
                            prefs.then((sharedPref) {
                              try {
                                if (sharedPref.getStringList("categories") ==
                                    null) {
                                  Navigator.of(context)
                                      .pushReplacementNamed('/filter');
                                } else {
                                  Navigator.of(context)
                                      .pushReplacementNamed('/news');
                                }
                              } catch (e) {
                                Navigator.of(context)
                                    .pushReplacementNamed('/filter');
                              }
                            });
                          }).catchError((e) {
                            print(e);
                            setState(() {
                              if (e.toString().contains("!= null")) {
                                _err = "Please verify your inputs";
                              } else if (e
                                  .toString()
                                  .contains("There is no user record")) {
                                _err = "User not found";
                              } else if (e
                                  .toString()
                                  .contains("ERROR_WRONG_PASSWORD")) {
                                _err = "Invalid email or password";
                              } else if (e.toString().contains(
                                  "Too many unsuccessful login attempts")) {
                                _err =
                                    "Too many unsuccessful login attempts. Please try again later";
                              } else {
                                _err = "Error";
                              }
                            });
                          });
                        },
                        child: Text(
                          'log in',
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
            Text(
              'Don\'t have an account?',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Container(
                height: 40,
                width: _width * 0.7,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: Colors.amber),
                child: FlatButton(
                  onPressed: () {
                    setState(() {
                      _err = "";
                    });
                    Navigator.of(context).pushNamed('/signup');
                  },
                  child: Text(
                    'Sign Up',
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
    );
  }
}
