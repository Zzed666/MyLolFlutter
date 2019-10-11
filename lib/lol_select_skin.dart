import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app/beans/lol_legend_skins/lol_legend_skins.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class LolSelectSkin extends StatefulWidget {
  String legendId;

  LolSelectSkin(this.legendId);

  @override
  _LolSelectSkinState createState() => _LolSelectSkinState();
}

class _LolSelectSkinState extends State<LolSelectSkin> {
  List<Datas> _skinList = List();
  SwiperControl _swiperControl;
  bool _isLoading = false;
  bool _hasDatas = false;
  int _skinIndex = 0;

  @override
  void initState() {
    _swiperControl = SwiperControl();
    _getLegendSkins(widget.legendId);
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
            child: Container(
              child: Stack(children: <Widget>[
                Center(
                    child: Offstage(
                        offstage: !_isLoading,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              CircularProgressIndicator(strokeWidth: 1.0),
                              Text("加载中...")
                            ]))),
                Center(
                    child: Container(
                        width: 200.0,
                        height: 200.0,
                        child: Offstage(
                            offstage: _hasDatas,
                            child: Stack(children: <Widget>[
                              Opacity(
                                  opacity: 0.5,
                                  child: Image.asset(
                                      "images/img_lol_nothing.jpg")),
                              Align(
                                  alignment: Alignment.center,
                                  child: Text("木有皮肤哦～",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.purpleAccent,
                                          fontSize: 18.0)))
                            ])))),
                Center(
                    child: Offstage(
                        offstage: !_hasDatas,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  alignment: Alignment.center,
                                  constraints: BoxConstraints.expand(
                                      width: MediaQuery.of(context).size.width,
                                      height: 300.0),
                                  child: Swiper(
                                      control: _swiperControl,
                                      onIndexChanged: (index) {
                                        setState(() {
                                          _skinIndex = index;
                                        });
                                      },
                                      viewportFraction: 0.8,
                                      scale: 0.6,
                                      //轮播点
                                      pagination: SwiperPagination(
                                          builder: DotSwiperPaginationBuilder(
                                              color: Colors.grey,
                                              activeColor: Colors.white)),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: _skinList.length,
                                      itemBuilder: _itemImg)),
                              Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.all(10.0),
                                  child: Text(_getSkinName(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.0))),
                              Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.all(10.0),
                                  child: FlatButton(
                                    child: Text("Confirm Select"),
                                    padding: EdgeInsets.all(5.0),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0)),
                                    textColor: Colors.white,
                                    disabledTextColor: Colors.blueGrey,
                                    color: Colors.lightBlue,
                                    disabledColor: Colors.grey,
                                    highlightColor: Colors.brown,
                                    onPressed: () {
                                      Navigator.of(context).pop(
                                          _skinList[_skinIndex].skinImgUrl);
                                    },
                                  ))
                            ])))
              ]),
            )));
  }

  String _getSkinName() {
    if (_skinList.length == 0) {
      return "";
    }
    return _skinList[_skinIndex].skinName;
  }

  /**
   * getLegendSkins
   * */
  Future _getLegendSkins(String legendId) async {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });
    }
    Response _response = await Dio().get(
        "https://www.fastmock.site/mock/14630744ec2c11c6b04a1c0638c9a839/firsttest/api/getLegendSkinList?legendId=$legendId");
    setState(() {
      _isLoading = false;
      List<Datas> skins = lol_legend_skins.fromJson(_response.data).datas;
      if (skins != null) {
        _hasDatas = true;
        _skinList.clear();
        _skinList.addAll(lol_legend_skins.fromJson(_response.data).datas);
      } else {
        _hasDatas = false;
      }
    });
  }

  /**
   * item builder
   * */
  Widget _itemImg(context, index) {
    return Image.network(_skinList[index].skinImgUrl, fit: BoxFit.fill);
  }
}
