import 'package:flutter/material.dart';
import 'package:flutter_app/lol_splash.dart';

void main()=>runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LolSplash()
    );
  }
}