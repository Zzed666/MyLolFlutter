import 'dart:collection';

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
  Map<String, dynamic> _nameLevelGenderMap = HashMap();
  Color _genderColor;

  @override
  void initState() {
    _nameLevelGenderMap["level"] = widget.level;
    _nameLevelGenderMap["gender"] = widget.gender;
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
        child: __getTagItemChild(tagName));
  }

  Widget __getTagItemChild(String tagName) {
    var value = _nameLevelGenderMap[tagName];
    // ignore: null_aware_in_condition
    if (tagName?.contains("level")) {
      return Center(
          child: Text("lv$value",
              style: TextStyle(fontSize: 8.0, color: _genderColor)));
      // ignore: null_aware_in_condition
    } else if (tagName?.contains("gender")) {
      _setGenderColor(value);
      return Icon(Icons.person, size: 8.0, color: _genderColor);
    }
    return null;
  }

  _setGenderColor(String gender) {
    setState(() {
      _genderColor = (gender == "男") ? Colors.lightBlue : Colors.pinkAccent;
    });
  }
}
