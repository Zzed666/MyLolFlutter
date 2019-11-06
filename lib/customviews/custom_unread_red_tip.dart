import 'package:flutter/material.dart';
import 'package:flutter_app/view/view_share_widget.dart';

class CustomUnReadRedTip extends StatefulWidget {
  final String fromType;
  final int tipIndex;
  final bool tipVisiable;
  final bool tipTextVisiable;
  final double tipWidth;
  final double tipHeight;
  final String tipText;
  final Color tipTextColor;
  final double tipTextSize;

  CustomUnReadRedTip(
      {this.fromType: "default",
      this.tipIndex: 0,
      this.tipVisiable: false,
      this.tipTextVisiable: false,
      this.tipWidth: 6.0,
      this.tipHeight: 6.0,
      this.tipText: "1",
      this.tipTextColor: Colors.white,
      this.tipTextSize = 2.0});

  @override
  _CustomUnReadRedTipState createState() => _CustomUnReadRedTipState();
}

class _CustomUnReadRedTipState extends State<CustomUnReadRedTip> {
  bool _tipVisiable;
  bool _parentItemRead;

  @override
  void initState() {
    _tipVisiable = false;
    _parentItemRead = false;
    super.initState();
  }

  /**
   * 如果依赖的InheritedWidget改变了，framework将会调用这个方法来通知这个对象。
   * 在这个方法中调用BuildContext.inheritFromWidgetOfExactType是安全的。
   * 子类很少覆写这个方法，因为framework通常会在依赖的InheritedWidget改变后调用build方法，
   * 覆写这个方法通常用来做一些耗时的工作，比如网络请求
   */
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    switch (widget.fromType) {
      case "mine_list":
        Map<String, Map<int, bool>> data = ViewShareWidget.of(context).data;
        Map<int, bool> dataValue = data["mineListItemReadData"];
        bool parentItemRead = dataValue[widget.tipIndex];
        print(
            "mine_list item index ${widget.tipIndex} parentItemRead : $parentItemRead");
        if (parentItemRead) {
          setState(() {
            _parentItemRead = true;
          });
        }
        break;
      case "bottom_setting_discover":
        Map<String, Map<int, bool>> data = ViewShareWidget.of(context).data;
        Map<int, bool> dataValue = data["settingDiscoverItemReadData"];
        bool parentItemRead = dataValue[widget.tipIndex];
        print(
            "bottom_setting_discover item index ${widget.tipIndex} parentItemRead : $parentItemRead");
        if (parentItemRead) {
          setState(() {
            _parentItemRead = true;
          });
        }
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _getTipWidgetFromTypes();
  }

  Widget _getTipWidgetFromTypes() {
    switch (widget.fromType) {
      case "mine_list":
      case "bottom_setting_discover":
        _tipVisiable = widget.tipVisiable && !_parentItemRead;
        break;
      default:
        break;
    }
    return _getTipWidgetDefault();
  }

  Widget _getTipWidgetDefault() {
    return Offstage(
        offstage: !_tipVisiable,
        child: Container(
            width: widget.tipWidth,
            height: widget.tipHeight,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.red),
            child: Center(
                child: Offstage(
                    offstage: !widget.tipTextVisiable,
                    child: Text(widget.tipText,
                        style: TextStyle(
                            color: widget.tipTextColor,
                            fontSize: widget.tipTextSize))))));
  }
}
