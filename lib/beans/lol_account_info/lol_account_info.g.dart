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
        : Datas.fromJson(json['datas'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$lol_account_infoToJson(lol_account_info instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'datas': instance.datas,
    };

Datas _$DatasFromJson(Map<String, dynamic> json) {
  return Datas(
    json['accountNumber'] as String,
    json['accountName'] as String,
    json['accountHeadPortrait'] as String,
    json['accountAge'] as int,
  );
}

Map<String, dynamic> _$DatasToJson(Datas instance) => <String, dynamic>{
      'accountNumber': instance.accountNumber,
      'accountName': instance.accountName,
      'accountHeadPortrait': instance.accountHeadPortrait,
      'accountAge': instance.accountAge,
    };
