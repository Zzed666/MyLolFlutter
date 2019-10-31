import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/beans/lol_account_info/lol_account_info.dart';
import 'package:flutter_app/customviews/custom_bakground.dart';
import 'package:flutter_app/customviews/custom_circle_icon.dart';
import 'package:flutter_app/lol_legends.dart';
import 'package:flutter_app/view/lolmain/lol_main_bottom_item.dart';
import 'package:flutter_app/customviews/custom_search_widget.dart';
import 'package:flutter_app/view/view_model_provider.dart';
import 'package:flutter_app/viewmodel/lolmain/lol_main_view_model.dart';

import 'lol_main_drawer/lol_main_drawer.dart';

const List<String> bottomBarList = ["资讯", "商城", "盟友圈", "战绩"];
const List<IconData> bottomBarIconList = [
  Icons.event,
  Icons.shop,
  Icons.memory,
  Icons.restore
];
const List<String> tabInfoList = ["推荐", "总决赛", "视频", "英雄"];
const List<String> tabShopList = ["商城"];
const List<String> tabCircleList = ["推荐", "关注", "趣玩"];
const List<String> tabRecordList = ["战绩"];

class LoLMain extends StatefulWidget {
  @override
  _LoLMainState createState() => _LoLMainState();
}

class _LoLMainState extends State<LoLMain> with TickerProviderStateMixin {
  int _bottomTabIndex;
  Map<int, List<String>> _mainMap = HashMap();
  List<TabController> _tabControllerList = List();
  List<LoLMainBottomItem> _loLMainBottomItems = List();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  FocusNode _focusNode;

  LolMainViewModel _lolMainViewModel;

  @override
  void initState() {
    _lolMainViewModel = ViewModelProvider.of(context);
    _lolMainViewModel.doInit(context);

    _bottomTabIndex = 0;
    _mainMap[0] = tabInfoList;
    _mainMap[1] = tabShopList;
    _mainMap[2] = tabCircleList;
    _mainMap[3] = tabRecordList;
    _mainMap.forEach((index, tabList) {
      _tabControllerList
          .add(TabController(length: tabList.length, vsync: this));
      bool select = (index == _bottomTabIndex);
      LoLMainBottomItem loLMainBottomItem = LoLMainBottomItem(
          bottomIndex: index,
          iconData: bottomBarIconList[index],
          iconText: "${bottomBarList[index]}",
          initialSelect: select);
      _loLMainBottomItems.add(loLMainBottomItem);
    });
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomWithBackGround(
        childWidget: GestureDetector(
            onTap: () => _focusNode.unfocus(),
            child: Scaffold(
                key: _scaffoldKey,
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                    backgroundColor: Colors.transparent,
                    title: _getAppBarTitle(),
                    centerTitle: true,
                    leading: Builder(builder: (BuildContext context) {
                      return _getAppBarLeadingIcon(
                          () => _scaffoldKey.currentState.openDrawer());
                    })),
                drawer: StreamBuilder(
                    stream: _lolMainViewModel.lolMainAccountDataStream,
                    builder:
                        (BuildContext context, AsyncSnapshot<Datas> snapshot) {
                      String drawerIconUrl;
                      if (snapshot.connectionState == ConnectionState.active) {
                        drawerIconUrl = snapshot.data.accountHeadPortrait;
                      }
                      return LolMainDrawer(mainDrawerIconUrl: drawerIconUrl);
                    }),
                body: _getBody(),
                bottomNavigationBar: BottomAppBar(
                    color: Colors.white,
                    child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: _getBottomChildren())))));
  }

  ///return app bar title
  Widget _getAppBarLeadingIcon(VoidCallback voidCallback) {
    return IconButton(
        icon: StreamBuilder(
            stream: _lolMainViewModel.lolMainAccountDataStream,
            builder: (BuildContext context, AsyncSnapshot<Datas> snapshot) {
              String leadingIconUrl;
              if (snapshot.connectionState == ConnectionState.active) {
                //TODO 这里设置leadingIconUrl不可以使用setState
                leadingIconUrl = snapshot.data.accountHeadPortrait;
              }
              return CustomCircleIcon(
                  iconWidth: 30.0,
                  iconHeight: 30.0,
                  iconUrl: leadingIconUrl,
                  iconCircleBorderWidth: 1.0);
            }),
        onPressed: voidCallback);
  }

  ///return app bar title
  Widget _getAppBarTitle() {
    Widget widget;
    if (_mainMap[_bottomTabIndex].length == 1) {
      var value = _mainMap[_bottomTabIndex][0];
      switch (value) {
        case "商城":
          widget = CustomSearchWidget(
            focusNode: _focusNode,
            textEditingController: TextEditingController(),
            hintText: "搜索你喜欢的商品",
            hintTextColor: Colors.brown,
            inputFormatters: [
              LengthLimitingTextInputFormatter(50),
            ],
          );
          break;
        case "战绩":
          widget = CircleAvatar(
              radius: 20.0,
              backgroundImage:
                  AssetImage("images/img_lol_app_bar_leading_defalut.jpg"));
          break;
      }
    } else {
      widget = TabBar(
          isScrollable: true,
          controller: _tabControllerList[_bottomTabIndex],
          tabs: List<Widget>.generate(_mainMap[_bottomTabIndex].length,
              (index) => Text("${_mainMap[_bottomTabIndex][index]}")));
    }
    return widget;
  }

  ///return body widget
  Widget _getBody() {
    Widget widget;
    switch (bottomBarList[_bottomTabIndex]) {
      case "资讯":
        widget = TabBarView(
            controller: _tabControllerList[_bottomTabIndex],
            children: _getTabBarViewChildren(
                bottomBarList[_bottomTabIndex], tabInfoList));
        break;
      case "商城":
        widget = CircleAvatar(
            radius: 10.0,
            backgroundImage:
                AssetImage("images/img_lol_app_bar_leading_defalut.jpg"));
        break;
      case "盟友圈":
        widget = TabBarView(
            controller: _tabControllerList[_bottomTabIndex],
            children: _getTabBarViewChildren(
                bottomBarList[_bottomTabIndex], tabCircleList));
        break;
      case "战绩":
        widget = Text("战绩");
        break;
    }
    return widget;
  }

  ///return tab bar view children
  List<Widget> _getTabBarViewChildren(
      String bottomTabText, List<String> tabList) {
    List<Widget> _tabBarViews = List();
    if (tabList.isNotEmpty && tabList.length > 1) {
      tabList.forEach((tabText) {
        switch (tabText) {
          case "推荐":
            if (bottomTabText == "资讯") {
              _tabBarViews.add(IconButton(
                  icon: CircleAvatar(
                      radius: 10.0,
                      backgroundImage: AssetImage(
                          "images/img_lol_app_bar_leading_defalut.jpg"))));
            } else if (bottomTabText == "盟友圈") {
              _tabBarViews.add(Text("盟友圈-推荐"));
            }
            break;
          case "总决赛":
            _tabBarViews.add(Text("总决赛"));
            break;
          case "视频":
            _tabBarViews.add(Text("视频"));
            break;
          case "英雄":
            _tabBarViews.add(LolLengends());
            break;
          case "关注":
            _tabBarViews.add(Text("关注"));
            break;
          case "趣玩":
            _tabBarViews.add(Text("趣玩"));
            break;
          case "战绩":
            _tabBarViews.add(Text("战绩"));
            break;
        }
      });
    }
    return _tabBarViews;
  }

  ///return bottom tap item
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

  ///set bottom item selected
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

  @override
  void dispose() {
    _focusNode?.unfocus();
    _focusNode?.dispose();
    super.dispose();
  }
}
