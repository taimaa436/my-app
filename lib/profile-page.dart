import 'main.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ProfileState();
  }

}
class ProfileState extends State<Profile>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 60,
              ),
              Text('your Email is:',
               style: TextStyle(
                 fontSize: 24,
                 color: Colors.amber,
                 fontWeight: FontWeight.bold,
                 fontFamily: 'Pacifico',
                 
               ),
              
              ),
               SizedBox( 
                height: 70,
              ),
               Text('your password is:',
               style: TextStyle(
                 fontSize: 24,
                 color: Colors.amber,
                 fontWeight: FontWeight.bold,
                 fontFamily: 'Pacifico', 
                 
               ),
              
              ),
              SizedBox(
                height: 70,
              ),
              Text('your news category is:',
               style: TextStyle(
                 fontSize: 24,
                 color: Colors.amber,
                 fontWeight: FontWeight.bold,
                 fontFamily: 'Pacifico',
               ),
              
              ),
              SizedBox(
                height: 90,
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
                       Navigator.of(context).pushNamed('/filter');

                        
                      },
                      child: Text('change category',
                        style: TextStyle(
                          fontFamily: 'Pacifico',
                          fontSize: 24.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,

                        ),
                      ),
                    
                    )
                ),
              
            ],
          ),
        ),

        
      ),

    );
  }

}