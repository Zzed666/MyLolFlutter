import 'package:flutter/material.dart';

class NameLevelGender extends StatefulWidget {
  final String name;
  final int level;
  final String gender;

  NameLevelGender({this.name: "User001", this.level: 1, this.gender: "男"});

  @override
  _NameLevelGenderState createState() => _NameLevelGenderState();
}

class _NameLevelGenderState extends State<NameLevelGender> {
  bool _hasDelayedLevelText;
  bool _hasDelayedGenderColor;
  String _levelText;
  Color _genderColor;

  @override
  void initState() {
    _hasDelayedLevelText = false;
    _hasDelayedGenderColor = false;
    _levelText = "lv0";
    _genderColor = Colors.lightBlue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints(maxHeight: 20.0),
        margin: EdgeInsets.only(top: 40.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(widget.name,
                  style: TextStyle(fontSize: 15.0, color: Colors.white)),
              _getTagItem("level"),
              _getTagItem("gender")
            ]));
  }

  Widget _getTagItem(String tagName) {
    return Container(
        height: 15.0,
        padding: EdgeInsets.all(2.0),
        margin: EdgeInsets.only(left: 10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(3.0)),
        ),
        child: _getTagItemChild(tagName));
  }

  Widget _getTagItemChild(String tagName) {
    // ignore: null_aware_in_condition
    if (tagName?.contains("level")) {
      /*原因是因为控件还没有构建完毕，延时加载即可解决问题*/
      /*这里要延时加载  否则会抱The widget on which setState() or markNeedsBuild() was called was:错误*/
      /*setState会重新执行widget build方法，延时操作会无线循环，所以设置bool值控制*/
      if (!_hasDelayedLevelText) {
        _hasDelayedLevelText = true;
        Future.delayed(Duration(milliseconds: 200)).then((e) {
          _setLevelText();
        });
      }
      return Center(
          child: Text(_levelText,
              style: TextStyle(fontSize: 8.0, color: _genderColor)));
      // ignore: null_aware_in_condition
    } else if (tagName?.contains("gender")) {
      /*原因是因为控件还没有构建完毕，延时加载即可解决问题*/
      /*这里要延时加载  否则会抱The widget on which setState() or markNeedsBuild() was called was:错误*/
      if (!_hasDelayedGenderColor) {
        _hasDelayedGenderColor = true;
        Future.delayed(Duration(milliseconds: 200)).then((e) {
          _setGenderColor(widget.gender);
        });
      }
      return Icon(Icons.person, size: 8.0, color: _genderColor);
    }
    return null;
  }

  _setLevelText() {
    setState(() {
      _levelText = (widget.level == null) ? "lv0" : "lv${widget.level}";
    });
  }

  _setGenderColor(String gender) {
    setState(() {
      _genderColor = (gender == "男") ? Colors.lightBlue : Colors.pinkAccent;
    });
  }
}
