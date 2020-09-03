import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'news-screen.dart';
import 'model.dart';
import 'article-screen.dart';
import 'package:flutter/material.dart';

class Filter extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return FilterState() ;
  }

}
class FilterState extends State<Filter>{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
    body: Container(
      //width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Text('Choose your news category',
             style: TextStyle(
                fontFamily: 'Pacifico',
              fontSize: 40.0,
              color: Colors.amber,
              fontWeight: FontWeight.bold,
             ),
            ),
            SizedBox(
              height: 30.0,
            ),
            
            Container(
              //height: 400,
              child: Padding(
                padding:EdgeInsets.all(10.0) ,
                child: Row(
                  children: <Widget>[
                    Container(
                      color: Colors.amber,
                      height: 200,
                      width: 120,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 80,
                          ),
                          Text('general',
                           style: TextStyle(
                             fontSize: 20,
                             fontWeight: FontWeight.bold,
                             color: Colors.white,
                           ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 30.0,
                    ),
                     Container(
                      color: Colors.amber,
                      height: 200,
                      width: 120,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 80,
                          ),
                          Text('technology',
                           style: TextStyle(
                             fontSize: 20,
                             fontWeight: FontWeight.bold,
                             color: Colors.white,
                           ),
                          )
                        ],
                      ),
                    ),

                  ],
                ),
              ),
             
            ),
            
          ],
        ),
        ),
    ),
   );
  }

}