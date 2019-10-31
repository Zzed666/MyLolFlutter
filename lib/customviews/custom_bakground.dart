import 'package:flutter/material.dart';

class CustomWithBackGround extends StatefulWidget {
  final Widget childWidget;
  final double bgImgOpacity;
  final ImageProvider imageProvider;

  CustomWithBackGround(
      {this.imageProvider: const AssetImage("images/img_lol_bg.jpg"),
      @required this.childWidget,
      this.bgImgOpacity: 1.0});

  @override
  _CustomWithBackGroundState createState() => _CustomWithBackGroundState();
}

class _CustomWithBackGroundState extends State<CustomWithBackGround> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Opacity(
          opacity: widget.bgImgOpacity,
          child: Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: widget.imageProvider, fit: BoxFit.cover)),
            /*child: widget.childWidget*/
          )),
      widget.childWidget
    ]);
  }
}
