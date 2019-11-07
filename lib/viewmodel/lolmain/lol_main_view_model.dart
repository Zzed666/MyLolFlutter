import 'package:flutter/material.dart';
import 'package:flutter_app/beans/lol_account_info/lol_account_info.dart';
import 'package:flutter_app/http/http_util.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_app/viewmodel/base_view_model.dart';

class LolMainViewModel extends BaseViewModel {
  // ignore: close_sinks
  BehaviorSubject<LolAccountInfoDatas> _lolMainAccountDataObserable =
      BehaviorSubject();

  Stream<LolAccountInfoDatas> get lolMainAccountDataStream =>
      _lolMainAccountDataObserable.stream;

  @override
  void dispose() {
    _lolMainAccountDataObserable.close();
  }

  @override
  Future refreshData(BuildContext context) async {
    HttpUtil.getInstance().get("/api/getMainAccountInfo?accountNumber=111111111", (responseData){
      LolAccountInfoDatas accountInfoDatas =
          lol_account_info.fromJson(responseData).datas;
      _lolMainAccountDataObserable.add(accountInfoDatas);
    });
  }

  @override
  void doInit(BuildContext context) {
    refreshData(context);
  }
}
