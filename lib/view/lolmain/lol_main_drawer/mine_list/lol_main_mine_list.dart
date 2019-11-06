import 'package:flutter/material.dart';
import 'package:flutter_app/beans/lol_account_info/lol_account_info.dart';
import 'package:flutter_app/view/lolmain/lol_main_drawer/mine_list/lol_main_mine_list_item.dart';

class LolMainMineList extends StatefulWidget {
  final Stream<LolAccountInfoDatas> lolMainStream;

  LolMainMineList({this.lolMainStream});

  @override
  _LolMainMineListState createState() => _LolMainMineListState();
}

class _LolMainMineListState extends State<LolMainMineList> {
  List<String> _textList = ["与我相关", "活动中心", "我的订单", "我的任务", "我的收藏"];

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
    return LolMainMineListItem(
        lolMainStream: widget.lolMainStream,
        itemIndex: index,
        itemText: _textList[index]);
  }
}
