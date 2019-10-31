import 'package:flutter/material.dart';
import 'package:flutter_app/customviews/custom_circle_icon.dart';
import 'package:flutter_app/view/lolmain/lol_main_drawer/personal_card/name_level_gender_item.dart';

import 'bottom_relative_info_item.dart';

class LolMainPersonalCard extends StatefulWidget {
  String mainDrawerIconUrl;

  LolMainPersonalCard({this.mainDrawerIconUrl});

  @override
  _LolMainPersonalCardState createState() => _LolMainPersonalCardState();
}

class _LolMainPersonalCardState extends State<LolMainPersonalCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        constraints:
            BoxConstraints.expand(width: double.maxFinite, height: 180.0),
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
                      border:
                          Border.all(width: 2.0, color: Colors.orangeAccent)),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        NameLevelGender(),
                        _getDivider(),
                        BottomRelativeInfo()
                      ]))),
          Align(
              alignment: Alignment.topCenter,
              child: Container(
                  margin: EdgeInsets.only(top: 5.0),
                  child: GestureDetector(
                      child: CustomCircleIcon(
                          iconWidth: 50.0,
                          iconHeight: 50.0,
                          iconUrl: widget.mainDrawerIconUrl,
                          iconCircleBorderWidth: 2.0))))
        ]));
  }
  Widget _getDivider(){
    return Container(
      margin: EdgeInsets.only(top: 20.0,left: 10.0,right: 10.0),
      child: Divider(height: 1.0,color: Colors.orangeAccent)
    );
  }
}
