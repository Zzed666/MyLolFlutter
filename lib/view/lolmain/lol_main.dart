import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_app/customviews/custom_bakground.dart';
import 'package:flutter_app/view/lolmain/lol_main_bottom_item.dart';

class LoLMain extends StatefulWidget {
  @override
  _LoLMainState createState() => _LoLMainState();
}

class _LoLMainState extends State<LoLMain> with TickerProviderStateMixin {
  int _bottomTabIndex;
  List<TabController> _tabControllerList = List();
  List<LoLMainBottomItem> _loLMainBottomItems = List();
  Map<int, List<String>> _mainMap = HashMap();

  @override
  void initState() {
    _bottomTabIndex = 0;
    _mainMap[0] = List.generate(2, (index) => "0:index$index");
    _mainMap[1] = List.generate(3, (index) => "1:index$index");
    _mainMap[2] = List.generate(4, (index) => "2:index$index");
    _mainMap[3] = List.generate(5, (index) => "3:index$index");
    _mainMap.forEach((index, tabList) {
      _tabControllerList
          .add(TabController(length: tabList.length, vsync: this));
      bool select = (index == _bottomTabIndex);
      LoLMainBottomItem loLMainBottomItem = LoLMainBottomItem(
          bottomIndex: index,
          iconData: Icons.add,
          iconText: "${index + 1}",
          initialSelect: select);
      _loLMainBottomItems.add(loLMainBottomItem);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomWithBackGround(
        childWidget: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
                backgroundColor: Colors.transparent,
                title: TabBar(
                    controller: _tabControllerList[_bottomTabIndex],
                    tabs: List<Widget>.generate(
                        _mainMap[_bottomTabIndex].length,
                        (index) => Text("tab$index")))),
            body: TabBarView(
                controller: _tabControllerList[_bottomTabIndex],
                children: List<Widget>.generate(
                    _mainMap[_bottomTabIndex].length,
                    (index) =>
                        Center(child: Text(_mainMap[_bottomTabIndex][index])))),
            bottomNavigationBar: BottomAppBar(
                child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: _getBottomChildren()))));
  }

  List<Widget> _getBottomChildren() {
    if (_mainMap.isNotEmpty) {
      return List<Widget>.generate(
          _mainMap.length,
          (index) => AbsorbPointer(
              absorbing: false,
              child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _bottomTabIndex = index;
                      _setBottomSelect(_bottomTabIndex);
                    });
                  },
                  child: _loLMainBottomItems[index])));
    } else
      return null;
  }

  void _setBottomSelect(index) {
    if (_loLMainBottomItems.isNotEmpty) {
      for (int i = 0; i < _loLMainBottomItems.length; i++) {
        if (index == i)
          _loLMainBottomItems[index].setSelect(index, true);
        else
          _loLMainBottomItems[i].setSelect(i, false);
      }
    }
  }
}
