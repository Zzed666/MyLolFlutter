import 'package:json_annotation/json_annotation.dart';

part 'lol_legends_list.g.dart';


@JsonSerializable()
class lol_legends_list extends Object{

  @JsonKey(name: 'code')
  int code;

  @JsonKey(name: 'msg')
  String msg;

  @JsonKey(name: 'datas')
  List<Datas> datas;

  lol_legends_list(this.code,this.msg,this.datas);

  factory lol_legends_list.fromJson(Map<String, dynamic> srcJson) => _$lol_legends_listFromJson(srcJson);

}


@JsonSerializable()
class Datas extends Object{

  @JsonKey(name: 'legendId')
  String legendId;

  @JsonKey(name: 'legendName')
  String legendName;

  @JsonKey(name: 'legendAge')
  int legendAge;

  @JsonKey(name: 'legendPosition')
  String legendPosition;

  @JsonKey(name: 'legendWords')
  String legendWords;

  @JsonKey(name: 'legendImageUrl')
  String legendImageUrl;

  Datas(this.legendId,this.legendName,this.legendAge,this.legendPosition,this.legendWords,this.legendImageUrl);

  factory Datas.fromJson(Map<String, dynamic> srcJson) => _$DatasFromJson(srcJson);

}