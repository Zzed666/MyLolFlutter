import 'package:flutter/material.dart';
import 'package:flutter_app/beans/lol_account_info/lol_account_info.dart';
import 'package:flutter_app/view/lolmain/lol_main_drawer/bottom_setting_discover/lol_main_bottom_setting_discover_item.dart';

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

  List<String> _textList = ["设置", "发现"];
  List<IconData> _iconList = [Icons.settings, Icons.accessibility];

  double _bottomWidth;

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
    return LolMainBottomSettingDiscoverItem(
        lolMainStream: widget.lolMainStream,
        itemsCount: _textList.length,
        settingDiscoverItemIndex: index,
        settingDiscoverItemText: _textList[index],
        settingDiscoverItemIconData: _iconList[index]);
  }

  _getSizes(_) {
    //BottomCantainer
    RenderObject renderObject =
        _mBottomCantainKey.currentContext.findRenderObject();
    setState(() {
      _bottomWidth = renderObject.paintBounds.size.width;
      print("_bottomWidth:$_bottomWidth");
    });
  }
}
