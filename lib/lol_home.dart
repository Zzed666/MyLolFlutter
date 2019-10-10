import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app/beans/lol_legends_list.dart';

class LolHome extends StatefulWidget {
  @override
  _LolHomeState createState() => _LolHomeState();
}

class _LolHomeState extends State<LolHome> {
  List<Datas> _lolLegendsList = List();
  ScrollController _scrollController;
  bool isLoading = false;
  bool loadMore = false;
  int page = 0;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener((){
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
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
        body: RefreshIndicator(
            onRefresh: _getLolLegendsList,
            child: ListView.builder(
                itemCount: _lolLegendsList.length + 1,
                itemBuilder: _itemWidget,
                controller: _scrollController)));
  }

  Future _getLolLegendsList() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      if(loadMore){
        page++;
      }else{
        page = 1;
        _lolLegendsList.clear();
      }
      Response _response = await Dio().get(
          "https://www.fastmock.site/mock/14630744ec2c11c6b04a1c0638c9a839/firsttest/api/getLolLegendsList?page=$page");
      setState(() {
        List<Datas> _lolLegendDatas = lol_legends_list.fromJson(_response.data).datas;
        if(_lolLegendDatas != null) {
          _lolLegendsList.addAll(lol_legends_list
              .fromJson(_response.data)
              .datas);
        }else{
          print("暂无数据");
        }
        isLoading = false;
        loadMore = false;
      });
    }
  }

  Widget _itemWidget(context, index) {
    if (index < _lolLegendsList.length) {
      return Container(
          width: double.maxFinite,
          height: 180.0,
          child: Stack(children: <Widget>[
            ConstrainedBox(
                constraints: BoxConstraints.expand(),
                child: Image.network(_lolLegendsList[index].legendImageUrl,
                    fit: BoxFit.cover)),
            Positioned(
                left: 10.0,
                top: 10.0,
                child: Text(_lolLegendsList[index].legendName))
          ]));
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
}
