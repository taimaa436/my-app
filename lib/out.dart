import 'package:flutter/material.dart';
import 'log-in.dart';
import 'main.dart';

class OutNow extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return OutNowState();
  }

}
class OutNowState extends State<OutNow>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Container(
       color: Colors.white,
       width: double.infinity,
       padding: EdgeInsets.all(10.0),
       child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
            Text('you are out !',
            style:TextStyle(
              fontFamily: 'Pacifico',
              fontSize: 40.0,
              color: Colors.grey[850],
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
                       Navigator.of(context).pushNamed('/login');

                        
                      },
                      child: Text('log_in again',
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
    ) ;
  }

}