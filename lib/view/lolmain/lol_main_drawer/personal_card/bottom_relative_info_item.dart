import 'package:flutter/material.dart';
import 'package:flutter_app/beans/lol_account_info/lol_account_info.dart';
import 'package:flutter_app/view/lolmain/lol_main_drawer/personal_card/bottom_relative_info_item_number.dart';

class BottomRelativeInfo extends StatefulWidget {
  final Stream<LolAccountInfoDatas> lolMainStream;

  BottomRelativeInfo({this.lolMainStream});

  @override
  _BottomRelativeInfoState createState() => _BottomRelativeInfoState();
}

class _BottomRelativeInfoState extends State<BottomRelativeInfo> {
  List<String> _textList = ["关注", "粉丝", "好友", "发表"];
  GlobalKey _myKey = new GlobalKey();

  double _itemWidth;
  double _itemHeight;

  @override
  void initState() {
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
                    itemCount: _textList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                          width: _itemWidth,
                          child: GestureDetector(
                              onTap: () {
                                print(
                                    "BottomRelativeInfo item index $index isClicked");
                              },
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                        padding: EdgeInsets.all(1.5),
                                        child: _getRelativeInfoItemNumberStream(
                                            index)),
                                    Padding(
                                        padding: EdgeInsets.all(1.5),
                                        child: Text(_textList[index],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12.0)))
                                  ])));
                    }))));
  }

  Widget _getRelativeInfoItemNumberStream(index) {
    return StreamBuilder(
        stream: widget.lolMainStream,
        builder: (BuildContext context,
            AsyncSnapshot<LolAccountInfoDatas> snapshot) {
          int accountAttentions = 0;
          int accountFans = 0;
          int accountGoodFriends = 0;
          int accountPublishs = 0;
          if (snapshot.connectionState == ConnectionState.active) {
            AccountPersonal accountPersonal = snapshot.data.accountPersonal;
            accountAttentions = accountPersonal.attentions;
            accountFans = accountPersonal.fans;
            accountGoodFriends = accountPersonal.goodFriends;
            accountPublishs = accountPersonal.publishes;
          }
          return _getRelativeInfoItemNumber(index, accountAttentions,
              accountFans, accountGoodFriends, accountPublishs);
        });
  }

  Widget _getRelativeInfoItemNumber(index, accountAttentions, accountFans,
      accountGoodFriends, accountPublishs) {
    switch (_textList[index]) {
      case "关注":
        return RelativeInfoItemNumber(numberValue: accountAttentions);
        break;
      case "粉丝":
        return RelativeInfoItemNumber(numberValue: accountFans);
        break;
      case "好友":
        return RelativeInfoItemNumber(numberValue: accountGoodFriends);
        break;
      case "发表":
        return RelativeInfoItemNumber(numberValue: accountPublishs);
        break;
    }
    return RelativeInfoItemNumber();
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
