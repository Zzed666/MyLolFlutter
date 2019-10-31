import 'package:flutter/material.dart';
import 'package:flutter_app/customviews/custom_bakground.dart';
import 'package:flutter_app/view/lolmain/lol_main_drawer/personal_card/lol_main_personal_card.dart';

class LolMainDrawer extends StatefulWidget {
  String mainDrawerIconUrl;

  LolMainDrawer({this.mainDrawerIconUrl});

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
              LolMainPersonalCard(mainDrawerIconUrl: widget.mainDrawerIconUrl)
            ])));
  }
}
