import 'package:flutter/material.dart';
import 'package:flutter_app/beans/lol_account_info/lol_account_info.dart';
import 'package:flutter_app/customviews/custom_bakground.dart';
import 'package:flutter_app/view/lolmain/lol_main_drawer/mine_list/lol_main_mine_list.dart';
import 'package:flutter_app/view/lolmain/lol_main_drawer/personal_card/lol_main_personal_card.dart';

import 'bottom_setting_discover/lol_main_bottom_setting_discover.dart';

class LolMainDrawer extends StatefulWidget {
  final Stream<LolAccountInfoDatas> lolMainStream;

  LolMainDrawer({this.lolMainStream});

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
            childWidget: Container(
                constraints: BoxConstraints.expand(),
                child: Stack(children: <Widget>[
                  Column(children: <Widget>[
                    LolMainPersonalCard(lolMainStream: widget.lolMainStream),
                    LolMainMineList(lolMainStream: widget.lolMainStream)
                  ]),
                  LolMainBottomSettingDiscover(
                      lolMainStream: widget.lolMainStream)
                ]))));
  }
}
