import 'package:flutter/widgets.dart';

abstract class BaseViewModel{
  @protected
  Future refreshData(BuildContext context);
  
  void dispose();
}