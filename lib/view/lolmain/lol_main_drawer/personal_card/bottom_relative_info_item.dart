import 'dart:collection';
import 'package:flutter/material.dart';

class BottomRelativeInfo extends StatefulWidget {
  final int attention;
  final int fans;
  final int goodFriends;
  final int publish;

  BottomRelativeInfo(
      {this.attention: 0, this.fans: 0, this.goodFriends: 0, this.publish: 0});

  @override
  _BottomRelativeInfoState createState() => _BottomRelativeInfoState();
}

class _BottomRelativeInfoState extends State<BottomRelativeInfo> {
  List<String> _textList = ["关注", "粉丝", "好友", "发表"];
  Map<String, dynamic> _infoMap = HashMap();

  GlobalKey _myKey = new GlobalKey();

  double _itemWidth;
  double _itemHeight;

  @override
  void initState() {
    _infoMap[_textList[0]] = widget.attention;
    _infoMap[_textList[1]] = widget.fans;
    _infoMap[_textList[2]] = widget.goodFriends;
    _infoMap[_textList[3]] = widget.publish;

    WidgetsBinding.instance.addPostFrameCallback(_getSizes);

    _itemWidth = 10.0;
    _itemHeight = 10.0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Center(
            child: Container(
                key: _myKey,
                width: double.maxFinite,
                height: 55.0,
                margin: EdgeInsets.only(top: 6.0),
                child: ListView.builder(
                    itemCount: _infoMap.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                          width: _itemWidth,
                          child: GestureDetector(
                              onTap: () {
                                print("BottomRelativeInfo item index $index isClicked");
                              },
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                        padding: EdgeInsets.all(1.5),
                                        child: Text(
                                            "${_infoMap[_textList[index]]}",
                                            style: TextStyle(
                                                color: Colors.orangeAccent,
                                                fontSize: 14.0))),
                                    Padding(
                                        padding: EdgeInsets.all(1.5),
                                        child: Text(_textList[index],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12.0)))
                                  ])));
                    }))));
  }

  ///https://www.cnblogs.com/pythonClub/p/10869832.html
  _getSizes(_) {
    RenderObject renderObject = _myKey.currentContext.findRenderObject();
    setState(() {
      _itemWidth = renderObject.paintBounds.size.width / 4;
      _itemHeight = renderObject.paintBounds.size.height;
      print("_itemWidth:$_itemWidth,_itemHeight:$_itemHeight");
    });
  }
}
