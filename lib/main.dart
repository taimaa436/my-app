import 'package:flutter/material.dart';
import 'log-in.dart';
import 'sign-up.dart';
import 'filter.dart';
import 'log-out.dart';
import 'out.dart';
import 'news-screen.dart';
import 'profile-page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Top Headlines',
        theme: ThemeData(primarySwatch: Colors.amber),
        home: LogIn(),
        routes: <String , WidgetBuilder>{
          '/login': (BuildContext context) => MyApp(),
          '/signup' :  (BuildContext context) => Signup(),
          '/filter' :  (BuildContext context) => Filter(),
          '/out' : (BuildContext context)  => OutNow(), 
          '/news' :(BuildContext context)  => SourceScreen(),
          '/logout' :(BuildContext context)  => LogOut(),
          '/profile' :(BuildContext context)  => Profile(),

          

        },

    );
  }
}






