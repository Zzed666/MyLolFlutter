import 'package:flutter/material.dart';
import 'package:flutter_app/beans/lol_account_info/lol_account_info.dart';
import 'package:flutter_app/customviews/custom_circle_icon.dart';
import 'package:flutter_app/view/lolmain/lol_main_drawer/personal_card/name_level_gender_item.dart';

import 'bottom_relative_info_item.dart';

class LolMainPersonalCard extends StatefulWidget {
  final Stream<LolAccountInfoDatas> lolMainStream;

  LolMainPersonalCard({this.lolMainStream});

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
                  child: _getStreamBuilder("bodyInfo"))),
          Align(
              alignment: Alignment.topCenter,
              child: Container(
                  margin: EdgeInsets.only(top: 5.0),
                  child: GestureDetector(child: _getStreamBuilder("headIcon"))))
        ]));
  }

  Widget _getStreamBuilder(String type) {
    return StreamBuilder(
        stream: widget.lolMainStream,
        builder: (BuildContext context,
            AsyncSnapshot<LolAccountInfoDatas> snapshot) {
          String accountIconUrl;
          String accountName = "User001";
          String accountGender = "男";
          int accountLevel = 0;
          if (snapshot.connectionState == ConnectionState.active) {
            accountIconUrl = snapshot.data.accountHeadPortrait;
            accountName = snapshot.data.accountName;
            accountGender = snapshot.data.accountGender;
            accountLevel = snapshot.data.accountLevel;
          }
          if (type == "headIcon") {
            return CustomCircleIcon(
                iconWidth: 50.0,
                iconHeight: 50.0,
                iconUrl: accountIconUrl,
                iconCircleBorderWidth: 2.0);
          } else if (type == "bodyInfo") {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  NameLevelGender(
                      name: accountName,
                      gender: accountGender,
                      level: accountLevel),
                  _getDivider(),
                  BottomRelativeInfo(lolMainStream: widget.lolMainStream)
                ]);
          } else {
            return null;
          }
        });
  }

  Widget _getDivider() {
    return Container(
        margin: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
        child: Divider(height: 1.0, color: Colors.orangeAccent));
  }
}
