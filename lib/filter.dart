import 'news-screen.dart';
import 'model.dart';
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
      width: double.infinity,
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
            )
            
          ],
        ),
        ),
    ),
   );
  }

}