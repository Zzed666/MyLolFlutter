import 'package:flutter/material.dart';
import 'package:flutter_app/beans/lol_account_info/lol_account_info.dart';
import 'dart:collection';

import 'package:flutter_app/customviews/custom_unread_red_tip.dart';
import 'package:flutter_app/view/lolmain/lol_main_drawer/mine_list/mine_relation/relative_to_me.dart';
import 'package:flutter_app/view/view_share_widget.dart';

class LolMainMineListItem extends StatefulWidget {
  final Stream<LolAccountInfoDatas> lolMainStream;
  final int itemIndex;
  final String itemText;

  LolMainMineListItem(
      {this.lolMainStream, this.itemIndex: 0, this.itemText: ""});

  @override
  _LolMainMineListItemState createState() => _LolMainMineListItemState();
}

class _LolMainMineListItemState extends State<LolMainMineListItem> {
  List<IconData> _iconList = [
    Icons.mail,
    Icons.business_center,
    Icons.receipt,
    Icons.book,
    Icons.collections
  ];
  Map<String, Map<int, bool>> _mineListItemReadData;
  Map<int, bool> _itemReadMap;

  @override
  void initState() {
    _mineListItemReadData = HashMap();
    _itemReadMap = HashMap();
    for (int index = 0; index < _iconList.length; index++) {
      _itemReadMap[index] = false;
    }
    _mineListItemReadData["mineListItemReadData"] = _itemReadMap;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(30.0, 15.0, 15.0, 15.0),
        child: GestureDetector(
            onTap: () {
              print("LolMainMineList click item ${widget.itemIndex}");
              _onClickItem(context, widget.itemIndex);
            },
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(_iconList[widget.itemIndex],
                      color: Colors.white, size: 14.0),
                  Padding(
                      padding: EdgeInsets.only(left: 30.0),
                      child: Text(widget.itemText,
                          style:
                              TextStyle(color: Colors.white, fontSize: 14.0))),
                  _getRedTipStreamBuilder(widget.itemIndex)
                ])));
  }

  Widget _getRedTipStreamBuilder(index) {
    return StreamBuilder(
        stream: widget.lolMainStream,
        builder: (BuildContext context,
            AsyncSnapshot<LolAccountInfoDatas> snapShot) {
          String redTipText = "";
          if (snapShot.connectionState == ConnectionState.active) {
            var accountUnread = snapShot.data.accountUnread;
            redTipText = _getCustomUnReadRedTipText(index, accountUnread);
          }
          return Container(
              margin: EdgeInsets.only(left: 5.0),
              child: ViewShareWidget(
                  data: _mineListItemReadData,
                  child: CustomUnReadRedTip(
                      fromType: "mine_list",
                      tipIndex: index,
                      tipWidth: 14.0,
                      tipHeight: 14.0,
                      tipTextSize: 7.0,
                      tipText: redTipText,
                      tipVisiable: _getRedTipIntitialVisiable(redTipText),
                      tipTextVisiable: true)));
        });
  }

  bool _getRedTipIntitialVisiable(text) {
    if (text != null && text.isNotEmpty)
      return true;
    else
      return false;
  }

  String _getCustomUnReadRedTipText(index, accountUnread) {
    switch (index) {
      case 0:
        return _getNumberText(accountUnread.relations);
        break;
      case 1:
        return _getNumberText(accountUnread.actions);
        break;
      case 2:
        return _getNumberText(accountUnread.orders);
        break;
      case 3:
        return _getNumberText(accountUnread.tasks);
        break;
      case 4:
        return _getNumberText(accountUnread.collections);
        break;
      default:
        return "";
        break;
    }
  }

  String _getNumberText(num) {
    if (num == null || num <= 0) {
      return "";
    } else {
      return num > 99 ? "99+" : "$num";
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
        return RelativeToMe();
        break;
      case 1:
        return RelativeToMe();
        break;
      case 2:
        return RelativeToMe();
        break;
      case 3:
        return RelativeToMe();
        break;
      case 4:
        return RelativeToMe();
        break;
      default:
        return null;
        break;
    }
  }
}
