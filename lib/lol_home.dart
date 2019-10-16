import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter_app/beans/lol_legends_list/lol_legends_list.dart';
import 'package:flutter_app/customviews/custom_click_button.dart';
import 'package:flutter_app/lol_select_skin.dart';

class LolHome extends StatefulWidget {
  @override
  _LolHomeState createState() => _LolHomeState();
}

class _LolHomeState extends State<LolHome> {
  List<Datas> _lolLegendsList = List();
  List<Datas> _lolLegendsListBackUp = List();
  ScrollController _scrollController;
  bool isLoading = false;
  bool loadMore = false;
  int page = 0;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          loadMore = true;
        });
        _getLolLegendsList();
      }
    });
    loadMore = true;
    _getLolLegendsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/img_lol_bg.jpg"),
                    fit: BoxFit.cover)),
            child: RefreshIndicator(
                onRefresh: _getLolLegendsList,
                child: ListView.builder(
                    itemCount: _lolLegendsList.length + 1,
                    itemBuilder: _itemWidget,
                    controller: _scrollController))));
  }

  Future _getLolLegendsList() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      if (loadMore) {
        page++;
      } else {
        page = 1;
        _lolLegendsList.clear();
        _lolLegendsListBackUp.clear();
      }
      Response _response = await Dio().get(
          "https://www.fastmock.site/mock/14630744ec2c11c6b04a1c0638c9a839/firsttest/api/getLolLegendsList?page=$page");
      setState(() {
        List<Datas> _lolLegendDatas =
            lol_legends_list.fromJson(_response.data).datas;
        if (_lolLegendDatas != null) {
          _lolLegendsList
              .addAll(lol_legends_list.fromJson(_response.data).datas);
          _lolLegendsListBackUp
              .addAll(lol_legends_list.fromJson(_response.data).datas);
        } else {
          print("暂无数据");
        }
        isLoading = false;
        loadMore = false;
      });
    }
  }

  Widget _itemWidget(context, index) {
    if (index < _lolLegendsList.length) {
      return Column(children: <Widget>[
        Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.all(10.0),
            child: Text(
              _lolLegendsList[index].legendName,
              style: TextStyle(fontSize: 16.0, color: Colors.white),
              textAlign: TextAlign.left,
            )),
        Container(
            width: double.maxFinite,
            height: 180.0,
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 1.0, color: Colors.black))),
            child: Stack(children: <Widget>[
              ConstrainedBox(
                  constraints: BoxConstraints.expand(),
                  child: Image.network(_lolLegendsList[index].legendImageUrl,
                      fit: BoxFit.cover)),
              //毛玻璃(蒙层:矩形剪辑->背景过滤->透明度)
              Center(
                  child: ClipRect(
                      child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                          child: Opacity(
                              opacity: 0.8,
                              child: Container(
                                  width: double.maxFinite,
                                  height: double.maxFinite,
                                  child: Row(children: <Widget>[
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                            margin: EdgeInsets.only(left: 20.0),
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    top: BorderSide(
                                                        color: Colors.black),
                                                    right: BorderSide(
                                                        color: Colors.black),
                                                    bottom: BorderSide(
                                                        color: Colors.black),
                                                    left: BorderSide(
                                                        color: Colors.black))),
                                            constraints: BoxConstraints.expand(
                                                width: 120.0, height: 120.0),
                                            child: Image.network(
                                                _lolLegendsListBackUp[index]
                                                    .legendImageUrl,
                                                fit: BoxFit.fill))),
                                    Container(
                                        width: 200.0,
                                        margin: EdgeInsets.only(left: 10.0),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              RichText(
                                                  text: TextSpan(
                                                      style: TextStyle(
                                                          color: Colors.green),
                                                      text: "Age:",
                                                      children: <TextSpan>[
                                                    TextSpan(
                                                        text:
                                                            "${_lolLegendsList[index].legendAge}",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white))
                                                  ])),
                                              RichText(
                                                  text: TextSpan(
                                                      style: TextStyle(
                                                          color: Colors.yellow),
                                                      text: "Position:",
                                                      children: <TextSpan>[
                                                    TextSpan(
                                                        text:
                                                            "${_lolLegendsList[index].legendPosition}",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white))
                                                  ])),
                                              RichText(
                                                  text: TextSpan(
                                                      style: TextStyle(
                                                          color:
                                                              Colors.redAccent),
                                                      text: "Words:",
                                                      children: <TextSpan>[
                                                    TextSpan(
                                                        text:
                                                            "${_lolLegendsList[index].legendWords}",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white))
                                                  ])),
                                              _getBtnWidget(context,index,_lolLegendsList[index].legendId)
//                                              FlatButton(
//                                                  child: Text("Select Skin",
//                                                      style: TextStyle(
//                                                          fontSize: 12.0)),
//                                                  textColor: Colors.white,
//                                                  disabledTextColor:
//                                                      Colors.blueGrey,
//                                                  color: Colors.lightBlue,
//                                                  disabledColor: Colors.grey,
//                                                  highlightColor: Colors.brown,
//                                                  splashColor: Colors.black12,
//                                                  padding: EdgeInsets.all(2.0),
//                                                  colorBrightness:
//                                                      Brightness.dark,
//                                                  shape: RoundedRectangleBorder(
//                                                      borderRadius:
//                                                          BorderRadius.circular(
//                                                              4.0)),
//                                                  onPressed: () {
//                                                    _skipToSelectSkin(
//                                                        context,
//                                                        index,
//                                                        _lolLegendsList[index]
//                                                            .legendId);
//                                                  })

                                            ]))
                                  ]))))))
            ]))
      ]);
    }
    return Offstage(
        offstage: !loadMore,
        child: Center(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
              CircularProgressIndicator(strokeWidth: 1.0),
              Text("加载中...")
            ])));
  }

  Widget _getBtnWidget(BuildContext context, int index,String legendId){
    VoidCallback _clickFuction = (){
      _skipToSelectSkin(context, index, legendId);
    };
    CustomClickButton _customClickButton = CustomClickButton(isEnable: true,btnWidth: 85.0,btnHeight: 30.0,btnText: "Select Skin",clickFunction: _clickFuction);
    return _customClickButton;
  }

  Future _skipToSelectSkin(BuildContext context, int index,String legendId) async {
    final _selectSkinImgUrl = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LolSelectSkin(legendId)));
    setState(() {
      if(_selectSkinImgUrl != null) {
        _lolLegendsList[index].legendImageUrl = _selectSkinImgUrl;
      }
    });
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
