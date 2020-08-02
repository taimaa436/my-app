import 'package:flutter/material.dart';
import 'log-in.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Top Headlines',
        theme: ThemeData(primarySwatch: Colors.amber),
        home: LogIn()

    );
  }
}






