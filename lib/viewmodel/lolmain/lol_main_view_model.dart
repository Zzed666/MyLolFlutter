import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/beans/lol_account_info/lol_account_info.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_app/viewmodel/base_view_model.dart';

class LolMainViewModel extends BaseViewModel{
  // ignore: close_sinks
  BehaviorSubject<Datas> _lolMainAccountDataObserable = BehaviorSubject();
  Stream<Datas> get lolMainAccountDataStream => _lolMainAccountDataObserable.stream;

  @override
  void dispose() {
    _lolMainAccountDataObserable.close();
  }

  @override
  Future refreshData(BuildContext context) async{
    Response _response = await Dio().get(
        "https://www.fastmock.site/mock/14630744ec2c11c6b04a1c0638c9a839/firsttest/api/getMainAccountInfo?accountNumber=111111111");
    Datas accountDatas = lol_account_info.fromJson(_response.data).datas;
    _lolMainAccountDataObserable.add(accountDatas);
  }

  @override
  void doInit(BuildContext context) {
    refreshData(context);
  }

}