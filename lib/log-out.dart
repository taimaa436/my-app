import 'package:flutter/material.dart';
import 'out.dart';
import 'main.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LogOut extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return LogOutState();
  }

}
class LogOutState extends State<LogOut>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Container(
       width: double.infinity,
       padding: EdgeInsets.all(10.0),
       child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
            Text('are you sure ?',
            style:TextStyle(
              fontFamily: 'Pacifico',
              fontSize: 40.0,
              color: Colors.amber,
              fontWeight: FontWeight.bold,

            ) ,

            ),
            SizedBox(
              height: 80,
            ),
             Container(
                    height: 60,
                    width: 180,
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
                       FirebaseAuth.instance.signOut()
                       .then((value) {
                         Navigator.of(context).pushReplacementNamed('/out');
                       })
                       .catchError((e){
                         print(e);
                       });

                        
                      },
                      child: Text('yes,log out',
                        style: TextStyle(
                          fontFamily: 'Pacifico',
                          fontSize: 24.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,

                        ),
                      ),
                    
                    )
                ),
            ]
       ),
     ),
    );
  }

}