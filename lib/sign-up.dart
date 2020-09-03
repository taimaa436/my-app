import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testx/user_managment.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Signup extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return SignupState();
  } 

}
class SignupState extends State<Signup>{
  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Text('Sign up',
            style:TextStyle(
              fontFamily: 'Pacifico',
              fontSize: 60.0,
              color: Colors.amber,
              fontWeight: FontWeight.bold,

            ) ,

            ),
            SizedBox(
              height: 30,
            ),
            Container(
            //  height: 200.0,

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
                SizedBox( height: 40,

                ),

                 Container(
                    height: 40,
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
                       FirebaseAuth.instance.createUserWithEmailAndPassword(
                         email: _email , password: _password)
                         .then((signedInUser){
                           UserManagment().storeNewUser(signedInUser , context);
                           Navigator.of(context).pushReplacementNamed('/filter');
                         })
                         .catchError((e){
                           
                           print(e);
                         });
                         

                        
                      },
                      child: Text('ok',
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
            )


                              ),

            
          ],

        ),
              
              )

          ],

        )
        
      ) ,
    );
  } 

}