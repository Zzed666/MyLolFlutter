import 'package:flutter/material.dart';
import 'package:flutter_app/customviews/custom_bakground.dart';
import 'package:flutter_app/customviews/custom_circle_icon.dart';

class LolMainDrawer extends StatefulWidget {
  @override
  _LolMainDrawerState createState() => _LolMainDrawerState();
}

class _LolMainDrawerState extends State<LolMainDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: CustomWithBackGround(
            imageProvider: AssetImage("images/img_lol_main_drawer_bg.jpg"),
            bgImgOpacity: 0.8,
            childWidget: Column(children: <Widget>[
              Container(
                  constraints: BoxConstraints.expand(
                      width: double.maxFinite, height: 180.0),
                  margin: EdgeInsets.only(top: 70.0, left: 10.0, right: 10.0),
                  child: Stack(children: <Widget>[
                    Positioned(
                        top: 30.0,
                        left: 5.0,
                        right: 5.0,
                        child: Container(
                            constraints: BoxConstraints.expand(
                                width: double.maxFinite, height: 150.0),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 2.0, color: Colors.orangeAccent)))),
                    Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                            margin: EdgeInsets.only(top: 5.0),
                            child: GestureDetector(
                                child: CustomCircleIcon(
                                    iconWidth: 50.0,
                                    iconHeight: 50.0,
                                    iconCircleBorderWidth: 2.0))))
                  ]))
            ])));
  }
}
