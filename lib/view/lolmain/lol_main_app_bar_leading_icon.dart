import 'package:flutter/material.dart';

class LolMainAppBarLeadingIcon extends StatefulWidget {
  final double iconWidth;
  final double iconHeight;
  final String iconUrl;
  LolMainAppBarLeadingIcon({@required this.iconWidth,@required this.iconHeight,this.iconUrl});
  @override
  _LolMainAppBarLeadingIconState createState() => _LolMainAppBarLeadingIconState();
}

class _LolMainAppBarLeadingIconState extends State<LolMainAppBarLeadingIcon> {
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
        image: DecorationImage(
          image: _getImage(),
          fit: BoxFit.fill
        )
      ),
    );
  }
  ImageProvider _getImage(){
    if(widget.iconUrl != null && widget.iconUrl.isNotEmpty){
      return NetworkImage(widget.iconUrl);
    }else{
      return AssetImage("images/img_lol_app_bar_leading_defalut.jpg");
    }
  }
}
