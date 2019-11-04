import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/lol_splash.dart';


void main(){
  // 强制竖屏
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  runApp(new MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LolSplash()
    );
  }
}