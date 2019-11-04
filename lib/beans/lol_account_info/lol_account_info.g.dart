// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lol_account_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

lol_account_info _$lol_account_infoFromJson(Map<String, dynamic> json) {
  return lol_account_info(
    json['code'] as int,
    json['message'] as String,
    json['datas'] == null
        ? null
        : LolAccountInfoDatas.fromJson(json['datas'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$lol_account_infoToJson(lol_account_info instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'datas': instance.datas,
    };

LolAccountInfoDatas _$DatasFromJson(Map<String, dynamic> json) {
  return LolAccountInfoDatas(
    json['accountNumber'] as String,
    json['accountName'] as String,
    json['accountHeadPortrait'] as String,
    json['accountAge'] as int,
    json['accountGender'] as String,
    json['accountLevel'] as int,
    json['accountPersonal'] == null
        ? null
        : AccountPersonal.fromJson(
            json['accountPersonal'] as Map<String, dynamic>),
    json['accountUnread'] == null
        ? null
        : AccountUnread.fromJson(json['accountUnread'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$DatasToJson(LolAccountInfoDatas instance) => <String, dynamic>{
      'accountNumber': instance.accountNumber,
      'accountName': instance.accountName,
      'accountHeadPortrait': instance.accountHeadPortrait,
      'accountAge': instance.accountAge,
      'accountGender': instance.accountGender,
      'accountLevel': instance.accountLevel,
      'accountPersonal': instance.accountPersonal,
      'accountUnread': instance.accountUnread,
    };

AccountPersonal _$AccountPersonalFromJson(Map<String, dynamic> json) {
  return AccountPersonal(
    json['attentions'] as int,
    json['fans'] as int,
    json['goodFriends'] as int,
    json['publishes'] as int,
  );
}

Map<String, dynamic> _$AccountPersonalToJson(AccountPersonal instance) =>
    <String, dynamic>{
      'attentions': instance.attentions,
      'fans': instance.fans,
      'goodFriends': instance.goodFriends,
      'publishes': instance.publishes,
    };

AccountUnread _$AccountUnreadFromJson(Map<String, dynamic> json) {
  return AccountUnread(
    json['relations'] as int,
    json['actions'] as int,
    json['orders'] as int,
    json['tasks'] as int,
    json['collections'] as int,
    json['hasSettings'] as bool,
    json['hasDiscovers'] as bool,
  );
}

Map<String, dynamic> _$AccountUnreadToJson(AccountUnread instance) =>
    <String, dynamic>{
      'relations': instance.relations,
      'actions': instance.actions,
      'orders': instance.orders,
      'tasks': instance.tasks,
      'collections': instance.collections,
      'hasSettings': instance.hasSettings,
      'hasDiscovers': instance.hasDiscovers,
    };
