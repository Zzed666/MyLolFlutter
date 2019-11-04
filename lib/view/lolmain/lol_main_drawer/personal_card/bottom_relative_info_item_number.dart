import 'package:flutter/material.dart';

class RelativeInfoItemNumber extends StatefulWidget {
  final int numberValue;

  RelativeInfoItemNumber({this.numberValue: 0});

  @override
  _RelativeInfoItemNumberState createState() => _RelativeInfoItemNumberState();
}

//TODO setState会造成widget重绘，将要做改变的小widget分割成更小的widget可尽量避免，https://www.codercto.com/a/58079.html
class _RelativeInfoItemNumberState extends State<RelativeInfoItemNumber> {
  int _numberValue;

  @override
  void initState() {
    _numberValue = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _getNumberText();
  }

  _setNumber() {
    setState(() {
      _numberValue = (widget.numberValue == null ? 0 : widget.numberValue);
    });
  }

  Widget _getNumberText() {
    _setNumber();
    return Text("$_numberValue",
        style: TextStyle(color: Colors.orangeAccent, fontSize: 14.0));
  }
}
