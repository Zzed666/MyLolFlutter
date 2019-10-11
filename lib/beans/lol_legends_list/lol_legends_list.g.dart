// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lol_legends_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

lol_legends_list _$lol_legends_listFromJson(Map<String, dynamic> json) {
  return lol_legends_list(
    json['code'] as int,
    json['msg'] as String,
    (json['datas'] as List)
        ?.map(
            (e) => e == null ? null : Datas.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$lol_legends_listToJson(lol_legends_list instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'datas': instance.datas,
    };

Datas _$DatasFromJson(Map<String, dynamic> json) {
  return Datas(
    json['legendId'] as String,
    json['legendName'] as String,
    json['legendAge'] as int,
    json['legendPosition'] as String,
    json['legendWords'] as String,
    json['legendImageUrl'] as String,
  );
}

Map<String, dynamic> _$DatasToJson(Datas instance) => <String, dynamic>{
      'legendId': instance.legendId,
      'legendName': instance.legendName,
      'legendAge': instance.legendAge,
      'legendPosition': instance.legendPosition,
      'legendWords': instance.legendWords,
      'legendImageUrl': instance.legendImageUrl,
    };
