// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lol_legend_skins.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

lol_legend_skins _$lol_legend_skinsFromJson(Map<String, dynamic> json) {
  return lol_legend_skins(
    json['code'] as int,
    json['msg'] as String,
    (json['datas'] as List)
        ?.map(
            (e) => e == null ? null : Datas.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$lol_legend_skinsToJson(lol_legend_skins instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'datas': instance.datas,
    };

Datas _$DatasFromJson(Map<String, dynamic> json) {
  return Datas(
    json['skinName'] as String,
    json['skinImgUrl'] as String,
  );
}

Map<String, dynamic> _$DatasToJson(Datas instance) => <String, dynamic>{
      'skinName': instance.skinName,
      'skinImgUrl': instance.skinImgUrl,
    };
