import 'package:flutter/material.dart';
import 'package:flutter_app/viewmodel/base_view_model.dart';

class ViewModelProvider<T extends BaseViewModel> extends StatefulWidget {
  final T viewmodel;
  final Widget child;

  ViewModelProvider({@required this.viewmodel, @required this.child});

  static T of<T extends BaseViewModel>(BuildContext context){
    final type = _typeof<ViewModelProvider<T>>();
    ViewModelProvider<T> provider = context.ancestorWidgetOfExactType(type);
    return provider.viewmodel;
  }

  static Type _typeof<T>() => T;

  @override
  _ViewModelProviderState createState() => _ViewModelProviderState();
}

class _ViewModelProviderState extends State<ViewModelProvider> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
  @override
  void dispose() {
    widget.viewmodel.dispose();
    super.dispose();
  }
}
