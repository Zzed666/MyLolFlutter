import 'package:flutter/widgets.dart';

abstract class BaseViewModel{
  bool _isFirst;
  bool get isFirst=>_isFirst;
  @mustCallSuper
  void init(BuildContext context) {
    if (_isFirst) {
      _isFirst = false;
      doInit(context);
    }
  }

  @protected
  Future refreshData(BuildContext context);

  @protected
  void doInit(BuildContext context);
  
  void dispose();
}