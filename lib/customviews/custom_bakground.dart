import 'package:flutter/material.dart';

class CustomWithBackGround extends StatefulWidget {
  final Widget childWidget;

  CustomWithBackGround({@required this.childWidget});

  @override
  _CustomWithBackGroundState createState() => _CustomWithBackGroundState();
}

class _CustomWithBackGroundState extends State<CustomWithBackGround> {
  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/img_lol_bg.jpg"), fit: BoxFit.cover)),
        child: widget.childWidget);
  }
}
