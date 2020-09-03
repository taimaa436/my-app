import 'package:flutter/material.dart';
import 'package:testx/splash.dart';
import 'log-in.dart';
import 'sign-up.dart';
import 'filter.dart';
import 'log-out.dart';
import 'news-screen.dart';
import 'profile-page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Khabar',
      theme: ThemeData(primarySwatch: Colors.amber),
      home: SplashScreen(),
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => LogIn(),
        '/signup': (BuildContext context) => Signup(),
        '/filter': (BuildContext context) => Filter(),
        '/news': (BuildContext context) => SourceScreen(),
        '/logout': (BuildContext context) => LogOut(),
        '/profile': (BuildContext context) => Profile(),
      },
    );
  }
}
