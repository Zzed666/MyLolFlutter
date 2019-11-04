import 'package:flutter/material.dart';

class CustomUnReadRedTip extends StatefulWidget {
  final bool tipOffstage;
  final bool tipTextOffstage;
  final double tipWidth;
  final double tipHeight;
  final String tipText;
  final Color tipTextColor;
  final double tipTextSize;

  CustomUnReadRedTip(
      {this.tipOffstage: true,
      this.tipTextOffstage: true,
      this.tipWidth: 6.0,
      this.tipHeight: 6.0,
      this.tipText: "1",
      this.tipTextColor: Colors.white,
      this.tipTextSize = 4.0});

  @override
  _CustomUnReadRedTipState createState() => _CustomUnReadRedTipState();
}

class _CustomUnReadRedTipState extends State<CustomUnReadRedTip> {
  @override
  Widget build(BuildContext context) {
    return Offstage(
        offstage: widget.tipOffstage,
        child: Container(
            width: widget.tipWidth,
            height: widget.tipHeight,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.red),
            child: Center(
                child: Offstage(
                    offstage: widget.tipTextOffstage,
                    child: Text(widget.tipText,
                        style: TextStyle(
                            color: widget.tipTextColor,
                            fontSize: widget.tipTextSize))))));
  }
}
