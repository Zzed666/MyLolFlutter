import 'package:flutter/material.dart';

class CustomCircleIcon extends StatefulWidget {
  final double iconWidth;
  final double iconHeight;
  final double iconCircleBorderWidth;
  final Color iconCircleBorderColor;
  final String iconUrl;

  CustomCircleIcon(
      {@required this.iconWidth,
      @required this.iconHeight,
      this.iconUrl,
      this.iconCircleBorderWidth: 0.0,
      this.iconCircleBorderColor: Colors.orangeAccent});

  @override
  _CustomCircleIconState createState() => _CustomCircleIconState();
}

class _CustomCircleIconState extends State<CustomCircleIcon> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.iconWidth,
      height: widget.iconHeight,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: widget.iconCircleBorderWidth, color: widget.iconCircleBorderColor),
          image: DecorationImage(image: _getImage(), fit: BoxFit.fill)),
    );
  }

  ImageProvider _getImage() {
    if (widget.iconUrl != null && widget.iconUrl.isNotEmpty) {
      return NetworkImage(widget.iconUrl);
    } else {
      return AssetImage("images/img_lol_app_bar_leading_defalut.jpg");
    }
  }
}
