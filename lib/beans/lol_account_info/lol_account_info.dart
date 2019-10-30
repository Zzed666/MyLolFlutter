import 'package:json_annotation/json_annotation.dart';

part 'lol_account_info.g.dart';


@JsonSerializable()
class lol_account_info extends Object {

  @JsonKey(name: 'code')
  int code;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'datas')
  Datas datas;

  lol_account_info(this.code,this.message,this.datas);

  factory lol_account_info.fromJson(Map<String, dynamic> srcJson) => _$lol_account_infoFromJson(srcJson);

}


@JsonSerializable()
class Datas extends Object {

  @JsonKey(name: 'accountNumber')
  String accountNumber;

  @JsonKey(name: 'accountName')
  String accountName;

  @JsonKey(name: 'accountHeadPortrait')
  String accountHeadPortrait;

  @JsonKey(name: 'accountAge')
  int accountAge;

  Datas(this.accountNumber,this.accountName,this.accountHeadPortrait,this.accountAge);

  factory Datas.fromJson(Map<String, dynamic> srcJson) => _$DatasFromJson(srcJson);

}