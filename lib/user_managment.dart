import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'main.dart';

class UserManagment {
  storeNewUser(user, context){
    Firestore.instance.collection('/users')
    .add({
      'email': user.email,
      'uid': user.uid

    }).
    then((value){
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed('/filter');

    })
    .catchError((e){
      print(e);
    });
  }
}