// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rulings_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScryfallRulingResponse _$ScryfallRulingResponseFromJson(
        Map<String, dynamic> json) =>
    ScryfallRulingResponse(
      object: json['object'] as String?,
      hasMore: json['has_more'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Rulings.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ScryfallRulingResponseToJson(
        ScryfallRulingResponse instance) =>
    <String, dynamic>{
      'object': instance.object,
      'has_more': instance.hasMore,
      'data': instance.data,
    };

Rulings _$RulingsFromJson(Map<String, dynamic> json) => Rulings(
      object: json['object'] as String?,
      oracleId: json['oracle_id'] as String?,
      source: json['source'] as String?,
      publishedAt: json['published_at'] as String?,
      comment: json['comment'] as String?,
    );

Map<String, dynamic> _$RulingsToJson(Rulings instance) => <String, dynamic>{
      'object': instance.object,
      'oracle_id': instance.oracleId,
      'source': instance.source,
      'published_at': instance.publishedAt,
      'comment': instance.comment,
    };
