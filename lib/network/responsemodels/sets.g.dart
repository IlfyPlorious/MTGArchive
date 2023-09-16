// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sets.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SetsResponse _$SetsResponseFromJson(Map<String, dynamic> json) => SetsResponse(
      sets: (json['sets'] as List<dynamic>?)
          ?.map((e) => Set.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SetsResponseToJson(SetsResponse instance) =>
    <String, dynamic>{
      'sets': instance.sets,
    };

Set _$SetFromJson(Map<String, dynamic> json) => Set(
      code: json['code'] as String?,
      name: json['name'] as String?,
      type: json['type'] as String?,
      booster: json['booster'] as List<dynamic>?,
      releaseDate: json['releaseDate'] as String?,
      block: json['block'] as String?,
      onlineOnly: json['onlineOnly'] as bool?,
    );

Map<String, dynamic> _$SetToJson(Set instance) => <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'type': instance.type,
      'booster': instance.booster,
      'releaseDate': instance.releaseDate,
      'block': instance.block,
      'onlineOnly': instance.onlineOnly,
    };
