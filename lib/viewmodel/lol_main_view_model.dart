import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_app/viewmodel/base_view_model.dart';

class LolMainViewModel extends BaseViewModel{
  // ignore: close_sinks
  BehaviorSubject<String> _lolMainDataObserable = BehaviorSubject();
  Stream<String> get lolMainDataStream => _lolMainDataObserable.stream;

  @override
  void dispose() {
    _lolMainDataObserable.close();
  }

  @override
  Future refreshData(BuildContext context) {
    // TODO: implement refreshData
    return null;
  }

}