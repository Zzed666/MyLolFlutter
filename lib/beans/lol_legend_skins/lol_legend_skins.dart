import 'package:json_annotation/json_annotation.dart';

part 'lol_legend_skins.g.dart';


@JsonSerializable()
class lol_legend_skins extends Object{

  @JsonKey(name: 'code')
  int code;

  @JsonKey(name: 'msg')
  String msg;

  @JsonKey(name: 'datas')
  List<Datas> datas;

  lol_legend_skins(this.code,this.msg,this.datas,);

  factory lol_legend_skins.fromJson(Map<String, dynamic> srcJson) => _$lol_legend_skinsFromJson(srcJson);

}


@JsonSerializable()
class Datas extends Object{

  @JsonKey(name: 'skinName')
  String skinName;

  @JsonKey(name: 'skinImgUrl')
  String skinImgUrl;

  Datas(this.skinName,this.skinImgUrl,);

  factory Datas.fromJson(Map<String, dynamic> srcJson) => _$DatasFromJson(srcJson);

}