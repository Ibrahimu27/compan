import 'package:compan/main.dart';
import 'package:flutter/material.dart';

void nextScreen (context , page){
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

void nextScreenReplaced(context, page){
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>page));
}

void showSnackBar(context, message, color){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      message,
      style: TextStyle(fontSize: 14),
    ),

    backgroundColor: color,
    duration: Duration(seconds: 2),
    action: SnackBarAction(
      label: "OK",
      onPressed: (){},
      textColor: Colors.white,
    ),
  ));
}