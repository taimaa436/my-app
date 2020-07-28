import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'model.dart';
import 'article-screen.dart';
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






