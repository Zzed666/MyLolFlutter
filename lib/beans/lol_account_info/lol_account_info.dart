import 'package:json_annotation/json_annotation.dart';

part 'lol_account_info.g.dart';


@JsonSerializable()
class lol_account_info extends Object{

  @JsonKey(name: 'code')
  int code;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'datas')
  LolAccountInfoDatas datas;

  lol_account_info(this.code,this.message,this.datas,);

  factory lol_account_info.fromJson(Map<String, dynamic> srcJson) => _$lol_account_infoFromJson(srcJson);

}


@JsonSerializable()
class LolAccountInfoDatas extends Object{

  @JsonKey(name: 'accountNumber')
  String accountNumber;

  @JsonKey(name: 'accountName')
  String accountName;

  @JsonKey(name: 'accountHeadPortrait')
  String accountHeadPortrait;

  @JsonKey(name: 'accountAge')
  int accountAge;

  @JsonKey(name: 'accountGender')
  String accountGender;

  @JsonKey(name: 'accountLevel')
  int accountLevel;

  @JsonKey(name: 'accountPersonal')
  AccountPersonal accountPersonal;

  @JsonKey(name: 'accountUnread')
  AccountUnread accountUnread;

  LolAccountInfoDatas(this.accountNumber,this.accountName,this.accountHeadPortrait,this.accountAge,this.accountGender,this.accountLevel,this.accountPersonal,this.accountUnread,);

  factory LolAccountInfoDatas.fromJson(Map<String, dynamic> srcJson) => _$DatasFromJson(srcJson);

}


@JsonSerializable()
class AccountPersonal extends Object{

  @JsonKey(name: 'attentions')
  int attentions;

  @JsonKey(name: 'fans')
  int fans;

  @JsonKey(name: 'goodFriends')
  int goodFriends;

  @JsonKey(name: 'publishes')
  int publishes;

  AccountPersonal(this.attentions,this.fans,this.goodFriends,this.publishes,);

  factory AccountPersonal.fromJson(Map<String, dynamic> srcJson) => _$AccountPersonalFromJson(srcJson);

}


@JsonSerializable()
class AccountUnread extends Object{

  @JsonKey(name: 'relations')
  int relations;

  @JsonKey(name: 'actions')
  int actions;

  @JsonKey(name: 'orders')
  int orders;

  @JsonKey(name: 'tasks')
  int tasks;

  @JsonKey(name: 'collections')
  int collections;

  @JsonKey(name: 'hasSettings')
  bool hasSettings;

  @JsonKey(name: 'hasDiscovers')
  bool hasDiscovers;

  AccountUnread(this.relations,this.actions,this.orders,this.tasks,this.collections,this.hasSettings,this.hasDiscovers,);

  factory AccountUnread.fromJson(Map<String, dynamic> srcJson) => _$AccountUnreadFromJson(srcJson);

}