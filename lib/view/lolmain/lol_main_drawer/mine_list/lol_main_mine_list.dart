import 'package:flutter/material.dart';
import 'package:flutter_app/beans/lol_account_info/lol_account_info.dart';

class LolMainMineList extends StatefulWidget {
  final Stream<LolAccountInfoDatas> lolMainStream;

  LolMainMineList({this.lolMainStream});
  @override
  _LolMainMineListState createState() => _LolMainMineListState();
}

class _LolMainMineListState extends State<LolMainMineList> {
  List<String> _textList = ["与我相关", "活动中心", "我的订单", "我的任务", "我的收藏"];
  List<IconData> _iconList = [
    Icons.mail,
    Icons.business_center,
    Icons.receipt,
    Icons.book,
    Icons.collections
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.maxFinite,
        height: 52.0 * 5,
        margin: EdgeInsets.all(5.0),
        child: ListView.builder(
            padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
            itemCount: _textList.length,
            itemBuilder: _getListViewItem));
  }

  Widget _getListViewItem(context, index) {
    return Container(
        padding: EdgeInsets.fromLTRB(30.0, 15.0, 15.0, 15.0),
        child: GestureDetector(
            onTap: () {
              print("LolMainMineList click item $index");
            },
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(_iconList[index], color: Colors.white, size: 14.0),
                  Padding(
                      padding: EdgeInsets.only(left: 30.0),
                      child: Text(_textList[index],
                          style:
                              TextStyle(color: Colors.white, fontSize: 14.0)))
                ])));
  }
}
