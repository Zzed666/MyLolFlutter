import 'package:flutter/material.dart';

class CustomClickButton extends StatefulWidget {
  final double btnWidth;
  final double btnHeight;
  final bool isEnable;
  final String btnText;
  final VoidCallback clickFunction;
  OnBtnEnableListener onBtnEnableListener;

  CustomClickButton(
      {Key key,
      this.isEnable,
      this.btnWidth,
      this.btnHeight,
      this.btnText,
      this.clickFunction})
      : super(key: key);

  @override
  _CustomClickButtonState createState() {
    _CustomClickButtonState _customClickButtonState = _CustomClickButtonState();
    return _customClickButtonState;
  }

  void addEnableListener(OnBtnEnableListener onBtnEnableListener) {
    this.onBtnEnableListener = onBtnEnableListener;
  }

  void setBtnEnable(bool enable) {
    if (onBtnEnableListener != null) {
      onBtnEnableListener.setEnable(enable);
    }
  }
}

class _CustomClickButtonState extends State<CustomClickButton>
    with OnBtnEnableListener {
  bool _isEnable;
  double _opacity;
  Color _btnTextColor;

  @override
  void initState() {
    _isEnable = widget.isEnable;
    _opacity = 1.0;
    _btnTextColor = Colors.white;
    widget.addEnableListener(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
        opacity: _opacity,
        child: Container(
          padding: EdgeInsets.all(5.0),
          constraints: BoxConstraints.expand(
              width:
                  (widget.btnWidth == null ? double.infinity : widget.btnWidth),
              height: (widget.btnHeight == null ? 0.0 : widget.btnHeight)),
          decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(width: 2.0, color: Colors.orange),
                  right: BorderSide(width: 2.0, color: Colors.orange),
                  bottom: BorderSide(width: 2.0, color: Colors.orange),
                  left: BorderSide(width: 2.0, color: Colors.orange)),
              borderRadius: BorderRadius.all(Radius.circular(2.0)),
              image: DecorationImage(
                  image: AssetImage("images/img_lol_btn_bg.png"),
                  fit: BoxFit.fill)),
          child: _getBtnTextWidget(),
        ));
  }

  Widget _getBtnTextWidget() {
    if (widget.btnText.isNotEmpty) {
      if (_isEnable) {
        return GestureDetector(
            onTapDown: (tapDownDetails) {
              setState(() {
                _opacity = 0.8;
                _btnTextColor = Colors.blueGrey;
              });
            },
            onTapUp: (tapUpDetails) {
              setState(() {
                _opacity = 1.0;
                _btnTextColor = Colors.white;
              });
            },
            onTapCancel: () {
              setState(() {
                _opacity = 1.0;
                _btnTextColor = Colors.white;
              });
            },
            onTap: widget.clickFunction,
            child: Center(
                child: Text(widget.btnText,
                    style: TextStyle(fontSize: 12.0, color: _btnTextColor))));
      } else {
        return Text(widget.btnText);
      }
    } else {
      return Text("");
    }
  }

  @override
  void setEnable(bool enable) {
    print("setEnable uneable");
    setState(() {
      _isEnable = enable;
    });
  }
}

abstract class OnBtnEnableListener {
  void setEnable(bool enable);
}
