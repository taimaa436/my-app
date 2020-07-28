import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'main.dart';
import 'news-screen.dart';


class LogIn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LogInState();
  }

}

class LogInState extends State<LogIn> {
  String _email;
  String _password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

          body: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Colors.amber[450],
                        Colors.amber[350],
                        Colors.amber[250],
                        Colors.amber[150],

                      ]
                  )
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 70.0,
                    ),
                    Text('Khabar',
                      style: TextStyle(
                        fontFamily: 'Pacifico',
                        fontSize: 60.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 25.0,
                    ),

                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50.0),
                              topRight: Radius.circular(50.0),

                            )
                        ),
                        child: ListView(children: <Widget>[
                          Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(height: 30.0),
                                  Container(
                                    // height: 200.0,

                                      padding: EdgeInsets.all(5.0),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                              10.0),
                                          boxShadow: [BoxShadow(
                                            color: Color.fromRGBO(
                                                235, 162, 9, 1),
                                            blurRadius: 20,
                                            offset: Offset(0, 10),
                                          )
                                          ]

                                      ),

                                      child: Column(
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

                                              )
                                          ),
                                          SizedBox(height: 20,),
                                          Container(

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

                                              )
                                          ),

                                        ],
                                      )


                                  ),
                                  SizedBox(height: 80,),
                                  Container(
                                      height: 60,
                                      width: 140,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              30.0),
                                          gradient: LinearGradient(
                                              colors: [
                                                Colors.amber[500],
                                                Colors.amber[400],
                                                Colors.amber[200],
                                                Colors.amber[100],

                                              ]
                                          )
                                      ),
                                      child: FlatButton(
                                        onPressed: () {

                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                                    return SourceScreen();
                                                  }));
                                        },
                                        child: Text('log in',
                                          style: TextStyle(
                                            fontFamily: 'Pacifico',
                                            fontSize: 30.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,

                                          ),
                                        ),
                                      )
                                  )


                                ],

                              )
                          ),
                        ],
                        ),
                      ),
                    ),


                  ])


          ),
        );

  }

}