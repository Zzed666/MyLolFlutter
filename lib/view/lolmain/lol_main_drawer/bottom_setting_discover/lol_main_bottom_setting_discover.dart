import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/beans/lol_account_info/lol_account_info.dart';
import 'package:flutter_app/customviews/custom_unread_red_tip.dart';

class LolMainBottomSettingDiscover extends StatefulWidget {
  final Stream<LolAccountInfoDatas> lolMainStream;

  LolMainBottomSettingDiscover({this.lolMainStream});
  @override
  _LolMainBottomSettingDiscoverState createState() =>
      _LolMainBottomSettingDiscoverState();
}

class _LolMainBottomSettingDiscoverState
    extends State<LolMainBottomSettingDiscover> {
  GlobalKey _mBottomCantainKey = GlobalKey();
  GlobalKey _mBottomItemIconKey0 = GlobalKey();
  GlobalKey _mBottomItemIconKey1 = GlobalKey();
  GlobalKey _mBottomItemTextKey0 = GlobalKey();
  GlobalKey _mBottomItemTextKey1 = GlobalKey();
  List<String> _textList = ["设置", "发现"];
  List<IconData> _iconList = [Icons.settings, Icons.accessibility];

  double _bottomWidth;
  double _bottomItemWidth;
  double _bottomItemIconWidth;
  double _bottomItemIcon0Width;
  double _bottomItemIcon1Width;
  double _bottomItemTextWidth;
  double _bottomItemTextHeight;
  double _bottomItemText0Width;
  double _bottomItemText1Width;
  double _bottomItemText0Height;
  double _bottomItemText1Height;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(_getSizes);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
            key: _mBottomCantainKey,
            width: _bottomWidth,
            height: 40.0,
//            color: Colors.pinkAccent,
            margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
            child: Stack(children: <Widget>[
              Align(
                  alignment: Alignment.centerLeft,
                  child: _settingDiscoverItem(0)),
              Align(
                  alignment: Alignment.centerRight,
                  child: _settingDiscoverItem(1))
            ])));
  }

  Widget _settingDiscoverItem(int index) {
    return GestureDetector(
        onTap: () {
          print("LolMainBottomSettingDiscover bottom click index $index");
        },
        child: Container(
//        color: Colors.lightBlue,
            width: _bottomItemWidth,
            child: Row(children: <Widget>[
              Icon(_iconList[index],
                  key: _globalKey(index, "bottomItemIcon"),
                  size: 15.0,
                  color: Colors.white),
              Container(
//              color: Colors.purple,
                  width: _bottomItemTextWidth,
                  height: _bottomItemTextHeight,
                  margin: EdgeInsets.only(left: 5.0),
                  child: Stack(children: <Widget>[
                    Text(_textList[index],
                        key: _globalKey(index, "bottomItemText"),
                        style: TextStyle(fontSize: 15.0, color: Colors.white)),
                    Align(
                        alignment: Alignment.topRight,
                        child: CustomUnReadRedTip())
                  ]))
            ])));
  }

  GlobalKey _globalKey(index, type) {
    switch (index) {
      case 0:
        if (type == "bottomItemText")
          return _mBottomItemTextKey0;
        else
          return _mBottomItemIconKey0;
        break;
      case 1:
        if (type == "bottomItemText")
          return _mBottomItemTextKey1;
        else
          return _mBottomItemIconKey1;
        break;
      default:
        return null;
        break;
    }
  }

  _getSizes(_) {
    //BottomCantainer
    RenderObject renderObject =
        _mBottomCantainKey.currentContext.findRenderObject();
    setState(() {
      _bottomWidth = renderObject.paintBounds.size.width;
      print("_bottomWidth:$_bottomWidth");
    });

    //BottomItemIcon
    renderObject = _mBottomItemIconKey0.currentContext.findRenderObject();
    _bottomItemIcon0Width = renderObject.paintBounds.size.width;
    print("_bottomItemIcon0Width:$_bottomItemIcon0Width");
    renderObject = _mBottomItemIconKey1.currentContext.findRenderObject();
    _bottomItemIcon1Width = renderObject.paintBounds.size.width;
    print("_bottomItemIcon1Width:$_bottomItemIcon1Width");
    setState(() {
      _bottomItemIconWidth = max(_bottomItemIcon0Width, _bottomItemIcon1Width);
    });

    //BottomItemText
    renderObject = _mBottomItemTextKey0.currentContext.findRenderObject();
    _bottomItemText0Width = renderObject.paintBounds.size.width;
    _bottomItemText0Height = renderObject.paintBounds.size.height;
    print(
        "_bottomItemText0Width:$_bottomItemText0Width,_bottomItemText0Height:$_bottomItemText0Height");
    renderObject = _mBottomItemTextKey1.currentContext.findRenderObject();
    _bottomItemText1Width = renderObject.paintBounds.size.width;
    _bottomItemText1Height = renderObject.paintBounds.size.height;
    print(
        "_bottomItemText0Height:$_bottomItemText0Height,_bottomItemText1Height:$_bottomItemText1Height");
    setState(() {
      _bottomItemTextWidth =
          max(_bottomItemText0Width, _bottomItemText1Width) + 2.0;
      _bottomItemTextHeight =
          max(_bottomItemText0Height, _bottomItemText1Height) + 2.0;
    });

    //BottomItem
    setState(() {
      _bottomItemWidth = _bottomItemIconWidth + _bottomItemTextWidth + 6.0;
    });
  }
}
