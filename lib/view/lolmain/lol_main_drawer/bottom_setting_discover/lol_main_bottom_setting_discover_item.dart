import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_app/beans/lol_account_info/lol_account_info.dart';
import 'package:flutter_app/customviews/custom_unread_red_tip.dart';
import 'package:flutter_app/view/lolmain/lol_main_drawer/bottom_setting_discover/bottom_settings/bottom_setting.dart';

import '../../../view_share_widget.dart';

class LolMainBottomSettingDiscoverItem extends StatefulWidget {
  final Stream<LolAccountInfoDatas> lolMainStream;
  final int settingDiscoverItemIndex;
  final int itemsCount;
  final IconData settingDiscoverItemIconData;
  final String settingDiscoverItemText;

  LolMainBottomSettingDiscoverItem(
      {this.lolMainStream,
      this.settingDiscoverItemIndex: 0,
      this.itemsCount: 2,
      this.settingDiscoverItemIconData,
      this.settingDiscoverItemText: ""});

  @override
  _LolMainBottomSettingDiscoverItemState createState() =>
      _LolMainBottomSettingDiscoverItemState();
}

class _LolMainBottomSettingDiscoverItemState
    extends State<LolMainBottomSettingDiscoverItem> {
  GlobalKey _mBottomItemIconKey = GlobalKey();
  GlobalKey _mBottomItemTextKey = GlobalKey();

  double _bottomItemWidth;
  double _bottomItemIconWidth;

  double _bottomItemTextWidth;
  double _bottomItemTextHeight;

  Map<String, Map<int, bool>> _settingDiscoverItemReadData;
  Map<int, bool> _itemReadMap;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(_getSizes);

    _settingDiscoverItemReadData = HashMap();
    _itemReadMap = HashMap();
    for (int index = 0; index < widget.itemsCount; index++) {
      _itemReadMap[index] = false;
    }
    _settingDiscoverItemReadData["settingDiscoverItemReadData"] = _itemReadMap;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          print(
              "LolMainBottomSettingDiscover bottom click index ${widget.settingDiscoverItemIndex}");
          _onClickItem(context, widget.settingDiscoverItemIndex);
        },
        child: Container(
//        color: Colors.lightBlue,
            width: _bottomItemWidth,
            child: Row(children: <Widget>[
              Icon(widget.settingDiscoverItemIconData,
                  key: _globalKey(
                      widget.settingDiscoverItemIndex, "bottomItemIcon"),
                  size: 15.0,
                  color: Colors.white),
              Container(
//              color: Colors.purple,
                  width: _bottomItemTextWidth,
                  height: _bottomItemTextHeight,
                  margin: EdgeInsets.only(left: 5.0),
                  child: Stack(children: <Widget>[
                    Text(widget.settingDiscoverItemText,
                        key: _globalKey(
                            widget.settingDiscoverItemIndex, "bottomItemText"),
                        style: TextStyle(fontSize: 15.0, color: Colors.white)),
                    Align(
                        alignment: Alignment.topRight,
                        child: _getUnReadRedTipStreamBuilder())
                  ]))
            ])));
  }

  Widget _getUnReadRedTipStreamBuilder() {
    return StreamBuilder(
        stream: widget.lolMainStream,
        builder: (BuildContext context,
            AsyncSnapshot<LolAccountInfoDatas> snapShot) {
          bool hasUnread = false;
          if (snapShot.connectionState == ConnectionState.active) {
            AccountUnread accountUnread = snapShot.data.accountUnread;
            hasUnread = _getHasUnread(accountUnread);
          }
          return Container(
              margin: EdgeInsets.only(left: 5.0),
              child: ViewShareWidget(
                  data: _settingDiscoverItemReadData,
                  child: CustomUnReadRedTip(
                      fromType: "bottom_setting_discover",
                      tipIndex: widget.settingDiscoverItemIndex,
                      tipWidth: 6.0,
                      tipHeight: 6.0,
                      tipVisiable: hasUnread,
                      tipTextVisiable: false)));
        });
  }

  bool _getHasUnread(AccountUnread accountUnread) {
    switch (widget.settingDiscoverItemIndex) {
      case 0:
        return accountUnread.hasSettings;
        break;
      case 1:
        return accountUnread.hasDiscovers;
        break;
      default:
        return false;
        break;
    }
  }

  void _onClickItem(context, index) {
    setState(() {
      _itemReadMap[index] = true;
    });
    _navigateToItemWidget(context, index);
//    Future.delayed(Duration(milliseconds: 2000), () {
//      setState(() {
//        _itemReadMap[index] = false;
//      });
//    });
  }

  _navigateToItemWidget(BuildContext context, int index) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            //等待数据传回来
            builder: (context) => _itemWidget(index)));
    setState(() {
      _itemReadMap[index] = false;
    });
  }

  Widget _itemWidget(index) {
    switch (index) {
      case 0:
        return Settings();
        break;
      case 1:
        return Settings();
        break;
      default:
        return null;
        break;
    }
  }

  GlobalKey _globalKey(index, type) {
    switch (type) {
      case "bottomItemText":
        return _mBottomItemTextKey;
        break;
      case "bottomItemIcon":
        return _mBottomItemIconKey;
        break;
      default:
        return null;
        break;
    }
  }

  _getSizes(_) {
    //BottomItemIcon
    RenderObject renderObject =
        _mBottomItemIconKey.currentContext.findRenderObject();
    setState(() {
      _bottomItemIconWidth = renderObject.paintBounds.size.width;
      print(
          "item index ${widget.settingDiscoverItemIndex} _bottomItemIconWidth:$_bottomItemIconWidth");
    });

    //BottomItemText
    renderObject = _mBottomItemTextKey.currentContext.findRenderObject();
    _bottomItemTextWidth = renderObject.paintBounds.size.width;
    _bottomItemTextHeight = renderObject.paintBounds.size.height;
    setState(() {
      _bottomItemTextWidth = _bottomItemTextWidth + 2.0;
      _bottomItemTextHeight = _bottomItemTextHeight + 2.0;
      print(
          "item index ${widget.settingDiscoverItemIndex} _bottomItemTextWidth:$_bottomItemTextWidth,_bottomItemTextHeight:$_bottomItemTextHeight");
    });

    //BottomItem
    setState(() {
      _bottomItemWidth = _bottomItemIconWidth + _bottomItemTextWidth + 6.0;
      print(
          "item index ${widget.settingDiscoverItemIndex} _bottomItemWidth:$_bottomItemWidth");
    });
  }
}
